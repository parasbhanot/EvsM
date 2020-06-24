 
#!/bin/bash


version=2

newPath="/mnt/newRoot/fware"

echo "i am version $version" > /dev/kmsg

echo "Stating Update " >/dev/kmsg

cp -R /media/usb0/fware/ /mnt/newRoot

if [ $? -eq 0 ]
then
    echo "copying Successful" >/dev/kmsg
else
    echo "copying  failed" >/dev/kmsg
    echo "update failed either due to flash drive not attached or firmware file not found" >/dev/kmsg
    echo F >/root/status
    sleep 10s
    #exit 1
    reboot
fi

cd $newPath

#export LD_LIBRARY_PATH=/usr/local/lib

#gpg --ignore-time-conflict --import mis.asc 

gpg --passphrase voltron --batch --yes --no-tty rootfs.tar.gpg


#echo -n "hash of the rootfs is : " >/dev/kmsg
#md5sum /mnt/newRoot/fware/rootfs.tar >/dev/kmsg

echo "erazing the old root " >/dev/kmsg
cd /mnt/oldRoot
chattr -i etc/resolv.conf >/dev/kmsg
rm -R * 
echo "Erasure of old Rootfs complete " >/dev/kmsg

cd $newPath

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
