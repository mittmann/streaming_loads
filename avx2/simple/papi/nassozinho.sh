#!/bin/bash
export OMP_NUM_THREADS=3
export GOMP_CPU_AFFINITY=0-2
size=none
memtyp=none
temp=none
			for nasbin in `ls /home/arthur/nas/NPB3.4/NPB3.4-OMP/bin | grep C`; do
				#time=`cat saidais | grep "Time in seconds" | awk '{ print $5 }'`
				sleep 1
				time=`nice --20 /home/arthur/nas/NPB3.4/NPB3.4-OMP/bin/$nasbin | grep "Time in seconds" | awk '{ print $5 }' `
				echo $size,$memtyp,$temp,$nasbin,$time
			done
