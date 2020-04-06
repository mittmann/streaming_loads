for code in `ls ../src/rep/`
	do gcc-9.3 -S -fverbose-asm -O0 ../src/rep/$code -mavx2
	mv ${code::-2}.s ../asm/rep/
done
for code in `ls ../src/one/`
	do gcc-9.3 -S -fverbose-asm -O0 ../src/one/$code -mavx2
	mv ${code::-2}.s ../asm/one/
done
