#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
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
fstype=$(get-value '.fstype')
xlfs=$(get-value '.xlfs')
luks=$(get-value '.luks')
luks_name=$(get-value '.luks_name')
passphrase="$(get-value '.luks_passphrase')"
label=$(get-value '.label')
image=$(get-value '.image')
image_size=$(get-value '.image_size')
partition=$(get-value '.partition')

if [ ! -d "$xlfs" ]; then
    if [ "$DRYRUN" = "true" ]; then
        echo "### creating mount point $xlfs"
        exec-command "mkdir $xlfs"
    else
        echo "The mount point '$xlfs' does not exists"
        echo "Continuing will create it"
        confirm
        mkdir $xlfs
    fi
fi


if [ "$devicetype" = "other" ]; then
    echo "This script is not used when devicetype is 'other'"
    terminate
fi

if [ "$devicetype" = "qemu" ]; then
    echo
    echo "### Creating qemu image"
    if [ -f $image -a "$DRYRUN" != "true" ]; then
        echo "The image '$image' exists already."
        echo "continuing would destroy it."
        confirm
        exec-commend "rm -rf $image"
    fi

    exec-command "qemu-img create -f qcow2 $image $image_size"
    if [ ! -e /dev/nbd0 ]; then
        exec-command "modprobe nbd max_part=8"
    fi

    device=$(get-value '.device')
    exec-command "qemu-nbd --connect=$device $image"

    echo
    echo "### Creating partition table"
    exec-command "parted -s $device mklabel gpt mkpart primary 0% 100%"
    exec-command "partprobe $device"
fi

# if no encryption, mapped partition is the same as partition
mapped_partition="$partition"
if [ "$luks" = "true" ]; then
    echo
    echo "### Encrypting partition"
    if [ "$passphrase" = "-" ]; then
        exec-command "cryptsetup luksFormat -v -s 512 -h sha512 $partition"
        exec-command "cryptsetup open $partition $luks_name --type luks"
    else
        exec-command "echo -n '$passphrase' | cryptsetup luksFormat -d - -v -s 512 -h sha512 $partition"
        exec-command "echo -n '$passphrase' | cryptsetup open $partition $luks_name -d - --type luks"
    fi

    mapped_partition="/dev/mapper/$luks_name"
fi

echo
echo "### Formatting partition"
case "$fstype" in
    ext4)
        command="mkfs.ext4 $mapped_partition -L $label"
        ;;
    btrfs)
        command="mkfs.btrfs $mapped_partition -L $label"
        ;;
    *)
        echo "unexpected fs type: $fstype"
        terminate
        ;;
esac

if [ "$devicetype" = "$disk" ]; then
    exec-command "wipefs -a -f -q $1"
fi
exec-command "$command"

if [ "$fstype" = "btrfs" ]; then
    echo
    echo "### Creating the BTRFS subvolumes"
    exec-command "mount $mapped_partition $xlfs"
    exec-command "pushd $xlfs"
        exec-command "btrfs subvolume create @"
        exec-command "btrfs subvolume create @home"
    exec-command popd
    exec-command "umount $xlfs"

fi

echo
echo "### Releasing resources"

exec-command "sync"
exec-command "sync"
exec-command "sync"

if [ "$devicetype" = "qemu" ]; then
    if [ "$luks" = "true" ]; then
        exec-command "cryptsetup close $luks_name"
    fi
fi

if [ "$devicetype" = "qemu" ]; then
    exec-command "qemu-nbd --disconnect $device"
fi
