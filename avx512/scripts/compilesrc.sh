for code in `ls ../src/rep/`
	do gcc-9.3 -o ../bin/rep/e.${code::-2} -O0 ../src/rep/$code -mavx512vl
done
for code in `ls ../src/one/`
	do gcc-9.3 -o ../bin/one/e.${code::-2} -O0 ../src/one/$code -mavx512vl
done
