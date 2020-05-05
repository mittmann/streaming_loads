#!/bin/bash
prefetch -d &> /dev/null
echo \"counter\",\"size\",\"memtype\",\"temp\",\"opt\",\"value\"
for i in `seq 1 5`; do
	cat counters | while read -r counter; do echo $counter | ./papiall.sh ; done 
done
