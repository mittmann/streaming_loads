#define _GNU_SOURCE
#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <immintrin.h>
#include <stdint.h>
#include <unistd.h>
#include <papi.h>
#include <string.h>
#include <pthread.h>

#define PAGE_SIZE (sysconf(_SC_PAGESIZE))
#define PAGE_MASK (~(PAGE_SIZE - 1))

struct arg_struct {
	unsigned size;
	long long unsigned reps;
	long long unsigned value[3];
	int temporal;
	int *eventcodes;
	__m256i *mem;
	__m256i *acc;
	cpu_set_t cpuset;
};

void fail(char* msg)
{
	fprintf(stderr, "%s\n", msg);
	exit(-1); 

}
void *get_uncached_mem(char *dev, int size)
{	
	
	int fd = open(dev, O_RDWR, 0);
	if (fd == -1) printf("%s","couldn't open device");
	
	//printf("mmap()'ing %s\n", dev);

	if (size & ~PAGE_MASK)
		size = (size & PAGE_MASK) + PAGE_SIZE;

	void *map = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (map == MAP_FAILED)
		printf("%s","mmap failed.");
	return map;
}

void *read_stream(void* arg) {
	int EventSet = PAPI_NULL;
	struct arg_struct *args = (struct arg_struct *) arg;
	pthread_t current = pthread_self();
	pthread_setaffinity_np(current, sizeof(cpu_set_t), &(args->cpuset));
	/*if (CPU_ISSET(2,&(args->cpuset)))
		usleep(4000);*/
	if (PAPI_create_eventset(&EventSet) != PAPI_OK)
		fail("PAPI_create_eventset falhou");
	if (PAPI_add_events(EventSet,args->eventcodes, 3) != PAPI_OK)
		fail("PAPI_add_events falhou");	
	if (PAPI_start(EventSet) != PAPI_OK)
		fail("PAPI_start falhou");
	__m256i local __attribute__((aligned(64)));
	__m256i acc __attribute__((aligned(64)));
	__m256i *mem = args->mem;
	acc = _mm256_set1_epi64x(0);
//	printf("mem: %p\n", mem);
	if (args->temporal)
		for(int j=0;j<args->reps;j++)
			for(int i=0; i<args->size; i+=2)
			{
				local = _mm256_load_si256(&mem[i]);
				acc = _mm256_add_epi64(acc, local);
			}
	else
		for(int j=0;j<args->reps;j++)
			for(int i=0; i<args->size; i+=2)
			{
				local = _mm256_stream_load_si256(&mem[i]);
				acc = _mm256_add_epi64(acc, local);
			}
	(args->acc)[0] = acc;
	if (PAPI_stop(EventSet, args->value) != PAPI_OK)
		fail("PAPI_stop falhou");
	PAPI_remove_events(EventSet, args->eventcodes, 3);
}


int main(int ac, char **av)
{

	void *map __attribute__((aligned(64)));
	__m256i tempa, tempb;

	long long unsigned value[3];
	int eventcode;
	int eventcodes[3];
//	int EventSet = PAPI_NULL;
	struct arg_struct args_a;
	struct arg_struct args_b;
	args_a.acc = &tempa; // reserva memoria pros accs de retorno de cada thread
	args_b.acc = &tempb;

	pthread_t th1, th2;
	if(ac < 9)
	{
		fail("qtd errada de args <TAMANHO_A REPS_A TIPO_A TEMP_A TAMANHO_B REPS_B TIPO_B TEMP_B> <opt: 3 counters papi>");
	}

//// ARGS A
		args_a.size = atoi(av[1])*32; //igual a *1024/32 pra dar o numero de elementos em kb
		args_a.reps = atoll(av[2]);
	int size = args_a.size;

	if(!strcmp(av[3],"unc")) 
		if ( args_a.size/32 > 128)
			args_a.mem = (__m256i*)get_uncached_mem("unc", args_a.size*32);
		else
			args_a.mem = (__m256i*)get_uncached_mem("unc", 1024*128);
	else if(!strcmp(av[3],"wc")) 
		if ( args_a.size/32 > 128)
			args_a.mem = (__m256i*)get_uncached_mem("wc", args_a.size*32);
		else
			args_a.mem = (__m256i*)get_uncached_mem("wc", 1024*128);
		
	else if(!strcmp(av[3],"wb"))
		//args_a.mem = (__m256i*)aligned_alloc(64,(size_t)(args_b.size*32));

		//map = aligned_alloc(64, size*32);
		args_a.mem = (__m256i*)_mm_malloc(args_a.size*32, 64);
	else
	{
		fail("tipo de mem invalido");
	}
	//args_a.mem = ((__m256i*)map);
	//printf("map: %p, args_a.size*32: %lld, size: %d\n", map, args_a.size*32, size);
	//args_a.mem = map;

	if(!strcmp(av[4],"nt"))
		args_a.temporal = 0;
	else if(!strcmp(av[4],"t"))
		args_a.temporal = 1;
	else
	{
		fail("temporalidade invalida");
	}

//// ARGS B
		args_b.size = atoi(av[5])*32;
		args_b.reps = atoll(av[6]);

	if(!strcmp(av[7],"unc")) 
		if ( args_b.size/32 > 128)
			args_b.mem = (__m256i*)get_uncached_mem("unc", args_b.size*32);
		else
			args_b.mem = (__m256i*)get_uncached_mem("unc", 1024*128);
	else if(!strcmp(av[7],"wc")) 
		if ( args_b.size/32 > 128)
			args_b.mem = (__m256i*)get_uncached_mem("wc", args_b.size*32);
		else
			args_b.mem = (__m256i*)get_uncached_mem("wc", 1024*128);
	else if(!strcmp(av[7],"wb"))
		//args_b.mem = (__m256i*)aligned_alloc(64,(size_t)(args_b.size*32));
		args_b.mem = (__m256i*)_mm_malloc(args_b.size*32, 64);
	else
	{
		fail("tipo de mem invalido");
	}

	//args_b.mem = ((__m256i*)map);

	if(!strcmp(av[8],"nt"))
		args_b.temporal = 0;
	else if(!strcmp(av[8],"t"))
		args_b.temporal = 1;
	else
	{
		fail("temporalidade invalida");
	}
		
////


	CPU_ZERO(&(args_a.cpuset)); CPU_ZERO(&(args_a.cpuset));
	CPU_SET(2, &(args_a.cpuset)); CPU_SET(3, &(args_b.cpuset));
	

	if (PAPI_library_init(PAPI_VER_CURRENT) != PAPI_VER_CURRENT)
	{
		if(PAPI_library_init(PAPI_VER_CURRENT) == PAPI_EINVAL)
			puts("papi_einval");
		fail("papi library init falhou");
	}
	if ( ac == 9 ) {
		if( PAPI_event_name_to_code("PAPI_TOT_CYC", &eventcode) != PAPI_OK )
			fail("PAPI_event_name_to_code falhou cyc");
		eventcodes[0] = eventcode;
		if( PAPI_event_name_to_code("PAPI_L3_TCM", &eventcode) != PAPI_OK )
			fail("PAPI_event_name_to_code falhou tcm");
		eventcodes[1] = eventcode;
		if( PAPI_event_name_to_code("PAPI_L3_TCR", &eventcode) != PAPI_OK )
			fail("PAPI_event_name_to_code falhou tcr");
		eventcodes[2] = eventcode;
	}
	else if ( ac == 12 ) {
		if( PAPI_event_name_to_code(av[9], &eventcode) != PAPI_OK )
			fail("PAPI_event_name_to_code falhou 1");
		eventcodes[0] = eventcode;
		if( PAPI_event_name_to_code(av[10], &eventcode) != PAPI_OK )
			fail("PAPI_event_name_to_code falhou 2");
		eventcodes[1] = eventcode;
		if( PAPI_event_name_to_code(av[11], &eventcode) != PAPI_OK )
			fail("PAPI_event_name_to_code falhou 3");
		eventcodes[2] = eventcode;
	}
	else
		fail("quantidade invalida de argumentos");
	
	args_a.eventcodes = eventcodes;
	args_b.eventcodes = eventcodes;

	_mm_mfence();

//	__m256i *mem = ((__m256i*)map);

	
	printf("usable a: %u, usable b: %u\n", malloc_usable_size(args_a.mem), malloc_usable_size(args_b.mem));
	
	printf("size a: %u, mem a: %p\n", args_a.size, args_a.mem);
	printf("size b: %u, mem b: %p\n", args_b.size, args_b.mem);
	for(uint64_t i=0; i<args_a.size; i++)
	{
		//printf("i: %ld - ", i);
		__m256i local __attribute__((aligned(64)));
		local = _mm256_set1_epi64x(i);
		_mm256_stream_si256(&(args_a.mem[i]), local);
	}
	_mm_mfence();
	for(int i=0; i<args_a.size; i+=2)
		_mm_clflush((args_a.mem + i));
	_mm_mfence();


	for(uint64_t i=0; i<args_b.size; i++)
	{
		__m256i local __attribute__((aligned(64)));
		local = _mm256_set1_epi64x(i);
		_mm256_stream_si256((args_b.mem + i), local);
	}
	_mm_mfence();
	for(int i=0; i<args_b.size; i+=2)
		_mm_clflush((args_b.mem + i));

	_mm_mfence();

/*	if (PAPI_create_eventset(&EventSet) != PAPI_OK)
		fail("PAPI_create_eventset falhou");
	if (PAPI_add_events(EventSet,eventcodes, 3) != PAPI_OK)
		fail("PAPI_add_events falhou");	
	if (PAPI_start(EventSet) != PAPI_OK)
		fail("PAPI_start falhou");
*/
	pthread_create(&th1, NULL, read_stream, &args_a);
	pthread_create(&th2, NULL, read_stream, &args_b);

	pthread_join(th1, NULL);
	pthread_join(th2, NULL);

	_mm_mfence();
/*	if (PAPI_stop(EventSet, value) != PAPI_OK)
		fail("PAPI_stop falhou");
	PAPI_remove_events(EventSet, eventcodes, 3);
*/
	PAPI_shutdown();

	char event1[128],event2[128],event3[128];
	PAPI_event_code_to_name(eventcodes[0],event1);
	PAPI_event_code_to_name(eventcodes[1],event2);
	PAPI_event_code_to_name(eventcodes[2],event3);
	printf("acc_a: %llu, reps_a: %llu, size_a: %uKB \n", (long long unsigned)(args_a.acc)[0][0], args_a.reps, args_a.size*32/1024);
	printf("acc_b: %llu, reps_b: %llu, size_b: %uKB \n", (long long unsigned)(args_b.acc)[0][0], args_b.reps, args_b.size*32/1024);
	printf("PAPI_THREAD_A:%s:%llu\n", event1, args_a.value[0]);
	printf("PAPI_THREAD_A:%s:%llu\n", event2, args_a.value[1]);
	printf("PAPI_THREAD_A:%s:%llu\n", event3, args_a.value[2]);
	printf("PAPI_THREAD_B:%s:%llu\n", event1, args_b.value[0]);
	printf("PAPI_THREAD_B:%s:%llu\n", event2, args_b.value[1]);
	printf("PAPI_THREAD_B:%s:%llu\n", event3, args_b.value[2]);
	return (long long unsigned)(args_a.acc)[0][0] + (long long unsigned)(args_b.acc)[0][0];

}
