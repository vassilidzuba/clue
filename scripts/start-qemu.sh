#!/bin/bash

if [ ! -f i_am_at_root ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run at the root of the repo."
    exit 255
fi

source scripts/_utilities.sh

for arg in "$@"; do
    case $arg in
        --dryrun)
            DRYRUN=true
            echo "*** dry run : $(basename $0)"
            ;;
        --force)
            echo 'force'
            ;;
        *)
            echo "unknown option: $arg"
            terminate
            ;;
    esac
done


xlfs=$(get-value '.xlfs')
devicetype=$(get-value '.devicetype')
device=$(get-value '.device')
image=$(get-value '.image')

if mountpoint -q $xlfs ; then
    WASMOUNTED=true
    if [ "$(whoami)" = "root" -o "$DRYRUN" = "true" ]; then
        scripts/umount.sh "$@"
    else
        echo "device '$device' is mounted on '$xlfs"
        echo "One needs to be root to unmount it"
        terminate
    fi
fi

VERSION=7.0.11

start-disk ()  {
    exec-command \
        "qemu-system-x86_64 \
            -kernel boot/vmlinuz-$VERSION-xlfs \
            -drive file=/dev/sdb,format=raw \
            -append 'root=/dev/sda5 console=ttyS0' \
            -enable-kvm \
            -cpu host \
            -nographic"
}

start-qemu ()  {
    kernel=boot/vmlinuz-$VERSION-xlfs
    # kernel=/boot/vmlinuz-7.0.3-lfs-13.0-systemd

    if [ -f boot/initramfs-$VERSION-xlfs ]; then
        initramfs="-initrd boot/initramfs-$VERSION-xlfs"
    fi


nographic=-nographic


    stty intr ^]
    exec-command \
      "qemu-system-x86_64 \
        -kernel $kernel \
        -append \"root=/dev/sda1 rw console=ttyS0\" \
        -enable-kvm \
        -cpu host \
        -m 4G \
        -netdev user,id=net0,hostfwd=tcp::2222-:22 \
        -device e1000,netdev=net0 \
        $initramfs \
        $nographic \
        -virtfs local,path=/home/vassili/git/clue,mount_tag=CLUE,security_model=mapped-xattr,readonly,multidevs=warn \
        $image"
}


case "$devicetype" in
    qemu)
        start-qemu
       ;;
    disk)
        start-disk
       ;;
    *)
        echo "Unknown device type: '$devicetype'"
        ;;
esac

if [ "$WASMOUNTED" = "true" ]; then
    scripts/mount.sh $@
fi
