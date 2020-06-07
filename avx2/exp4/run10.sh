#!/bin/bash
sizes=( 16 128 512 1024 2048 $((3*1024)) $((4*1024)) $((5*1024)) $((6*1024)) $((7*1024)) $((8*1024)) $((12*1024)) $((16*1024)) $((32*1024)) $((64*1024)) $((128*1024)) $((256*1024))  $((512*1024)) $((1024*1024)) ) #1572864 )
repts=( 15255934 1124046 132327 63951 31963 20981 15611 11134 7516 5143 4395 2320 1415 553 240 120 60 30 15) # 10 )
for i in `seq 0 19`; do
	size1=${sizes[$i]}
	reps=${repts[$i]}
	size2=16
		cset shield --exec ./a.out -- $size1 $reps wb t $size2 1 wb t > tmpout 
		cyca=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_TOT_CYC | cut -d: -f3`
		l3ra=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCR | cut -d: -f3`
		l3ma=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCM | cut -d: -f3`
		cycb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_TOT_CYC | cut -d: -f3`
		l3rb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCR | cut -d: -f3`
		l3mb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCM | cut -d: -f3`
		echo $size1, $cyca 
		sleep 3
	done

