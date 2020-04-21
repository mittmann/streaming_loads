#/bin/bash
insmod ../uncached-ram-lkm/uncached_ram.ko
num=`tail /var/log/kern.log | grep "Created char device" | tail -n1 | awk '{print $NF}'`
echo num:$num
mknod dev c $num 0
