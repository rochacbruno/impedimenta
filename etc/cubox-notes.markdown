How To Host an Arch Linux ARM Root Filesystem on Software RAID
==============================================================

I bought a [CuBox](http://solid-run.com/) about three months back with the
intent of creating a low-power home server. I've been running it on Arch Linux,
and the combination works well -- I've gotten over 50 days of uptime, and I'm
sure it's capable of much more.  However, there's one big drawback: the entire
filesystem is hosted on an SD card, which is deathly slow. The CuBox has an
integrated eSata port, so I decided to host the root filesystem on a pair of
hard drives striped together with software raid. (the external enclosure made
both disks available through the single eSata port via JBOD mode)

Installing the root filesystem onto a software raid device wouldn't be too hard
with the x86 Arch installer. With that installer, you can simply mount the
target partitions together as desired, use `pacstrap` to install a base system,
chroot in, and configure extras like the initial ramdisk. However, no such
installer exists for Arch ARM. Instead, you simply download a filesystem tarball
and extract it onto the SD card. (or USB drive) While this is convenient, it's
much more limiting than the x86 Arch installer.

I currently don't have the skills to create a custom root filesystem tarball,
nor do I know how to cross-compile a kernel and initramfs. Thus, the solution I
lit upon is a bit kludgy. The solution requires you to install Arch on an SD
card as normal, then create an initramfs and move the root filesystem after the
fact.

install, create software raid
-----------------------------

If you've not already done so, install Arch onto the SD card. Boot up the system
and install available updates. Install mdadm, partition the device onto which
your root filesystem will be moved, and format it.

    # fdisk /dev/sda
    # fdisk /dev/sdb
    # mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sda1 /dev/sdb1
    # mkfs.ext4 /dev/md0
    # lsblk
    NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
    sda           8:0    0 298.1G  0 disk
    '-sda1        8:1    0 298.1G  0 part
      '-md0       9:0    0 596.2G  0 raid0
    sdb           8:16   0 298.1G  0 disk
    '-sdb1        8:17   0 298.1G  0 part
      '-md0       9:0    0 596.2G  0 raid0
    mmcblk0       179:0  0   7.4G  0 disk
    '-mmcblk0p1   179:1  0   7.4G  0 part
    # cat /proc/mdstat
    Personalities : [raid0]
    md0 : active raid0 sdb1[1] sda1[0]
    625139712 blocks super 1.2 512k chunks

    unused devices: <none>

create an initramfs
-------------------

The kernel cannot access and mount the root filesystem during boot unless you
provide the necessary modules. Note that I've included "ext4" in modules,
because the partition on my raid device is formatted as such.

1.  update /etc/mkinitcpio.conf

        # vim mkinitcpio.conf
        $ grep ^MODULES mkinitcpio.conf && grep ^HOOKS mkinitcpio.conf
        MODULES="raid0 ext4 dm_mod" # FIXME: dm_mod may be unnecessary.
        HOOKS="base udev autodetect filesystems fsck usbinput mdadm_udev"

2.  verify and generate an initramfs

        $ mkinitcpio # this should succeed
        # mkinitcpio -g initramfs.gz

3.  gunzip the initramfs

        # gunzip -c initramfs.gz > initramfs

4.  make the initramfs accessible by u-boot

        # mkimage -A arm -O linux -T ramdisk -C none -n "Linux" -d initramfs \
        uInitramfs

create a boot script, update fstab
----------------------------------

Up to this point, you've been able to reboot just fine. After this step, that's
no longer true.

The boot script (the equivalent of the grub2 or syslinux boot script) needs to
be updated. Otherwise, it won't load your shiny new uInitramfs or point to the
correct root device.

1.  create and populate a boot script

        $ vim boot.scr boot.txt
        $ # Copy boot.cr to boot.txt, remove the header junk at the beginning of
        $ # the boot.txt file, and modify boot.txt as appropriate.
        $ cat boot.txt
        echo ==== Setting bootargs ====
        setenv bootargs '
            console=ttyS0,115200n8
            rw
            vmalloc=384M
            root=/dev/md0
            init=/bin/systemd
            video=dovefb:lcd0:1280x720-32@60-edid 
            clcd.lcd0_enable=1
            clcd.lcd1_enable=0
            usb0Mode=host
            usb1Mode=host
            '
        echo ==== Loading kernel ====
        ext2load mmc 0:1 0x00200000 /boot/uImage
        echo ==== Loading initramfs ====
        ext2load mmc 0:1 0x01100000 /boot/uInitramfs
        echo ==== Booting kernel ====
        bootm 0x00200000 0x01100000

2.  make the boot script accessible by u-boot

        $ mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n \
        'CuBox boot script' -d boot.txt boot.scr

Some pointers:

* I gunzip the initramfs because I've empirically found that booting will fail
with an "out of memory" error if I leave the initramfs gzipped.
* Setting root=UUID=... fails
* setting root=/dev/disk/by-uuid/... fails

move the root filesystem to the device
--------------------------------------

During the "prep work" step, you created a software raid device. Right? Great.
Shut down the CuBox and pull out the SD card. Attach both the SD card and raid
device to another PC. Use this machine to shuffle data around. You could
conceivably do this from the CuBox itself, but I suspect that doing so could
leave the resultant system in an inconsistent state. The result is something
like this:

    $ ls /path/to/sd
    boot.scr
    boot.scr.mmcblk0p1
    boot.scr.old
    boot.scr.sata
    boot.scr.sda1
    boot.txt
    ext4
    initramfs
    initramfs.gz
    lost+found
    uImage
    uInitramfs
    $ ls /path/to/raid-device
    bin
    boot
    dev
    etc
    home
    lib
    lost+found
    mnt
    opt
    proc
    root
    run
    sbin
    srv
    sys
    tmp
    usr
    var
    $ cat /path/to/raid-device/etc/fstab
    #
    # /etc/fstab: static file system information
    #
    # <file_system> <dir>  <type>  <options>  <dump>  <pass>
    /dev/mmcblk0p1  /boot  ext3    defaults   0       2
    /dev/md0        /      ext4    defaults   0       1

Tip: when copying filesystem data, use the --preserve option.

    cp -r --preserve /path/to/sd /path/to/raid-device

Finally, reassemble the CuBox and power it up. Either dance with joy or curse
the heavens, depending.

limitations
-----------

Each time a new kernel is installed, you'll need to create a new intramfs
manually. Otherwise, booting will fail. I expect there's some method by which
this can be done automatically, but I don't know what it is.

bonus points
------------

Make a backup copy of your filesystem. This whole process took long enough.

references
----------

[Punkley](http://www.solid-run.com/phpbb/viewtopic.php?f=7&t=756) knew what
memory addreses to use in the boot.scr file.

[shenki](http://forums.gentoo.org/viewtopic-p-6511131.html) knew how to prep
initramfs files with mkimage.
