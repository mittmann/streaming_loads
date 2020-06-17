#!/bin/bash
sizes=( 16 128 512 1024 2048 $((3*1024)) $((4*1024)) $((5*1024)) $((6*1024)) $((7*1024)) $((8*1024)) $((12*1024)) $((16*1024)) $((32*1024)) $((64*1024)) $((128*1024)) $((256*1024))  $((512*1024)) $((1024*1024)) 1572864 )
repts=( 15255934 1124046 132327 63951 31963 20981 15611 11134 7516 5143 4395 2320 1415 553 240 120 60 30 15 10 )
echo "" > log
while IFS="," read f1 f2 f3 f4 f5 f6 f7 f8 
do
    if [ "$f1" != "\"name\"" ]; then
		index1=`echo $f5 | sed -e 's/^"//' -e 's/"$//'`
		size1=${sizes[$index1]}
		reps1=${repts[$index1]}
		index2=`echo $f6 | sed -e 's/^"//' -e 's/"$//'`
		size2=${sizes[$index2]}
		reps2=${repts[$index2]}
		temp=`echo $f7 | sed -e 's/^"//' -e 's/"$//'`
		#temp=$f7
		if [ $f7 == "\"nn\"" ]; then
			mem1=wc
			mem2=wc
			temp1=nt
			temp2=nt
		elif [ $f7 == "\"nt\"" ]; then
			mem1=wc
			mem2=wb
			temp1=nt
			temp2=t
		elif [ $f7 == "\"tn\"" ]; then
			mem1=wb
			mem2=wc
			temp1=t
			temp2=nt
		elif [ $f7 == "\"tt\"" ]; then
			mem1=wb
			mem2=wb
			temp1=t
			temp2=t
		fi

		echo $size1, $reps1, $mem1, $temp1, $size2, $reps2, $mem2, $temp2 >> log
		ret=1
		while [ $ret -ne 0 ]; do
			{ cset shield --exec ./a.out -- $size1 $reps1 $mem1 $temp1 $size2 $reps2 $mem2 $temp2; } > tmpout 2>> log
			ret=$?
		done
		cyca=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_TOT_CYC | cut -d: -f3`
		l3ra=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCR | cut -d: -f3`
		l3ma=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCM | cut -d: -f3`
		cycb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_TOT_CYC | cut -d: -f3`
		l3rb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCR | cut -d: -f3`
		l3mb=`cat tmpout | grep PAPI_THREAD_B | grep PAPI_L3_TCM | cut -d: -f3`
		echo $size1,$size2,$temp,$cyca,$l3ra,$l3ma,$cycb,$l3rb,$l3mb
		sleep 2
	else 
		echo $f5,$f6,$f7,\"cyca\",\"l3ra\",\"l3ma\",\"cycb\",\"l3rb\",\"l3mb\"
	fi
done < doe.csv #>> data/MM_output.csv


