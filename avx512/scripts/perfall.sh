#!/bin/bash
read -t 1 stat
if [ -z "$stat" ]; then
	stat=$1
fi

for exe in `ls ../bin/one`; do
	value=`perf stat -e $stat ../bin/one/$exe 2>&1 | grep $stat | awk '{print $1}'`
	echo $stat,one,${exe:2},${value//,}
done

for exe in `ls ../bin/rep`; do
	value=`perf stat -e $stat ../bin/rep/$exe 2>&1 | grep $stat | awk '{print $1}'`
	echo $stat,rep,${exe:2},${value//,}
done
