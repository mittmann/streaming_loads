#!/bin/bash
echo \"counter\",\"version\",\"value\"
cat counters | while read -r counter; do echo $counter | ./perfall.sh ; done 
