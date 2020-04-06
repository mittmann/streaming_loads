#!/bin/bash
read -t 1 stat
if [ -z "$stat" ]; then
	stat=$1
fi

for exe in ../src/rev/r.t.t ../src/rev/r.n.t; do
	value=`perf stat -e $stat $exe 2>&1 | grep $stat | awk '{print $1}'`
	echo $stat,one,${exe:11},${value//,}
done

