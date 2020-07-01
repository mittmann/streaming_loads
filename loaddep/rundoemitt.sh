#!/bin/bash
core=3
bin=./multi256
sizes=( 512 1024 2048 $((4*1024)) $((6*1024)) $((8*1024)) $((12*1024)) $((16*1024)) $((32*1024)) $((256*1024)))
echo "" > log
while IFS="," read f1 f2 f3 f4 f5 f6 f7 f8 f9 
do
    if [ "$f1" != "\"name\"" ]; then
		index=`echo $f5 | sed -e 's/^"//' -e 's/"$//'`
		size=${sizes[$index]}
		reps=$(( (sizes[-1] * 1 ) / size ))
		temp=`echo $f6 | sed -e 's/^"//' -e 's/"$//'`
		mem=`echo $f7 | sed -e 's/^"//' -e 's/"$//'`
		shuff=`echo $f8 | sed -e 's/^"//' -e 's/"$//'`





		echo $size, $reps, $mem, $temp, $shuff >> log
		ret=1
		while [ $ret -ne 0 ]; do
			sleep 1
			{ taskset -c $core $bin $size $reps $mem $temp $core $shuff ; } > tmpout 2>> log
			ret=$?
		done
		cyc=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_TOT_CYC | cut -d: -f3`
		l3r=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCR | cut -d: -f3`
		l3m=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCM | cut -d: -f3`



		echo $size,$reps,$mem,$temp,$shuff,$cyc,$l3r,$l3m
		sleep 2
	else 
		echo $f5,\"reps\",$f7,$f6,$f8,\"cyc\",\"l3r\",\"l3m\"
	fi
done < doe.csv #>> data/MM_output.csv


