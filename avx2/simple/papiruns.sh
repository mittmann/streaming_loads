#/bin/bash
for size in small big; do
	for mem in unc wb; do
		for temp in t nt; do
			time=`./papisrc/a.out $size $mem $temp | grep value | cut -f2 -d' '`
			echo $size,$mem,$temp,$time
done
done
done
