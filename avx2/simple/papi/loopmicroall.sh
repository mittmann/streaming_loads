#!/bin/bash
microbenchdir=/root/microbenchmarks
export OMP_NUM_THREADS=3
export GOMP_CPU_AFFINITY=0-2
l3miss=LLC-load-misses
l3load=LLC-loads
cycles=cycles
bin=memory_load_ind

prefetch -d  &> /dev/null

echo "\"micro\",\"microsize\",\"size\",\"memtyp\",\"temp\",\"cycles\",\"l3m\",\"l3l\""
for bin in memory_load_ind memory_load_dep; do
	for microsize in 524288 262144 131072 65536 32768 16384 8192 4096; do
	#time=`cat saidais | grep "Time in seconds" | awk '{ print $5 }'`
	reps=99999999999
	$microbenchdir/$bin $reps $microsize >/dev/null & 
	pid=$!
	sleep 12
	for size in huge small; do
		for memtyp in wb wc; do
			for temp in t nt; do
					sleep 3
					cyc=`cset shield -e ./e.O2 $size $memtyp $temp PAPI_TOT_CYC | grep PAPI_VALUE | cut -f2 -d' '`
					sleep 1
					l3m=`cset shield -e ./e.O2 $size $memtyp $temp PAPI_L3_TCM | grep PAPI_VALUE | cut -f2 -d' '`
					sleep 1
					l3l=`cset shield -e ./e.O2 $size $memtyp $temp PAPI_L3_TCR | grep PAPI_VALUE | cut -f2 -d' '`
					echo $bin,$microsize,$size,$memtyp,$temp,$cyc,$l3m,$l3l
			done
		done
	done
	kill -PIPE $pid
	done
done
