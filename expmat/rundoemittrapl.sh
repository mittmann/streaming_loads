#!/bin/bash
# sem cset e reps diferentes
bin=./multi256
core1=1
core2=3
counter1=RAPL_ENERGY_CORES:cpu=$core1
counter2=RAPL_ENERGY_PKG:cpu=$core1
sizes=( 0  1024 2048 $((3*1024)) $((4*1024)) $((5*1024)) $((6*1024)) $((7*1024)) $((8*1024)) $((12*1024)) $((16*1024)) $((32*1024)) $((64*1024)) $((128*1024)) $((256*1024))  $((512*1024)) $((1024*1024)) 1572864 )
repts=( 0  63951 31963 20981 15611 11134 7516 7400 5500 2320 1415 553 250 120 60 30 15 10 )
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
		echo $size1, $reps1, $mem1, $temp1, $size2, $reps2, $mem2, $temp2 >> log
		ret=1
		while [ $ret -ne 0 ]; do
			sleep 1
			{ taskset -c $core1 $bin $size1 $reps1 $mem1 $temp1 $size2 $reps2 $mem2 $temp2 $core1 $core2 $counter1 $counter2; } > tmpout 2>> log
			ret=$?
		done
		cyca=`cat tmpout | grep PAPI_THREAD_A | grep $counter1 | cut -d';' -f3`
		l3ra=`cat tmpout | grep PAPI_THREAD_A | grep $counter2 | cut -d';' -f3`
		cycb=`cat tmpout | grep PAPI_THREAD_B | grep $counter1 | cut -d';' -f3`
		l3rb=`cat tmpout | grep PAPI_THREAD_B | grep $counter2 | cut -d';' -f3`
		echo $size1,$size2,$temp,$cyca,$l3ra,$cycb,$l3rb
		sleep 2
	else 
		echo $f5,$f6,$f7,\"coresa\",\"pkga\",\"coresb\",\"pkgb\"
	fi
done < doe.csv #>> data/MM_output.csv


