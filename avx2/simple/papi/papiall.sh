#!/bin/bash
read -t 1 stat
if [ -z "$stat" ]; then
	stat=$1
fi

for size in huge small; do
	for memtyp in wb wc unc; do
		for temp in t nt; do
			sleep 1
			value=`nice --20 ./e.O2 $size $memtyp $temp $stat | grep PAPI_VALUE | awk '{print $2}'`
			echo $stat,$size,$memtyp,$temp,O2,${value}
			sleep 1
			value=`nice --20 ./e.O2.double $size $memtyp $temp $stat | grep PAPI_VALUE | awk '{print $2}'`
			echo $stat,$size,$memtyp,$temp,O2.double,${value}
			sleep 1
			value=`nice --20 ./e.O2.stride $size $memtyp $temp $stat | grep PAPI_VALUE | awk '{print $2}'`
			echo $stat,$size,$memtyp,$temp,O2.stride,${value}
			value=`nice --20 ./e.O2.pchasing $size $memtyp $temp $stat | grep PAPI_VALUE | awk '{print $2}'`
			echo $stat,$size,$memtyp,$temp,O2.pchasing,${value}
		done
	done
done
