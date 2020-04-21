#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <immintrin.h>
#include <stdint.h>
#include <unistd.h>

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

#define ARRAY_SIZE 1024*192*10000
#define REPS 1

int main(int ac, char **av)
{
	long int size = ARRAY_SIZE*32;	 //pq eh 32 bytes cada _m256
	__m256i local;
	void *map;
	map = get_uncached_mem("dev", size);
	//map = malloc(size);	/* test normal memory */


	/*********************************************************************/
	/* Read benchmarks */
	_mm_mfence();

	__m256i *mem = ((__m256i*)map);

	
	unsigned long long int acc = 0;

	for(int i=0; i<ARRAY_SIZE; i++)
		mem[i][0] = (long long) i;
	_mm_mfence();
	for(int i=0; i<ARRAY_SIZE; i++)
		_mm_clflush(&mem[i]);
	_mm_mfence();
for(int j=0;j<REPS;j++)
	for(int i=0; i<ARRAY_SIZE; i++)
	{
		local = _mm256_stream_load_si256(&mem[i]);
		acc += *((uint64_t*)&local);
	}
	_mm_mfence();
	return (int)acc;

}
