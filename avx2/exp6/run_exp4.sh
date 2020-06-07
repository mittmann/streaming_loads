#!/bin/bash
sizes=( 16 128 512 1024 2048 $((3*1024)) $((4*1024)) $((5*1024)) $((6*1024)) $((7*1024)) $((8*1024)) $((12*1024)) $((16*1024)) $((32*1024)) $((64*1024)) $((128*1024)) $((256*1024))  $((512*1024)) $((1024*1024)) 1572864 )
reps=( 14928740 1082620 128062 63822 31906 21263 15567 11288 8062 6198 5246 2344 1440 558 251 120 60 30 15 10 ) 

for i in `seq 1 20`; do
	size1=$(sizes[$i])
	rep=$(reps[$i])
	for size2 in ${sizes[@]}; do
		cset shield --exec ./a.out -- $size1 $reps wb t $size2 1 wb t > tmpout 
		cyca=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_TOT_CYC | cut -d: -f3`
		l3ra=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCR | cut -d: -f3`
		l3ma=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCM | cut -d: -f3`
		cycb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_TOT_CYC | cut -d: -f3`
		l3rb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCR | cut -d: -f3`
		l3mb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCM | cut -d: -f3`
		echo $size1,$size2,t,$cyca,$l3ra,$l3ma,$cycb,$l3rb,$l3mb
		sleep 5
		cset shield --exec ./a.out -- $size1 $reps wb t $size2 1 wc nt > tmpout 
		cyca=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_TOT_CYC | cut -d: -f3`
		l3ra=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCR | cut -d: -f3`
		l3ma=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCM | cut -d: -f3`
		cycb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_TOT_CYC | cut -d: -f3`
		l3rb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCR | cut -d: -f3`
		l3mb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCM | cut -d: -f3`
		echo $size1,$size2,n,$cyca,$l3ra,$l3ma,$cycb,$l3rb,$l3mb
		sleep 5
	done
done

