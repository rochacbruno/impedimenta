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

However, the root filesystem fails to mount sucessfully. That was the intended
benefit of this exercise.

    Uncompressing Linux... done, booting the kernel.
    m25p80 spi0.0: unrecognized JEDEC id 20ba16
    Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

get root filesystem off SD card
===============================

problem: Placing the root filesystem on an SD card results in deathly slow
filesystem access.

solution: Leave /boot on the SD card and place the root filesystem on an mdadm
raid device.

problem: The kernel doesn't support raid devices at boot time.

solution: Create an initramfs.

problem: Don't you need an existing installation to make a new initramfs?

solution: ...maybe? Let's [have a
read](http://en.gentoo-wiki.com/wiki/Initramfs).

big bang approach
-----------------

1. Extract cubox fs on software raid.
2. Format SD card as ext3, and move uImage to SD card.
3. Create custom initramfs, and move to boot.scr. TODO: How?
4. Create new boot.scr
5. Boot up. Success?

### Advantages

Potentially more clean from a technical perspective. Extensible -- create any
root fs you want in advance, and you can just pop it on the machine with a
minimum of fuss.

### Disadvantages

Potentially less clean from a technical perspective, because knowledge of the
target setup is required to create the custom initramfs. Also potentially
kludgy, because knowledge of the current kernel may be required. Also: requires
research.

mutation approach
-----------------

1. Install cubox fs on SD card.
2. Boot up.
    1. Install mdadm.
    2. Update mkinitcpio.conf, create an initramfs, package initramfs for uboot.
    3. Create new boot.scr.
    4. Update fstab.
3. Shut down. Move root fs to software raid.
4. Boot up. Success?

### Advantages:

Should be more straightforward. You can create all the necessary files within
working OS install.

### Disadvantages:

Slow as death. Kludgy. Tried this already, and it didn't work!
