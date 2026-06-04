#!/bin/bash

if [ "$INCHROOT" != "1" ]; then
    echo "Not in chroot"
    exit 255
fi
cd /mnt/shared
if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_stage1.sh

PACKAGE=meson-1.10.1
SOURCE=meson-1.10.1.tar.gz
URL=https://github.com/mesonbuild/meson/releases/download/1.10.1/meson-1.10.1.tar.gz
MD5=e1c12d275f8aae9fae71dff3d6891746


run_build () {
    pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

run_test () {
    echo -n
}

run_install () {
    pip3 install --no-index --find-links dist meson &&
    install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson &&
    install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson
}

run_all
