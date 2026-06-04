#!/bin/bash

if [ "$INCHROOT" = "" ]; then
    echo "should be run in CHROOT"
    exit 255
fi


if [ "$1" = "" ]; then
    echo "usage : x1.sh <script prefix"
    exit 255
fi

cd /mnt/shared

file="$(ls stage1/scripts/$1* 2> /dev/null)"
nbfiles=$(echo "$file" | wc -l)

# echo "FILE = <$file>"

if [ "$file" = "" ]; then
    echo "No script found : $1"
    exit 255
fi

if [ "$nbfiles" -gt "1" ]; then
    echo "ambiguous prefix : $1"
    echo "$file"
    exit 255
fi

echo executing "$file"
src=$(basename $file)
$file --force $2 $3 $4 $5 $6 | tee /var/log/stage1/$src.log
