#/bin/bash
rmmod writecombine_ram
rm wc
cd ../simple/uncached-ram-lkm-wc
make clean
make
insmod writecombine_ram.ko
cd ../../exp5
sleep 2
num=`tail /var/log/kern.log | grep "Created char device" | tail -n1 | awk '{print $NF}'`
echo num:$num
mknod wc c $num 0
