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
struct list {
    uint64_t value;
    struct list *next_element;
    char pad[48];
};
typedef struct list element;
void shuffle(int *array, size_t n) {    
    srand48(0);
    if (n > 1) {
        size_t i;
        for (i = n - 1; i > 0; i--) {
            size_t j = (unsigned int) (drand48()*(i+1));
            int t = array[j];
            array[j] = array[i];
            array[i] = t;
        }
    }
}

struct arg_struct {
	unsigned size;
	long long unsigned reps;
	long long value[3];
	int temporal;
	int *eventcodes;
	__m512i *mem __attribute__((aligned(64)));
	__m512i *acc;
	cpu_set_t cpuset;
	element *ptr_list __attribute__((aligned(64)));

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
	__m512d vecd __attribute__((aligned(64)));
	struct arg_struct *args = (struct arg_struct *) arg;
	pthread_t current = pthread_self();
	pthread_setaffinity_np(current, sizeof(cpu_set_t), &(args->cpuset));
	element *ptr_this __attribute__((aligned(64)));
	element *ptr_list __attribute__((aligned(64)));

	ptr_list = (element *)args->mem;
	/*if (CPU_ISSET(2,&(args->cpuset)))
		usleep(4000);*/
	__m512i local __attribute__((aligned(64)));
	__m512i acc __attribute__((aligned(64)));
	acc = _mm512_set1_epi64(0);
	if (PAPI_create_eventset(&EventSet) != PAPI_OK)
		fail("PAPI_create_eventset falhou");
	if (PAPI_add_events(EventSet,args->eventcodes, 3) != PAPI_OK)
		fail("PAPI_add_events falhou");	
	if (PAPI_start(EventSet) != PAPI_OK)
		fail("PAPI_start falhou");
//	printf("mem: %p\n", mem);
   // ptr_this = ptr_list;
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_list ) );
            ptr_this = (element *) &vecd[0];
if (!(args->temporal))
    for (unsigned i = 0; i < args->reps * args->size; i+=32) {
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];

        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];


        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];

        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_stream_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
	}
	else
	for(uint64_t i=0; i < args->reps * args->size ;i+=32)
	{
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];

        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];

        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];

        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
        vecd = _mm512_castsi512_pd ( _mm512_load_si512( (__m512i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];

			}
	(args->acc)[0] = _mm512_set1_epi64(ptr_this->value);
	if (PAPI_stop(EventSet, args->value) != PAPI_OK)
		fail("PAPI_stop falhou");
	PAPI_remove_events(EventSet, args->eventcodes, 3);
	return 0;
}


int main(int ac, char **av)
{
	__m512i tempa;

	element *ptr_list __attribute__((aligned(64)));
	element *ptr_this __attribute__((aligned(64)));

	int eventcode;
	int eventcodes[3];
//	int EventSet = PAPI_NULL;
	struct arg_struct args_a;
	args_a.acc = &tempa; // reserva memoria pros accs de retorno de cada thread

	int core1;

	pthread_t th1;
	if(ac < 7)
	{
		fail("qtd errada de args <TAMANHO_A REPS_A TIPO_A TEMP_A CORE_1 SHUFFLE(seq/shuffle)> <opt: 3 counters papi>");
	}

//// ARGS A
		args_a.size = atoi(av[1])*16; //igual a *1024/64 pra dar o numero de elementos em kb
		args_a.reps = atoll(av[2]);

	if(!strcmp(av[3],"unc")) 
		if ( args_a.size/16 > 128)
			args_a.mem = (__m512i*)get_uncached_mem("unc", args_a.size*64);
		else
			args_a.mem = (__m512i*)get_uncached_mem("unc", 1024*128);
	else if(!strcmp(av[3],"wc")) 
		if ( args_a.size/16 > 128)
			args_a.mem = (__m512i*)get_uncached_mem("wc", args_a.size*64);
		else
			args_a.mem = (__m512i*)get_uncached_mem("wc", 1024*128);
		
	else if(!strcmp(av[3],"wb"))
		args_a.mem = (__m512i*)_mm_malloc(args_a.size*64, 64);
	else
	{
		fail("tipo de mem invalido");
	}

	if(!strcmp(av[4],"nt"))
		args_a.temporal = 0;
	else if(!strcmp(av[4],"t"))
		args_a.temporal = 1;
	else
	{
		fail("temporalidade invalida");
	}

	
	core1 = atoi(av[5]);
	
	int shuff;

	if (!strcmp(av[6],"seq"))
		shuff = 0;
	else if (!strcmp(av[6],"shuffle"))
		shuff = 1;
	else
		fail("shuffle invalido");
////

	//printf("Core 1: %d, Core 2: %d\n", core1, core2);
	printf("Core 1: %d", core1);
	CPU_ZERO(&(args_a.cpuset)); CPU_ZERO(&(args_a.cpuset));
	CPU_SET(core1, &(args_a.cpuset)); 

    uint64_t i = 0, j = 0;


    ptr_list =  (element *) args_a.mem;
    int *positions = malloc(sizeof(int)*args_a.size);
    for (i = 0; i < args_a.size; i++) {
		positions[i] = i;
	}
    if (shuff)
	    shuffle(positions, args_a.size);
    /*for (i = 0; i < args_a.size; i++) {
		printf("position %d = %d\n", i, positions[i]);
    }
    */
    ptr_this = ptr_list;
    for (i = 0; i < args_a.size; i++) {
        ptr_list[i].value = i;
    }
    ptr_this = &(ptr_list[positions[0]]);
    for (i = 0; i < args_a.size; i++) {
        ptr_this->next_element = &(ptr_list[positions[i]]);
        ptr_this = ptr_this->next_element;
        ptr_this->next_element = NULL;
    }
    ptr_this->next_element = &(ptr_list[positions[0]]);

    asm volatile ("nop");
    asm volatile ("nop");
    asm volatile ("nop");



	if (PAPI_library_init(PAPI_VER_CURRENT) != PAPI_VER_CURRENT)
	{
		if(PAPI_library_init(PAPI_VER_CURRENT) == PAPI_EINVAL)
			puts("papi_einval");
		fail("papi library init falhou");
	}
	if ( ac == 7 ) {
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
	else if ( ac == 10 ) {
		if( PAPI_event_name_to_code(av[11], &eventcode) != PAPI_OK )
			fail("PAPI_event_name_to_code falhou 1");
		eventcodes[0] = eventcode;
		if( PAPI_event_name_to_code(av[12], &eventcode) != PAPI_OK )
			fail("PAPI_event_name_to_code falhou 2");
		eventcodes[1] = eventcode;
		if( PAPI_event_name_to_code(av[13], &eventcode) != PAPI_OK )
			fail("PAPI_event_name_to_code falhou 3");
		eventcodes[2] = eventcode;
	}
	else
		fail("quantidade invalida de argumentos");
	
	args_a.eventcodes = eventcodes;

	_mm_mfence();

//	__m512i *mem = ((__m512i*)map);

	
	//printf("usable a: %u, usable b: %u\n", malloc_usable_size(args_a.mem), malloc_usable_size(args_b.mem));
	
	printf("size a: %u, mem a: %p\n", args_a.size, args_a.mem);
/*	for(uint64_t i=0; i<args_a.size; i++)
	{
		//printf("i: %ld - ", i);
		__m512i local __attribute__((aligned(64)));
		local = _mm512_set1_epi64(i);
		_mm512_stream_si512(&(args_a.mem[i]), local);
	}*/
	_mm_mfence();
	for(unsigned int i=0; i<args_a.size; i++)
		_mm_clflush((args_a.mem + i));
	_mm_mfence();


	pthread_create(&th1, NULL, read_stream, &args_a);

	pthread_join(th1, NULL);

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
	printf("acc_a: %llu, reps_a: %llu, size_a: %uKB \n", (long long unsigned)(args_a.acc)[0][0], args_a.reps, args_a.size*64/1024);
	printf("PAPI_THREAD_A:%s:%llu\n", event1, args_a.value[0]);
	printf("PAPI_THREAD_A:%s:%llu\n", event2, args_a.value[1]);
	printf("PAPI_THREAD_A:%s:%llu\n", event3, args_a.value[2]);
	return (long long unsigned)(args_a.acc)[0][0];

}
