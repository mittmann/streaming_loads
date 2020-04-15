#!/bin/bash
echo \"counter\",\"version\",\"value\"
for i in `seq 1 4`; do
	cat counterssimples | while read -r counter; do echo $counter | ./perfall.sh ; done 
done
