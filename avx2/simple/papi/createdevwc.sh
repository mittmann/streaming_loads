#/bin/bash
insmod ../uncached-ram-lkm-wc/writecombine_ram.ko
sleep 2
num=`tail /var/log/kern.log | grep "Created char device" | tail -n1 | awk '{print $NF}'`
echo num:$num
mknod wc c $num 0
