#!/bin/bash
for code in `ls | grep "\.c$"`
do
	gcc -o ../bin/o0/e.${code::-2} -O0 $code -mavx2
	gcc -S -o ../asm/o0/${code::-2}.s -O0 $code -mavx2
	echo "compiled $code o0"
done
for code in `ls | grep "\.c$"`
do
	gcc -o ../bin/o2/e.${code::-2} -O2 $code -mavx2
	gcc -S -o ../asm/o2/${code::-2}.s -O2 $code -mavx2
	echo "compiled $code o2"
done
