for code in `ls ../src/rep/`
	do gcc-9 -o ../bin/rep/e.${code::-2} -O0 ../src/rep/$code -mavx2
done
for code in `ls ../src/one/`
	do gcc-9 -o ../bin/one/e.${code::-2} -O0 ../src/one/$code -mavx2
done
