#/bin/bash
rmmod uncached_ram
rm unc
cd ../uncached-ram-lkm
make clean
make
insmod uncached_ram.ko
cd ../papi
sleep 2
num=`tail /var/log/kern.log | grep "Created char device" | tail -n1 | awk '{print $NF}'`
echo num:$num
mknod unc c $num 0
