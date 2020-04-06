#!/bin/bash

for i in `seq 1 2`; do
	t=$(./t | grep clock | awk '{print $2}')
	sumt=$((t + sumt))
	t=$(./nt | grep clock | awk '{print $2}')
	sumnt=$((t + sumnt))
	echo "sumt:  " $sumt
	echo "sumnt: " $sumnt
done

