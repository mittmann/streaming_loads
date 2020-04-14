#!/bin/bash
for code in `ls | grep "\.c$"`
do
	gcc -o e.${code::-2} -O0 $code -mavx2
	echo "compiled $code"
done
