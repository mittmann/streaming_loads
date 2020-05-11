#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <immintrin.h>
#include <stdint.h>
#include <unistd.h>
#include <papi.h>
#include <string.h>

#include "rapl-read.h"

#define PAGE_SIZE (sysconf(_SC_PAGESIZE))
#define PAGE_MASK (~(PAGE_SIZE - 1))
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

#define ARRAY_HUGE 1024*192*250 //1500MB
#define ARRAY_BIG 1024*192*20 //120MB
#define ARRAY_SMALL 1024*192 //6MB
#define REP_HUGE 40
#define REP_BIG 500
#define REP_SMALL 10000

int main(int ac, char **av)
{
	__m256i local __attribute__((aligned(64)));
	__m256i acc __attribute__((aligned(64)));
	register void *map __attribute__((aligned(64)));
	int temporal;
	register long int size;	 
	register int reps;

	long long unsigned value[1];
	int eventcode;
	int EventSet = PAPI_NULL;
	PAPI_library_init(PAPI_VER_CURRENT);
	if(ac != 5)
	{
		fail("qtd errada de args <TAMANHO TIPO_DE_MEM TEMPORALIDADE COUNTER>");
	}
	if(!strcmp(av[1],"huge")){
		reps = REP_HUGE;
		size = ARRAY_HUGE;
	}
	else if(!strcmp(av[1],"big")){
		reps = REP_BIG;
		size = ARRAY_BIG;
	}
	else if(!strcmp(av[1],"small")){
		reps = REP_SMALL;
		size = ARRAY_SMALL;
	}
	else
	{
		fail("tamanho invalido");
	}


	if(!strcmp(av[2],"unc")) 
		map = get_uncached_mem("unc", size*32);
	else if(!strcmp(av[2],"wc")) 
		map = get_uncached_mem("wc", size*32);
	else if(!strcmp(av[2],"wb"))
		map = aligned_alloc(64,size*32);
	else
	{
		fail("tipo de mem invalido");
	}

	if(!strcmp(av[3],"nt"))
		temporal = 0;
	else if(!strcmp(av[3],"t"))
		temporal = 1;
	else
	{
		fail("temporalidade invalida");
	}
	
	if( PAPI_event_name_to_code(av[4], &eventcode) != PAPI_OK )
		fail("PAPI_event_name_to_code falhou");

		

	_mm_mfence();

	__m256i *mem = ((__m256i*)map);

	
	acc = _mm256_set1_epi64x(0);
	
	for(uint64_t i=0; i<size; i++)
	{
		local = _mm256_set1_epi64x(i);
		_mm256_stream_si256(&mem[i], local);
	}
	_mm_mfence();
	for(int i=0; i<size; i+=2)
		_mm_clflush(&mem[i]);
	_mm_mfence();
	raplht_initialize();
	raplht_start();
	
	if (PAPI_create_eventset(&EventSet) != PAPI_OK)
		fail("PAPI_create_eventset falhou");
	if (PAPI_add_event(EventSet,eventcode) != PAPI_OK)
		fail("PAPI_add_events falhou");	
	if (PAPI_start(EventSet) != PAPI_OK)
		fail("PAPI_start falhou");
	if(temporal)
	{
		for(int j=0;j<reps;j++)
			for(int i=0; i<size; i++)
			{
				local = _mm256_load_si256(&mem[i]);
				acc = _mm256_add_epi64(acc, local);
			}
	}
	else
	{
		for(int j=0;j<reps;j++)
			for(int i=0; i<size; i++)
			{
				local = _mm256_stream_load_si256(&mem[i]);
				acc = _mm256_add_epi64(acc, local);
			}
	}
	_mm_mfence();
	raplht_stop();
	if (PAPI_stop(EventSet, value) != PAPI_OK)
		fail("PAPI_stop falhou");
	PAPI_remove_event(EventSet, eventcode);
	PAPI_shutdown();

	printf("reps: %d, size: %ld\n", reps, size);
	printf("acc: %llu, %llu, %llu, %llu\n", acc[0], acc[1], acc[2], acc[3]);
	printf("PAPI_VALUE: %llu\n", value[0]);
	return (int)acc[0];

}
