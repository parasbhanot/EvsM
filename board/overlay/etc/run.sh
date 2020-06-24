echo "updating Linux" >/dev/kmsg
dd if=/media/usb0/paras/Image/emmc.img of=/dev/mmcblk0 bs=4M conv=fsync status=progress
if [ $? -eq 0 ];then
	echo "Updation Complete" >/dev/kmsg
	echo "S" >/etc/udone.txt
else
	echo "Updation failed" >/dev/kmsg
	echo "F" >/etc/udone.txt
fi
