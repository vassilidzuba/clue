#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

for arg in "$@"; do
    case $arg in
        --dryrun)
            DRYRUN=true
            echo '*** dry run'
            ;;
        --*)
            echo "unknown option: $arg"
            exit 255
            ;;
        *)
            ;;
    esac
done

source scripts/_utilities.sh

if [ "$#" != "1" ]; then
    echo "Usage is : switch.sh <config suffix>"
    echo -n "      available suffixes are:"
    for f in config.yaml-* ; do
        echo -n " $(echo $f | sed s/config.yaml-//)"
    done
    echo
    exit 255
fi

if [ ! -f "config.yaml-$1" ]; then
    echo "Sample default config.yaml-$1 does not exists"
    exit 255
fi

newsuffix=$1
oldsuffix=$(get-value '.suffix')

if [ "$newsuffix" = "$oldsuffix"  ]; then
    echo "no change"
    exit 255
fi

exec-command "cp -v config.yaml config.yaml-$oldsuffix"
exec-command "cp -v config.yaml-$newsuffix config.yaml"
