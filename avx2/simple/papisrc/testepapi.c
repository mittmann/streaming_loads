#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <immintrin.h>
#include <stdint.h>
#include <unistd.h>
#include <papi.h>
#include <string.h>

#define PAGE_SIZE (sysconf(_SC_PAGESIZE))
#define PAGE_MASK (~(PAGE_SIZE - 1))

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

#define ARRAY_BIG 1024*192*20
#define ARRAY_SMALL 1024*192
#define REP_BIG 500
#define REP_SMALL 10000

int main(int ac, char **av)
{
	__m256i local;
	void *map;
	int temporal;
	register long int size;	 //pq eh 32 bytes cada _m256
	register int reps;
	if(ac != 4)
	{
		printf("quantidade errada de args");
		exit(-1);
	}
	if(!strcmp(av[1],"big")){
		reps = REP_BIG;
		size = ARRAY_BIG;
	}
	else if(!strcmp(av[1],"small")){
		reps = REP_SMALL;
		size = ARRAY_SMALL;
	}
	else
	{
		printf("tamanho invalido");
		exit(-1);
	}


	if(!strcmp(av[2],"unc")) 
		map = get_uncached_mem("dev", size*32);
	else if(!strcmp(av[2],"wb"))
		map = aligned_alloc(64,size*32);
	else
	{
		printf("tipo invalido");
		exit(-1);
	}

	if(!strcmp(av[3],"nt"))
		temporal = 0;
	else if(!strcmp(av[3],"t"))
		temporal = 1;
	else
	{
		printf("temporalidade invalido");
		exit(-1);
	}

	long long unsigned value[2];
	int EventSet = PAPI_NULL;
	//int events[5] = {PAPI_TOT_CYC, PAPI_RES_STL, PAPI_L3_LDM, PAPI_L3_DCR, PAPI_L1_DCM};
	int events[3] = {PAPI_TOT_CYC, PAPI_RES_STL};
	//int events[1] = {PAPI_L1_DCM};
	PAPI_library_init(PAPI_VER_CURRENT);

	//map = malloc(size);	/* test normal memory */


	/*********************************************************************/
	/* Read benchmarks */
	_mm_mfence();

	__m256i *mem = ((__m256i*)map);

	
	unsigned long long int acc = 0;

	for(int i=0; i<size; i++)
		mem[i][0] = (long long) i;
	_mm_mfence();
	for(int i=0; i<size; i++)
		_mm_clflush(&mem[i]);
	_mm_mfence();
	if(temporal)
	{
		PAPI_create_eventset(&EventSet);
		if (PAPI_add_events(EventSet,events, 2) != PAPI_OK)
			puts("NAOOOOOOO");
		
		PAPI_start(EventSet);
		for(int j=0;j<reps;j++)
			for(int i=0; i<size; i++)
			{
				local = _mm256_load_si256(&mem[i]);
				acc += *((uint64_t*)&local);
			}
		_mm_mfence();
		PAPI_stop(EventSet, value);
		PAPI_remove_events(&EventSet, events, 2);
		PAPI_shutdown();
	}
	else
	{
		PAPI_create_eventset(&EventSet);
		PAPI_add_events(EventSet,events, 2);
		PAPI_start(EventSet);
		for(int j=0;j<reps;j++)
			for(int i=0; i<size; i++)
			{
				local = _mm256_stream_load_si256(&mem[i]);
				acc += *((uint64_t*)&local);
			}
		_mm_mfence();
		PAPI_stop(EventSet, value);
		PAPI_remove_events(&EventSet, events, 2);
		PAPI_shutdown();
	}
	printf("reps: %d, size: %ld\n", reps, size);
	printf("PAPI_TOT_CYC, PAPI_RES_STL\n");
	printf("%llu,%llu\n", value[0], value[1]);
	//printf("%llu,%llu,%llu,%llu,%llu\n", value[0], value[1], value[2], value[3],value[4]);
	printf("acc: %lld\n", acc);
	return (int)acc;

}
