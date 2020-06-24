 
#!/bin/bash

echo "Stating Update " >/dev/kmsg

cat /media/usb0/split/x* > /mnt/newRoot/rootfs.tar


if [ $? -eq 0 ]
then
    echo "rootfs.tar combined Successful" >/dev/kmsg
else
    echo "rootfs.tar combined failed" >/dev/kmsg
    echo "update failed either due to flash drive not attached or firmware file not found" >/dev/kmsg
    echo F >/root/status
    sleep 10s
    #exit 1
    reboot
fi

echo -n "hash of the rootfs is : " >/dev/kmsg
md5sum /mnt/newRoot/rootfs.tar >/dev/kmsg

echo "erazing the old root " >/dev/kmsg
cd /mnt/oldRoot
chattr -i etc/resolv.conf >/dev/kmsg
rm -R * 
echo "Erasure of old Rootfs complete " >/dev/kmsg


cd /mnt/newRoot

echo "Extracting New Rootfs " >/dev/kmsg
tar -xvf rootfs.tar -C /mnt/oldRoot
echo "Extraction of New Rootfs is complete" >/dev/kmsg

cd /mnt/boot

echo "Switching from initramfs to New rootfs" >/dev/kmsg
rm uboot.env

echo P >/root/status

echo "update Sucessfull" >/media/usb0/update.log

echo "Rebooting itself in 10 sec" >/dev/kmsg
sleep 10s

reboot
