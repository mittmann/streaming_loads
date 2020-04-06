#include <immintrin.h>
#include <stdint.h>

#define ARRAY_SIZE 1024*256*64
#define REP 1000
int main(int argc, char **argv){
	static	__m512i mem[ARRAY_SIZE];
	static	__m512i mem2[ARRAY_SIZE];
	__m512i local;
	
	register unsigned long long int acc = 0;

    for(int j=0; j<REP; j++){ 	
	for(int i=0; i < ARRAY_SIZE; i++)
	{
		local = _mm512_load_si512(&mem[i]);
		acc += *((uint64_t*)&local);
	}
	_mm_mfence();

	for(int i=0; i < ARRAY_SIZE; i++)
	{
		local = _mm512_load_si512(&mem2[i]);
		acc += *((uint64_t*)&local);
	}
	_mm_mfence();
    }
	return (int)acc;
}
