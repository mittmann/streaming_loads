#!/bin/bash
read -t 1 stat
if [ -z "$stat" ]; then
	stat=$1
fi
for exe in `ls bins | grep "e\."`; do
	value=`perf stat -e $stat ./bins/$exe 2>&1 | grep $stat | awk '{print $1}'`
	echo $stat,${exe:2},${value//.}
done
