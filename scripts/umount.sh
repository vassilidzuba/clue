#!/bin/bash

if [ ! -f i_am_at_root ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run at the root of the repo."
    exit 255
fi

for arg in "$@"; do
    case $arg in
        --dryrun)
            DRYRUN=true
            echo "*** dry run : $(basename $0)"
            ;;
        *)
            echo "unknown option: $arg"
            terminate
            ;;
    esac
done

source scripts/_utilities.sh

if [ "$DRYRUN" != "true" ]; then
    check_is_root
fi

devicetype=$(get-value '.devicetype')
device=$(get-value '.device')
device=$(get-value '.partition')
xlfs=$(get-value '.xlfs')
fstype=$(get-value '.fstype')
luks=$(get-value '.luks')
luks_name=$(get-value '.luks_name')
partition=$(get-value '.partition')

if [ "$devicetype" = "other" ]; then
    echo "This script is not used when devicetype is 'other'"
    terminate
fi


if ! mountpoint -q $xlfs ; then
    echo "The volume '$xlfs' is not mounted"
else
    case "$fstype" in
        ext4)
            exec-command "umount $xlfs"
            ;;
        btrfs)
            exec-command "umount $xlfs/home"
            exec-command "umount $xlfs"
            ;;
        *)
            echo "unexpected fs type : $fstype"
            terminate
            ;;
    esac
fi

if [ "$luks" = "true" -a  -e "/dev/mapper/$luks_name" ]; then
    exec-command "cryptsetup close $luks_name"
fi

if [ -e "/dev/nbd2" -a "$devicetype" = "qemu" ]; then
    exec-command "qemu-nbd --disconnect $(get-value '.device')"
    exec-command "rmmod nbd"
fi


if [ "$DRYRUN" = "true" ]; then
    echo "*** $(basename $0) completed"
fi
