#!/bin/bash
echo \"counter\",\"r\",\"version\",\"value\"
cat ../data/counters | while read -r counter; do echo $counter | ./perfall.sh ; done 
