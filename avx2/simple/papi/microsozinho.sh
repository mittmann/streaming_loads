#!/bin/bash
microbenchdir=/root/microbenchmarks
export OMP_NUM_THREADS=3
export GOMP_CPU_AFFINITY=0-2
l3miss=LLC-load-misses
l3load=LLC-loads
cycles=cycles
bin=memory_load_ind

echo "\"rep\",\"prefetch\",\"size\",\"memtyp\",\"temp\",\"app\",\"displaysize\",\"cycles\",\"l3m\",\"l3l\""
for pref in "off"; do
	if [ $pref = "on" ]; then
		prefetch -e  &> /dev/null
	elif [ $pref = "off" ]; then
		prefetch -d  &> /dev/null
	fi
	for rep in `seq 1 30`; do
	for size in none; do
		for memtyp in none; do
			for temp in none; do
				#cset shield --exec ./loop $size $memtyp $temp >/dev/null & 
				
				#pid=$!
				for bin in memory_load_ind memory_load_dep memory_load_random; do
				for microsize in 524288 262144 131072 65536 32768 16384 8192 4096; do
					#time=`cat saidais | grep "Time in seconds" | awk '{ print $5 }'`
					comando=$nasdir/$nasbin
					reps=`echo 524288000/$microsize | \bc`

					sleep 1
					displaysize=`cset shield --exec perf -- stat -e LLC-load-misses,LLC-loads,cycles $microbenchdir/$bin $reps $microsize 2>/tmp/perfout | grep Memory | cut -f2 -d:`
					l3m=`cat /tmp/perfout | grep $l3miss | awk '{ print $1 }' `
					l3l=`cat /tmp/perfout | grep $l3load | awk '{ print $1 }' `
					cyc=`cat /tmp/perfout | grep $cycles | awk '{ print $1 }' `
					echo $rep,$pref,$size,$memtyp,$temp,$bin,$displaysize,$cyc,$l3m,$l3l
				done
			done
done
			#	kill -PIPE $pid
			done
		done
	done
done
