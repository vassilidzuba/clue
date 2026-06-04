#!/bin/bash

if [ ! -f i_am_at_root ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run as user 'root'."
    exit 255
fi

source scripts/_utilities.sh

check_is_root

SHARED=.

XLFS=$(get-value '.xlfs')

echo "checking the device '$xlfs'is mounted..."
if ! mountpoint -q $XLFS ; then
    echo "The device is not mounted on $xlfs"
    exit 255
fi

mkdir -pv $XLFS/{dev,proc,sys,run,mnt/shared}

echo "mount /mnt/shared..."
if ! mountpoint -q $XLFS/mnt/shared ; then
    mount --bind $(readlink -f $SHARED) $XLFS/mnt/shared
    if [ $? != 0 ]; then
        echo "Mount of $XLFS/mnt/shared failed"
        exit 255
    fi
fi

if [ -d $XLFS/proc ]; then
    if ! mountpoint -q $XLFS/proc ] ; then
        exho "mount $XLFS/dev"
        mount -v --bind /dev $XLFS/dev

        echo "mount $XLFS/devpts"
        mount -vt devpts devpts -o gid=5,mode=0620 $XLFS/dev/pts
        echo "mount $XLFS/proc"
        mount -vt proc proc $XLFS/proc
        echo "mount $XLFS/sysfs"
        mount -vt sysfs sysfs $XLFS/sys
        echo "mount $XLFS/tmpfs"
        mount -vt tmpfs tmpfs $XLFS/run

        if [ -h $XLFS/dev/shm ]; then
            install -v -d -m 1777 $XLFS$(realpath /dev/shm)
        else
            mount -vt tmpfs -o nosuid,nodev tmpfs $XLFS/dev/shm
        fi
    fi
fi

if [ "$*" != "" ]; then
    command="-c $*"
fi

echo "Run chroot..."
echo "XLFS=$XLFS"
echo "TERM=$TERM"

chroot "$XLFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(xlfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j8"      \
    TESTSUITEFLAGS="-j8" \
    INCHROOT=1 \
    /bin/bash --login $command

if [ -d $XLFS/proc ]; then
    if mountpoint -q $XLFS/proc ; then

        mountpoint -q $XLFS/mnt/shared && umount $XLFS/mnt/shared
        mountpoint -q $XLFS/dev/shm && umount $XLFS/dev/shm
        umount $XLFS/dev/pts
        umount $XLFS/{sys,proc,run,dev}
    fi
fi
