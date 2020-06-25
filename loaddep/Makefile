CC = gcc
LD = gcc
CFLAGS = $(FLAGS) $(EXT512)
RM = rm -f

%.o : %.c
	$(CC) -c $(CFLAGS) $< -o $@ 

FLAGS = -O2 -Wall -Wextra -static

EXT2 = -mavx2
EXT512 = -mavx512f

LIBRARY = -lpapi -lpthread

AVX2 = multi256
AVX512 = multi512

OBJ_2 = multi256.o
OBJ_512 = multi512.o

all:	$(AVX2) $(AVX512)

$(AVX2):	$(OBJ_2)
	$(LD) $(LDFLAGS) -o $(AVX2) $(OBJ_2) $(LIBRARY)

$(AVX512):	$(OBJ_512)
	$(LD) $(LDFLAGS) -o $(AVX512) $(OBJ_512) $(LIBRARY)


clean:	
	-$(RM) $(OBJ_2) $(OBJ_512)
	-$(RM) $(AVX2) $(AVX512)


cleano:	
	-$(RM) $(OBJ_2) $(OBJ_512)

fresh:
	make clean
	make
