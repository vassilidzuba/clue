#!/bin/bash

if [ ! -f i_am_at_root ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run as user 'root'."
    exit 255
fi

CONFIG=config.yaml

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --config=*)
            CONFIG="${1#*=}"
            shift
            ;;
        *)
            echo "unknown option: $arg"
            exit 255
            ;;
    esac
done

if [ ! -f "$CONFIG" ]; then
    echo "Configuration file '$CONFIG' is missing"
    exit 255
fi

source scripts/_utilities.sh

## suffix


P_SUFFIX="$(get-value '.suffix')"
if [ "$P_SUFFIX" = "" ]; then
    echo "The property 'suffix' is missing"
fi

P_DEVICETYPE="$(get-value '.devicetype')"
if [ "$P_DEVICETYPE" = "" ]; then
    echo "The property 'devicetype' is missing"
else
    if [ "$P_DEVICETYPE" != "qemu" -a "$P_DEVICETYPE" != "disk" ]; then
        echo "The property 'devicetype' has an illegal value: '$P_DEVICETYPE'"
        echo "  valid values are: qemu, disk"
    fi
fi

if [ "$P_DEVICETYPE" = "qemu" ]; then
    P_IMAGE="$(get-value '.image')"
    if [ "$P_IMAGE" = "" ]; then
        echo "When device type is 'qemu', image is required"
    fi
    P_IMAGE_SIZE="$(get-value '.image_size')"
    if [ "$P_IMAGE_SIZE" = "" ]; then
        echo "When device type is 'qemu', image_size is required"
    fi
fi


P_FSTYPE="$(get-value '.fstype')"
if [ "$P_FSTYPE" = "" ]; then
    echo "The property 'fstype' is missing"
else
    if [ "$P_FSTYPE" != "ext4" -a "$P_FSTYPE" != "bbtrfs" ]; then
        echo "The property 'fstype' has an illegal value: '$P_FSTYPE'"
        echo "  valid values are: ext4, btrfs"
    fi
fi

echo
echo "Configuration is"
echo
echo "SUFFIX:         $P_SUFFIX"
echo "DEVICETYPE:     $P_DEVICETYPE"
echo "IMAGE:          $P_IMAGE"
echo "IMAGER_SIZE:    $P_IMAGE_SIZE"
echo "FSTYPE:         $P_FSTYPE"
