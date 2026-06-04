#!/bin/bash

if [ ! -f i_am_at_root ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run at the root of the repo."
    exit 255
fi

source scripts/_utilities.sh
XLFS=

run () {
    if [ -f $XLFS/flags/stage1/$1 ]; then
        echo "Script already executed: $1."
        return
    fi
    if [ "$INCHROOT" = "1" ]; then
        cd /mnt/shared
        stage1/scripts/$1 $2 $3 $4 $5 $6 2>&1 | tee /var/log/stage1/$1.log
    else
        XLFS=$(get-value '.xlfs')
        scripts/chroot.sh /mnt/shared/stage1/scripts/$1 $2 $3 $4 $5 $6 2>&1 | tee $XLFS/var/log/$1.log
    fi
    if [ ! -f $XLFS/flags/stage1/$1 ]; then
        echo "Last command $1 failed, build is interrupted. Sorry."
        exit 255
    fi
}

with-option () {
    if [ "$(get-value .options.with_$1)" == "true" ]; then
        (exit 0)
    else
        (exit 1)
    fi
}


run B000-create-user.sh
run B007-wget.sh
run B008-openssh.sh

with-option s6 && run E001-skalibs.sh
with-option s6 && run E002-exeline.sh
with-option s6 && run E003-s6.h

with-option simple && run E011-simple-init.sh
with-option simple || with-option s6 && run E012-dnsmasq.sh
with-option simple && run E013-simple-ca.sh
with-option simple && run E014-util-linux.sh

with-option btrfs && run B009-lzo.sh
with-option btrfs && run B010-btrfs-progs.sh

run B018-nettle.sh
run B005-libxml2.sh
run B015-libunistring.sh
run B016-libidn2.sh
run B014-libpsl.sh
run B013-curl.sh
run B019-libarchive.sh
run B020-libuv.sh
run B012-cmake.sh
run B011-json-c.sh

with-option initramfs && run B003-cpio.sh
with-option initramfs && run E008-dracut-install.sh
with-option initramfs && run E009-dracut-run.sh
