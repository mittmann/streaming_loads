#!/bin/bash
read -t 1 stat
if [ -z "$stat" ]; then
	stat=$1
fi

for size in small huge; do
	for memtyp in wb unc; do
		for temp in t; do
			value=`./e.O2.double $size $memtyp $temp $stat | grep PAPI_VALUE | awk '{print $2}'`
			echo $stat,$size,$memtyp,$temp,O2.double,${value}
			value=`./e.O2.stride $size $memtyp $temp $stat | grep PAPI_VALUE | awk '{print $2}'`
			echo $stat,$size,$memtyp,$temp,O2.stride,${value}
		done
	done
done
