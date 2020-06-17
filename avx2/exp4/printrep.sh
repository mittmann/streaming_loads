#!/bin/bash
sizes=(16 128 512 1024 2048 $((3*1024)) $((4*1024)) $((5*1024)) $((6*1024)) $((7*1024)) $((8*1024)) $((12*1024)) $((16*1024)) $((32*1024)) $((64*1024)) $((128*1024)) $((256*1024))  $((512*1024)) $((1024*1024)) 1572864 )

for size1 in ${sizes[@]}; do
	reps=$(( (sizes[-1] *10 ) / size1 ))
		echo $size1 $reps
done
