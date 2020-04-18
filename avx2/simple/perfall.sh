#!/bin/bash
read -t 1 stat
if [ -z "$stat" ]; then
	stat=$1
fi
for exe in `ls bin | grep "e\." | grep "rep"`; do
	value=`perf stat -e $stat ./bin/$exe 2>&1 | grep $stat | awk '{print $1}'`
	echo $stat,${exe:2},${value//.}
done
