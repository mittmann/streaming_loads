#!/bin/bash
sizes=( 16 128 512 1024 2048 $((3*1024)) $((4*1024)) $((5*1024)) $((6*1024)) $((7*1024)) $((8*1024)) $((12*1024)) $((16*1024)) $((32*1024)) $((64*1024)) $((128*1024)) $((256*1024))  $((512*1024)) $((1024*1024)) 1572864 )
repts=( 15255934 1124046 132327 63951 31963 20981 15611 11134 7516 5143 4395 2320 1415 553 240 120 60 30 15 10 )
rm log
while IFS="," read f1 f2 f3 f4 f5 f6 f7 f8 
do
    if [ "$f1" != "\"name\"" ]; then
		index=`echo $f5 | sed -e 's/^"//' -e 's/"$//'`
		size1=${sizes[$index]}
		reps=$(( (sizes[-1] * 40 ) / size1 ))
	#	reps=${repts[$index]}
		overhead=`echo $f6 | sed -e 's/^"//' -e 's/"$//'`
		temp=`echo $f7 | sed -e 's/^"//' -e 's/"$//'`
		#temp=$f7
		if [[ $f7 == "\"n\"" ]]; then
			mem=wc
		else
			mem=wb
		fi
		echo $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8 >> log
		echo $size1, $reps, $overhead, $mem, $temp >> log
		ret=1
		while [ $ret -ne 0 ]; do
			{ cset shield --exec ./a.out -- $size1 $reps wb t 131072 $overhead $mem $temp; } > tmpout 2>> log
			ret=$?
			sleep 1
		done 
		cyca=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_TOT_CYC | cut -d: -f3`
		l3ra=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCR | cut -d: -f3`
		l3ma=`cat tmpout | grep PAPI_THREAD_A | grep PAPI_L3_TCM | cut -d: -f3`
		repsb=`cat tmpout | grep REPS_B | cut -d: -f2`
		echo $size1,$overhead,$temp,$cyca,$l3ra,$l3ma,$repsb
	else 
		echo "$f5,$f6,$f7,\"cyca\",\"l3ra\",\"l3ma\",\"repsb\""
	fi
done < doe.csv #>> data/MM_output.csv
