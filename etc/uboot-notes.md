sample mkimage commands
=======================

    mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n 'CuBox boot script'
    -d boot.txt boot.scr

    mkimage -A arm -O linux -T ramdisk -C none -n 'Initial ramdisk'
    -d initramfs uInitramfs