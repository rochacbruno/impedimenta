boot with an initramfs
======================

Goal: Create an initramfs for an existing installation, and get the cubox to
boot sucessfully.

create an initramfs
-------------------

1.  update /etc/mkinitcpio.conf

        $ # NOTE: I was adding raid0 mdadm support to the initramfs.
        $ vim mkinitcpio.conf
        $ grep ^MODULES mkinitcpio.conf && grep ^HOOKS mkinitcpio.conf
        MODULES="raid0 dm_mod" # FIXME: dm_mod may be unnecessary.
        HOOKS="base udev autodetect sata filesystems usbinput fsck mdadm_udev"

2.  verify and generate an initramfs

        $ mkinitcpio # this should succeed
        $ mkinitcpio -g initramfs.gz

3.  gunzip the initramfs

        $ bash -c 'gunzip -c initramfs.gz initramfs'

4.  prep the initramfs for u-boot

        $ mkimage -A arm -O linux -T ramdisk -C none -n "Linux" -d initramfs \
          uInitramfs

create a boot script
--------------------

1.  create and populate a boot script

        $ vim boot.scr boot.txt
        $ # Use your text editor to copy the contents of boot.scr into boot.txt,
        $ # remove weird header junk at beginning of boot.txt, and modify
        $ # boot.txt as necessary.
        $ cat boot.txt
        ======== Setting bootargs ========
        setenv bootargs 'console=ttyS0,115200n8 vmalloc=384M
          root=/dev/disk/by-uuid/... video=dovefb:lcd0:1920x1080-32@60-edid
          clcd.lcd0_enable=1 clcd.lcd1_enable=0'
        echo ======== Loading kernel ========
        ext2load mmc 0:1 0x00200000 /boot/uImage
        ext2load mmc 0:1 0x01100000 /boot/uInitramfs
        echo ======== Booting kernel ========
        bootm 0x00200000 0x01100000

2.  prep the script for u-boot

        $ mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n \
          'Boot script for CuBox SD card.' -d boot.txt boot.scr

references
----------

[Punkley](http://www.solid-run.com/phpbb/viewtopic.php?f=7&t=756) knew what
memory addreses to use in the boot.scr file.

[shenki](http://forums.gentoo.org/viewtopic-p-6511131.html) knew how to prep
initramfs files with mkimage.

result
------

Success? The kernel and initramfs images are loaded into memory sucessfully, and
the kernel starts booting.

get root filesystem off SD card
===============================

problem: Placing the root filesystem on an SD card results in deathly slow
filesystem access.

solution: Leave /boot on the SD card and place the root filesystem on an mdadm
raid device.

problem: The kernel doesn't support raid devices at boot time.

solution: Create an initramfs.

problem: Don't you need an existing installation to make a new initramfs?

solution: ...maybe?
