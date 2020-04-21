#!/bin/bash
read -t 1 stat
if [ -z "$stat" ]; then
	stat=$1
fi

for size in small big huge; do
	for memtyp in wb unc; do
		for temp in t nt; do
			value=`./e.O0 $size $memtyp $temp $stat | grep PAPI_VALUE | awk '{print $2}'`
			echo $stat,$size,$memtyp,$temp,O0,${value}
			value=`./e.O2 $size $memtyp $temp $stat | grep PAPI_VALUE | awk '{print $2}'`
			echo $stat,$size,$memtyp,$temp,O2,${value}
		done
	done
done
