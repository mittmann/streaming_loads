/*
 * Copyright (C) 2014  Marco Antonio Zanata Alves (mazalves at inf.ufrgs.br)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>
#include <unistd.h>
#include <immintrin.h>
#include <papi.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <string.h>
#define PAGE_SIZE (sysconf(_SC_PAGESIZE))
#define PAGE_MASK (~(PAGE_SIZE -1))

#define ARRAY_HUGE 1024*192*125 //1500MB
#define ARRAY_BIG 1024*192*10 //120MB
#define ARRAY_SMALL 1024*96 //6MB
#define REP_HUGE 80
#define REP_BIG 1000
#define REP_SMALL 20000
// =============================================================================
uint64_t string_to_uint64(char *string) {
    uint64_t result = 0;
    char c;

    for (  ; (c = *string ^ '0') <= 9 && c >= 0; ++string) {
        result = result * 10 + c;
    }
    return result;
};

// =============================================================================

struct list {
    uint64_t value;
    struct list *next_element;
    char pad[48];
};
typedef struct list element;

// =======================================================

void fail(char* msg){
	fprintf(stderr, "%s\n", msg);
	exit(EXIT_FAILURE);
}

void *get_uncached_mem(char *dev, int size)
{
    int fd = open(dev, O_RDWR, 0);
    if (fd == -1) printf("%s","couldn't open device");
    if (size & ~PAGE_MASK)
        size = (size & PAGE_MASK) + PAGE_SIZE;
    void *map = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (map == MAP_FAILED)
            printf("%s","mmap failed.");
    return map;
}

// ======================================================

// =============================================================================
int main (int ac, char *av[]) {
///
    __m256d vecd __attribute__((aligned(64)));
    int temporal;
    register long int size;
    register int reps;
    unsigned long long int acc=0;

    long long unsigned papivalue[1];
    int eventcode;
    int EventSet = PAPI_NULL;
///
    element *ptr_list = NULL;
    element *ptr_this;

    if(ac != 5) {
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
        fail("tamanho invalido");

    if (!strcmp(av[2], "unc"))
        ptr_list = get_uncached_mem("unc", size*64);
    else if (!strcmp(av[2], "wc"))
        ptr_list = get_uncached_mem("wc", size*64);
    else if (!strcmp(av[2], "wb"))
        ptr_list = aligned_alloc(64, size*64);
    else
        fail("tipo de mem invalido");

    if(!strcmp(av[3],"nt"))
        temporal = 0;
    else if (!strcmp(av[3],"t"))
        temporal = 1;
    else
        fail("temporalidade invalida");

    PAPI_library_init(PAPI_VER_CURRENT);

    if ( PAPI_event_name_to_code(av[4], &eventcode) != PAPI_OK )
        fail("PAPI_event_name_to_code falhou");

    _mm_mfence();

    printf("Struct size %"PRIu64"\n", (uint64_t)sizeof(element));
    printf("Repetitions:%d Size:%"PRIu64"\n", reps, size);
    printf("Memory to be accessed: %"PRIu64"KB\n", (uint64_t)(size*sizeof(element))/1024);

    uint64_t i = 0, j = 0;
    uint64_t print = 0;

    long long int prime=size/2+1;
    long long int current=-1;
    
    ptr_this = ptr_list;
    for (i = 0; i < size; i++) {
        ptr_this->value = i;
	current += prime;
	if(current >= size) current -= size;	
	//printf("current: %lld\n", current);
        ptr_this->next_element = &ptr_list[i+1];
        ptr_this = ptr_this->next_element;
        ptr_this->next_element = NULL;
    }

    asm volatile ("nop");
    asm volatile ("nop");
    asm volatile ("nop");

    int width = 1;
    element* pointers[4];
    _mm_mfence();
    for(uint64_t i=0; i<size; i++)
        _mm_clflush(ptr_list+i);
    _mm_mfence();

    if (PAPI_create_eventset(&EventSet) != PAPI_OK)
        fail("PAPI_create_eventset falhou");
    if (PAPI_add_event(EventSet,eventcode) != PAPI_OK)
        fail("PAPI_add_events falhou");
    if (PAPI_start(EventSet) != PAPI_OK)
        fail("PAPI_start falhou");        
    if(!temporal) {
    ptr_this = ptr_list;
    for (i = 0; i < reps; i++) {
        ptr_this = ptr_list;
        //for (j = 0; j < size; j ++) {
        for (j = 0; j < size; j ++) {
	    for (int k = 0; k < width; k++) {
	    	vecd = _mm256_castsi256_pd ( _mm256_stream_load_si256( (__m256i*) ptr_this->next_element ) );
	        ptr_this = (element *) &vecd[0];

	    }
            asm volatile ("nop"); //aqui não precisa mas pra ficar melhor a comparaçao tb botei
	   //_mm_mfence();
        }
    }
}
    else{
    ptr_this = ptr_list;
    for (i = 0; i < reps; i++) {
        ptr_this = ptr_list;
        for (j = 0; j < size; j ++) {
	    vecd = _mm256_castsi256_pd ( _mm256_load_si256( (__m256i*) ptr_this->next_element ) );
            ptr_this = (element *) &vecd[0];
    asm volatile ("nop"); //precisa pra não dar segfault, não sei pq
//	   _mm_mfence();

        }
    }
}

    if (PAPI_stop(EventSet, papivalue) != PAPI_OK)
        fail("PAPI_stop falhou");
    PAPI_remove_event(EventSet, eventcode);
    PAPI_shutdown();

    asm volatile ("nop");
    asm volatile ("nop");
    asm volatile ("nop");
    
    printf("acc: %llu, print:%lu\n", acc, print);
    
    printf("PAPI_VALUE: %llu\n", papivalue[0]);
    exit(EXIT_SUCCESS);
}
