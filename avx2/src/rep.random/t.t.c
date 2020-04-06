#include <immintrin.h>
#include <stdint.h>

#define ARRAY_SIZE 1024*64*1
#define REP 10 
int main(int argc, char **argv){
	static	__m256i mem[ARRAY_SIZE];
	static	__m256i mem2[ARRAY_SIZE];
	__m256i local;
	
	unsigned long long int acc = 0;

    for(int j=0; j<REP; j++){ 	

	for(int i=0; i < ARRAY_SIZE; i++)
	{
		local = _mm256_load_si256(&mem[(77*i+1)%ARRAY_SIZE]);
		acc += *((uint64_t*)&local);
	}
	_mm_mfence();

/*	for(int i=0; i < ARRAY_SIZE; i++)
	{
		local = _mm256_load_si256(&mem2[(77*i+1)%ARRAY_SIZE]);
		acc += *((uint64_t*)&local);
	}
	_mm_mfence();*/
    }
	return (int)acc;
}
