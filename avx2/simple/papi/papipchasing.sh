#!/bin/bash
read -t 1 stat
if [ -z "$stat" ]; then
	stat=$1
fi

for size in huge small; do
	for memtyp in wb wc unc; do
		for temp in t nt; do
			sleep 1
			value=`nice --20 taskset -c 0 ./e.O2.pchasing $size $memtyp $temp $stat | grep PAPI_VALUE | awk '{print $2}'`
			echo $stat,$size,$memtyp,$temp,O2.pchasing,${value}
		done
	done
done
