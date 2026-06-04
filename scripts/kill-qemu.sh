#!/bin/bash

pid=$(ps -C qemu-system-x86_64 --noheader -o pid | tr -d ' ')
if  [ "$pid" = "" ]; then
    echo "qemu is not running"
else
    sudo kill -9 "$pid"
fi
