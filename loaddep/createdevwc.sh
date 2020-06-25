#/bin/bash
rmmod writecombine_ram
rm wc
cd ../avx2/simple/uncached-ram-lkm-wc
make clean
make
insmod writecombine_ram.ko
cd ../../../loaddep
sleep 2
num=`tail /var/log/kern.log | grep "Created char device" | tail -n1 | awk '{print $NF}'`
echo num:$num
mknod wc c $num 0
chown $SUDO_USER wc
chgrp $SUDO_USER wc
