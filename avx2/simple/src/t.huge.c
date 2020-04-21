#include <immintrin.h>
#include <stdint.h>

#define ARRAY_SIZE 1024*192*10000
#define REPS 1

int main(int argc, char **argv){
	__m256i local;
	__m256i *mem = aligned_alloc(64, sizeof(__m256i)*ARRAY_SIZE);
	
	unsigned long long int acc = 0;
	for(int i=0; i<ARRAY_SIZE; i++)
	{
		mem[i][0] = (long long) i;
	}
	_mm_mfence();
	for (int i=0; i<ARRAY_SIZE; i++)
	{
		_mm_clflush(&mem[i]);
	}

	_mm_mfence();


	for(int j=0; j < REPS; j++) {
		for(int i=0; i < ARRAY_SIZE; i++)
		{
			local = _mm256_load_si256(&mem[i]);
			acc += *((uint64_t*)&local);
		}
	}
	_mm_mfence();
	return (int)acc;
}
