#!/bin/bash
echo \"counter\",\"version\",\"value\"
for i in `seq 1 20`; do
	cat counters | while read -r counter; do echo $counter | ./perfall.sh ; done 
done
