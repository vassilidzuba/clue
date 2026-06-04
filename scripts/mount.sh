#!/bin/bash


if [ ! -f i_am_at_root ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run as user 'root'."
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
xlfs=$(get-value '.xlfs')
fstype=$(get-value '.fstype')
image=$(get-value '.image')
partition=$(get-value '.partition')
luks=$(get-value '.luks')
luks_name=$(get-value '.luks_name')
passphrase="$(get-value '.luks_passphrase')"

if mountpoint -q $xlfs; then
    if [ "$DRYRUN" != "true" ]; then
        echo "The device is already mounted on $xlfs"
        terminate
    fi
fi

if [ "$devicetype" = "other" ]; then
    echo "This script is not used when devicetype is 'other'"
    terminate
fi

if [ "$devicetype" = "qemu" ]; then
    if [ ! -e /dev/nbd0 ]; then
        exec-command "modprobe nbd max_part=8"
    fi

    exec-command "qemu-nbd --connect=$device $image"
    [ "$DRYRUN" = "true" ] || sleep 3
fi

mapped_partition="$partition"
if [ "$luks" = "true" ]; then
    if [ "$passphrase" = "-" ]; then
        exec-command "cryptsetup open $partition $luks_name --type luks"
    else
        exec-command "echo -n '$passphrase' | cryptsetup open $partition $luks_name -d - --type luks"
    fi

    mapped_partition="/dev/mapper/$luks_name"
fi


case "$fstype" in
    ext4)
        exec-command "mount $mapped_partition $xlfs"
        ;;
    btrfs)
        exec-command "mount --mkdir -o noatime,space_cache=v2,discard=async,subvol=@ $mapped_partition $xlfs"
        exec-command "mount --mkdir -o noatime,space_cache=v2,discard=async,subvol=@home $mapped_partition $xlfs/home"
        ;;
    *)
        echo "unexpected fs type: $fstype"
        terminate
        ;;
esac

if [ "$DRYRUN" = "true" ]; then
    echo "*** $(basename $0) completed"
fi
