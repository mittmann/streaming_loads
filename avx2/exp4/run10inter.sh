#!/bin/bash
sizes=( $((4*1024)) $((5*1024)) $((6*1024)) $((7*1024)) $((8*1024)) $((12*1024)) )
max=15728640

for rep in `seq 1 50`; do
for size1 in ${sizes[@]}; do
	reps=$(( max / size1 ))
	size2=16
		cset shield --exec ./a.out -- $size1 $reps wb t $size2 1 wb t > tmpout 
		cyca=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_TOT_CYC | cut -d: -f3`
		l3ra=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCR | cut -d: -f3`
		l3ma=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCM | cut -d: -f3`
		cycb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_TOT_CYC | cut -d: -f3`
		l3rb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCR | cut -d: -f3`
		l3mb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCM | cut -d: -f3`
		echo $size1,$cyca 
		sleep 5
	done
done
