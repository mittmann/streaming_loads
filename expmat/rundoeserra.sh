#!/bin/bash
# sem cset e reps diferentes
bin=./multi512
core1=2
core2=4
sizes=( 16 2048  $((4*1024)) $((6*1024)) $((8*1024)) $((12*1024))  $((14*1024)) $((16*1024)) $((20*1024)) $((24*1024)) $((32*1024)) $((64*1024)) $((128*1024)) $((256*1024))  $((512*1024)) $((1024*1024)) )
repts=( 0 31906 15567 10000 5720 1980 1450 1380 1700 1337 770 331 157 75 34 18 )
echo "" > log
while IFS="," read f1 f2 f3 f4 f5 f6 f7 f8 
do
    if [ "$f1" != "\"name\"" ]; then
		index1=`echo $f5 | sed -e 's/^"//' -e 's/"$//'`
		#for index1 in `seq 1 14`; do
		#index1=8
		size1=${sizes[$index1]}
		reps1=${repts[$index1]}
		index2=`echo $f6 | sed -e 's/^"//' -e 's/"$//'`
		size2=${sizes[$index2]}
		reps2=${repts[$index2]}
		#temp=`echo $f7 | sed -e 's/^"//' -e 's/"$//'`
		temp=$f7
		if [ $f7 == "\"nn\"" ]; then
			mem1=wc
			mem2=wc
			temp1=n
			temp2=n
		elif [ $f7 == "\"nt\"" ]; then
			mem1=wc
			mem2=wb
			temp1=n
			temp2=e
		elif [ $f7 == "\"tn\"" ]; then
			mem1=wb
			mem2=wc
			temp1=e
			temp2=n
		elif [ $f7 == "\"tt\"" ]; then
			mem1=wb
			mem2=wb
			temp1=e
			temp2=e
		fi
		#size2=16
		#reps2=0	
		echo $size1, $reps1, $mem1, $temp1, $size2, $reps2, $mem2, $temp2 >> log
		ret=1
		while [ $ret -ne 0 ]; do
			sleep 1
			{ taskset -c $core1 $bin $size1 $reps1 $mem1 $temp1 $size2 $reps2 $mem2 $temp2 $core1 $core2; } > tmpout 2>> log
			ret=$?
		done
		cyca=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_TOT_CYC | cut -d';' -f3`
		l3ra=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCR | cut -d';' -f3`
		l3ma=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCM | cut -d';' -f3`
		cycb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_TOT_CYC | cut -d';' -f3`
		l3rb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCR | cut -d';' -f3`
		l3mb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCM | cut -d';' -f3`
		echo $size1,$size2,$temp,$cyca,$l3ra,$l3ma,$cycb,$l3rb,$l3mb
		sleep 2
	#done
	else 
		echo $f5,$f6,$f7,\"cyca\",\"l3ra\",\"l3ma\",\"cycb\",\"l3rb\",\"l3mb\"
	fi
done < doe.csv #>> data/MM_output.csv


