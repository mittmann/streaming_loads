#include <immintrin.h>
#include <stdint.h>

#define ARRAY_SIZE 1024*255

int main(int argc, char **argv){
	__m256i mem[ARRAY_SIZE];
	__m256i local;
	
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
//	return (int)acc + (int)mem[0][0] + (int)mem[ARRAY_SIZE/2][3] + (int)mem[ARRAY_SIZE-1][4];
	for(int i=0; i < ARRAY_SIZE; i++)
	{
		local = _mm256_load_si256(&mem[i]);
		acc += *((uint64_t*)&local);
	}
	_mm_mfence();

	return (int)acc;
}
