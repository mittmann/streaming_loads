#!/bin/bash
read -t 1 file
if [ -z "$file" ]; then
	file=$1
fi
prefetch -d &> /dev/null

echo \"counter\",\"size\",\"memtype\",\"temp\",\"opt\",\"value\"
for i in `seq 1 5`; do
	cat counters | while read -r counter; do echo $counter | ./$file ; done 
done
