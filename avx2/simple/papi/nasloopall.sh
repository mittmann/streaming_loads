#!/bin/bash
nasdir=/home/arthur/nas/NPB3.4/NPB3.4-OMP/bin
export OMP_NUM_THREADS=3
export GOMP_CPU_AFFINITY=0-2
l3miss=LLC-load-misses
l3load=LLC-loads
l1miss=L1-dcache-load-misses
l1load=L1-dcache-loads


echo "\"prefetch\",\"size\",\"memtyp\",\"temp\",\"app\",\"time\",\"l3m\",\"l3l\",\"l1m\",\"l1l\""
for pref in "on" "off"; do
	if [ $pref = "on" ]; then
		prefetch -e  &> /dev/null
	elif [ $pref = "off" ]; then
		prefetch -d  &> /dev/null
	fi
	for size in huge small; do
		for memtyp in wb wc; do
			for temp in t nt; do
				cset shield --exec ./loop $size $memtyp $temp >/dev/null & 
				pid=$!
				sleep 15
				for nasbin in `ls /home/arthur/nas/NPB3.4/NPB3.4-OMP/bin`; do
					#time=`cat saidais | grep "Time in seconds" | awk '{ print $5 }'`
					comando=$nasdir/$nasbin
					if [ $(echo $nasbin | grep S | wc -l) = "1" ]; then
						comando="for i in `seq 1 100`; do $comando; done"
					elif [ $(echo $nasbin | grep W | wc -l) = "1" ]; then
						comando="for i in `seq 1 25`; do $comando; done"
					fi	
					sleep 5
					time=`nice --20  perf stat -e LLC-load-misses,LLC-loads,L1-dcache-load-misses,L1-dcache-loads /home/arthur/nas/NPB3.4/NPB3.4-OMP/bin/$nasbin 2>/tmp/perfout | grep "Time in seconds" | awk '{ print $5 }' `
					l3m=`cat /tmp/perfout | grep $l3miss | awk '{ print $1 }' `
					l3l=`cat /tmp/perfout | grep $l3load | awk '{ print $1 }' `
					l1m=`cat /tmp/perfout | grep $l1miss | awk '{ print $1 }' `
					l1l=`cat /tmp/perfout | grep $l1load | awk '{ print $1 }' `
					echo $pref,$size,$memtyp,$temp,$nasbin,$time,$l3m,$l3l,$l1m,$l1l
				done
				kill -PIPE $pid
			done
		done
	done
done
