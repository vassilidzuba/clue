#!/bin/bash

if [ ! -f i_am_at_root ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run as user 'root'."
    exit 255
fi

source scripts/_utilities.sh

xlfs=$(get-value '.xlfs')

echo stage1
ls -1 $xlfs/flags/stage1/*
echo stage2
ls -1 $xlfs/flags/stage2/*
