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
#define BUF_SIZE 1024*1024*1024

int nevents = 3;

struct arg_struct {
	unsigned size;
	long long unsigned reps;
	long long value[3];
	int temporal;
	int equal;
	int *eventcodes;
	__m256i *mem;
	__m256i *acc;
	cpu_set_t cpuset;
	int delay;
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
	unsigned int size, reps;
	struct arg_struct *args = (struct arg_struct *) arg;
	pthread_t current = pthread_self();
	pthread_setaffinity_np(current, sizeof(cpu_set_t), &(args->cpuset));
	size = args->size;
	reps = args->reps;
	/*if (CPU_ISSET(2,&(args->cpuset)))
		usleep(4000);*/
	asm volatile ("nop"::: "memory");
	if (PAPI_create_eventset(&EventSet) != PAPI_OK)
		fail("PAPI_create_eventset falhou");
	if (PAPI_add_events(EventSet,args->eventcodes, nevents) != PAPI_OK)
		fail("PAPI_add_events falhou");	
	if (PAPI_start(EventSet) != PAPI_OK)
		fail("PAPI_start falhou");
	asm volatile ("nop"::: "memory");
	__m256i local __attribute__((aligned(64)));
	__m256i acc __attribute__((aligned(64)));
	__m256i *mem = args->mem;
	acc = _mm256_set1_epi64x(0);
//	printf("mem: %p\n", mem);
	if (!args->temporal)
		for(unsigned int j=0;j<reps;j++)
			for(unsigned int i=0; i<size; i+=2)
			{
				local = _mm256_stream_load_si256(&mem[i]);
				acc = _mm256_add_epi64(acc, local);
			}
	else
		if(args->equal)
			for(unsigned int j=0;j<reps;j++)
				for(unsigned int i=0; i<size; i+=2)
				{
					local = _mm256_load_si256(&mem[i]);
					asm volatile (""::: "memory");
					acc = _mm256_add_epi64(acc, local);
				}
		else
			for(unsigned int j=0;j<reps;j++)
				for(unsigned int i=0; i<size; i+=2)
				{
					local = _mm256_load_si256(&mem[i]);
					acc = _mm256_add_epi64(acc, local);
				}
	(args->acc)[0] = acc;
	asm volatile ("nop"::: "memory");
	if (PAPI_stop(EventSet, args->value) != PAPI_OK)
		fail("PAPI_stop falhou");
	PAPI_remove_events(EventSet, args->eventcodes, nevents);
	return 0;
}


int main(int ac, char **av)
{
	__m256i tempa, tempb;

	int eventcode;
	int eventcodes[3];
//	int EventSet = PAPI_NULL;
	struct arg_struct args_a;
	struct arg_struct args_b;
	args_a.acc = &tempa; // reserva memoria pros accs de retorno de cada thread
	args_b.acc = &tempb;

	int core1, core2;

	pthread_t th1, th2;
/*	if(ac < 13 || ac > 15)
		fail("qtd errada de args <TAMANHO_A REPS_A TIPO_A TEMP_A TAMANHO_B REPS_B TIPO_B TEMP_B CORE_1 CORE_2 DELAY_1 DELAY_2> <opt: 3 PAPI counters>");
*/
	if(ac < 11 || ac > 13)
		fail("qtd errada de args <TAMANHO_A REPS_A TIPO_A TEMP_A TAMANHO_B REPS_B TIPO_B TEMP_B CORE_1 CORE_2 > <opt: 3 PAPI counters>");
//// ARGS A
		args_a.size = atoi(av[1])*32; //igual a *1024/32 pra dar o numero de elementos em kb
		args_a.reps = atoll(av[2]);

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

	if(!strcmp(av[4],"n"))
		args_a.temporal = 0;
	else if(!strcmp(av[4],"t")) {
		args_a.temporal = 1;
		args_a.equal = 0;
	}
	else if(!strcmp(av[4],"e")) {
		args_a.temporal = 1;
		args_a.equal = 1;
	}
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

	if(!strcmp(av[8],"n"))
		args_b.temporal = 0;
	else if(!strcmp(av[8],"t")) {
		args_b.temporal = 1;
		args_b.equal = 0;
	}
	else if(!strcmp(av[8],"e")) {
		args_b.temporal = 1;
		args_b.equal = 1;
	}
	else
	{
		fail("temporalidade invalida");
	}
	
	core1 = atoi(av[9]);
	core2 = atoi(av[10]);

	printf("Core 1: %d, Core 2: %d\n", core1, core2);
	CPU_ZERO(&(args_a.cpuset)); CPU_ZERO(&(args_a.cpuset));
	CPU_SET(core1, &(args_a.cpuset)); CPU_SET(core2, &(args_b.cpuset));


/*	uint32_t busy_single, busy_loop;
	args_a.delay = atoi(av[11]);
	args_b.delay = atoi(av[12]);
	calibrate_busy(busy_single, busy_loop);
	
	if(args_a.delay != 0)
		if(args_a.delay < busy_loop)
			args_a.delay = busy_loop+1;
		else if (args_a.delay < 2*busy_loop)
			args_a.delay = 2*busy_loop+1;
*/
	if (PAPI_library_init(PAPI_VER_CURRENT) != PAPI_VER_CURRENT)
	{
		if(PAPI_library_init(PAPI_VER_CURRENT) == PAPI_EINVAL)
			puts("papi_einval");
		fail("papi library init falhou");
	}
	if ( ac == 11 ) {
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
	else if ( ac <= 14 ) {
		if (ac > 11 ) {
			if( PAPI_event_name_to_code(av[11], &eventcode) != PAPI_OK )
				fail("PAPI_event_name_to_code falhou 1");
			eventcodes[0] = eventcode;
			nevents = 1;
		}
		if (ac > 12 ) {
			if( PAPI_event_name_to_code(av[12], &eventcode) != PAPI_OK )
				fail("PAPI_event_name_to_code falhou 2");
			eventcodes[1] = eventcode;
			nevents = 2;
		}
		if (ac > 13 ) {
			if( PAPI_event_name_to_code(av[13], &eventcode) != PAPI_OK )
				fail("PAPI_event_name_to_code falhou 3");
			eventcodes[2] = eventcode;
			nevents = 3;
		}
	}
	else
		fail("quantidade invalida de argumentos");
	
	args_a.eventcodes = eventcodes;
	args_b.eventcodes = eventcodes;

	_mm_mfence();

	asm volatile ("nop"::: "memory");
	
	printf("size a: %u, mem a: %p\n", args_a.size, args_a.mem);
	printf("size b: %u, mem b: %p\n", args_b.size, args_b.mem);

	__m256i *buffer;
	buffer = _mm_malloc(BUF_SIZE, 64);
	asm volatile ("nop"::: "memory");
	__m256i local __attribute__((aligned(64)));
	for(uint64_t i=0; i<BUF_SIZE/32; i++)
	{
		local = _mm256_set1_epi64x(i);
		_mm256_stream_si256((buffer + i), local);
	}
	_mm_mfence();
	asm volatile ("nop"::: "memory");

	for(uint64_t i=0; i<args_a.size; i++)
	{
		local = _mm256_set1_epi64x(i);
		_mm256_stream_si256((args_a.mem + i), local);
	}
	_mm_mfence();
	for(uint64_t i=0; i<args_b.size; i++)
	{
		local = _mm256_set1_epi64x(i);
		_mm256_stream_si256((args_b.mem + i), local);
	}
	_mm_mfence();

	asm volatile ("nop"::: "memory");
	__m256i aux;
	aux = _mm256_set1_epi64x(0);
	for (int i=0; i<BUF_SIZE/32; i++) 
		aux+= args_b.reps + tempa[0] + buffer[i];
	printf("%lld", aux[0]);
	asm volatile ("nop"::: "memory");
	_mm_free(buffer);

	for(unsigned int i=0; i<args_a.size; i+=2)
		_mm_clflush(&(args_a.mem[i]));
	_mm_mfence();
	for(unsigned int i=0; i<args_b.size; i+=2)
		_mm_clflush(&(args_b.mem[i]));
	_mm_mfence();

	asm volatile ("nop"::: "memory");

	pthread_create(&th1, NULL, read_stream, &args_a);
	pthread_create(&th2, NULL, read_stream, &args_b);

	pthread_join(th1, NULL);
	pthread_join(th2, NULL);

	_mm_mfence();
	asm volatile ("nop"::: "memory");
	PAPI_shutdown();

	char event1[128],event2[128],event3[128];
	if(ac > 11) {
		if (nevents > 0 )
        	strcpy(event1,av[11]);
		if (nevents > 1 )
    	    strcpy(event2,av[12]);
		if (nevents > 2 )
    	    strcpy(event3,av[13]);
    }
    else
    {
        PAPI_event_code_to_name(eventcodes[0],event1);
        PAPI_event_code_to_name(eventcodes[1],event2);
        PAPI_event_code_to_name(eventcodes[2],event3);
    }

	printf("acc_a: %llu, reps_a: %llu, size_a: %uKB \n", (long long unsigned)(args_a.acc)[0][0], args_a.reps, args_a.size*32/1024);
	printf("acc_b: %llu, reps_b: %llu, size_b: %uKB \n", (long long unsigned)(args_b.acc)[0][0], args_b.reps, args_b.size*32/1024);
	if (nevents > 0 ) {
		printf("PAPI_THREAD_A;%s;%llu\n", event1, args_a.value[0]);
		printf("PAPI_THREAD_B;%s;%llu\n", event1, args_b.value[0]);
	}
	if (nevents > 1 ) {
		printf("PAPI_THREAD_A;%s;%llu\n", event2, args_a.value[1]);
		printf("PAPI_THREAD_B;%s;%llu\n", event2, args_b.value[1]);
	}
	if (nevents > 2 ) {
		printf("PAPI_THREAD_A;%s;%llu\n", event3, args_a.value[2]);
		printf("PAPI_THREAD_B;%s;%llu\n", event3, args_b.value[2]);
	}
	return (long long unsigned)(args_a.acc)[0][0] + (long long unsigned)(args_b.acc)[0][0];

}
