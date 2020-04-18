#!/bin/bash
for code in `ls | grep "\.c$"`
do
	gcc -o ../bin/e.${code::-2} -O2 $code -mavx2
	gcc -S -o ../asm/${code::-2}.s -O2 $code -mavx2
	echo "compiled $code"
done
