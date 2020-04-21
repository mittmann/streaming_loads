#!/bin/bash
echo \"counter\",\"size\",\"memtype\",\"temp\",\"opt\",\"value\"
for i in `seq 1 2`; do
	cat counters | while read -r counter; do echo $counter | ./papiall.sh ; done 
done
