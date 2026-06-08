#/bin/bash

if [ $(whoami) != 'root' ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run as user 'root'."
    exit 255
fi

MNT=/mnt/shared

if [ ! -d "$MNT"  ]; then
    echo "Mount point $MNT does not exists." \
         "You're probably not in the right environment"
    exit 255
fi

if mountpoint -q $MNT; then
    echo "Already mounted"
    exit 255
fi

if [[ $(cat /proc/version) =~ "xlfs"  ]]; then
    echo "Not running the XLFS installation"
    exit 255
fi

mount -t 9p -o trans=virtio CLUE $MNT
