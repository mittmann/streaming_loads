#include <immintrin.h>
#include <stdint.h>

#define ARRAY_SIZE 1024*256
#define REP 1000
int main(int argc, char **argv){
	static	__m256i mem[ARRAY_SIZE];
	__m256i local;
	
	unsigned long long int acc = 0;
    for(int j=0; j<REP; j++){	
	for(int i=0; i<ARRAY_SIZE; i++)
	{
		__m256i temp;
		temp[0]=i;
		_mm256_stream_si256(&mem[(77*i+1)%ARRAY_SIZE], temp);
	}
	_mm_mfence();

	for(int i=0; i < ARRAY_SIZE; i++)
	{
		local = _mm256_stream_load_si256(&mem[(77*i+1)%ARRAY_SIZE]);
		acc += *((uint64_t*)&local);
	}
	_mm_mfence();
    }

	return (int)acc;
}
