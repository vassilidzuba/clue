#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source ~/.bashrc

script_dir=buildscripts

XLFS=$(bin/yq '.xlfs' config.yaml)
ARGS=$*


run () {
    $script_dir/$1 $ARGS 2>&1 | tee $XLFS/var/log/stage0/$1.log
    if [ ! -f $XLFS/flags/stage0/$1 ]; then
        echo "Last command failed, build is interrupted. Sorry."
        exit 255
    fi
}

start=`date +%s`

run P500-binutils-pass1.sh
run P501-gcc-pass1.sh
run P502-api-headers.sh
run P503-glibc.sh
run P504-libstdcpp.sh
run P600-m4.sh
run P601-ncurses.sh
run P602-bash.sh
run P603-coreutils.sh
run P604-diffutils.sh
run P605-file.sh
run P606-findutils.sh
run P607-gawk.sh
run P608-grep.sh
run P609-gzip.sh
run P610-make.sh
run P611-patch.sh
run P612-sed.sh
run P613-tar.sh
run P614-xz.sh
run P615-binutils-pass2.sh
run P616-gcc-pass2.sh


end=`date +%s`
runtime=$((end-start))
echo "Execution time: $runtime"

echo "Build successfully performed. Rejoice !"
