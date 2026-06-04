#!/bin/bash

if [ ! -f i_am_at_root ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run as user 'root'."
    exit 255
fi


for arg in "$@"; do
    case $arg in
        --dryrun)
            DRYRUN=true
            echo '*** dry run'
            ;;
        *)
            echo "unknown option: $arg"
            terminate
            ;;
    esac
done

source scripts/_utilities.sh

XLFS=$(bin/yq '.xlfs' config.yaml)
echo "This command will remove everything but /sources directory from $XLFS"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 255

exec-command "rm -vrf $XLFS/{bin,etc,flags,lib,lib64,sbin,tools,usr,var}"

echo "### done."
