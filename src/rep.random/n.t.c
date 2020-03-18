#include <immintrin.h>
#include <stdint.h>

#define ARRAY_SIZE 1024*256
#define REP 1000
int main(int argc, char **argv){
	static	__m512i mem[ARRAY_SIZE];
	__m512i local;
	
	unsigned long long int acc = 0;
    for(int j=0; j<REP; j++){ 	
	for(int i=0; i<ARRAY_SIZE; i++)
	{
		__m512i temp;
		temp[0]=i;
		_mm512_stream_si512(&mem[i], temp);
	}
	_mm_mfence();

	for(int i=0; i < ARRAY_SIZE; i++)
	{
		local = _mm512_load_si512(&mem[i]);
		acc += *((uint64_t*)&local);
	}
	_mm_mfence();
    }
	return (int)acc;
}
