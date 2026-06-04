#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities.sh

check_is_root

XLFS=$(get-value '.xlfs')

chown --from xlfs -R root:root $XLFS/{usr,var,etc,tools,flags,bin,lib,sbin}
case $(uname -m) in
  x86_64) chown --from xlfs -R root:root $XLFS/lib64 ;;
esac

chown --from xlfs -R root:root  $XLFS
