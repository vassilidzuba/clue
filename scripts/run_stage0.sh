#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_status () {
    if [ "$?" != "0" ]; then
        echo "command '$1' failed, status is $?"
        exit 255
    fi
}

echo "installation root is '$XLFS'"

check_xlfs

echo "Will need to use sudo ?"
confirm
sudo scripts/run_stage0_as_root.sh
check_status "run_stage0_as_root"
echo sudo su xlfs -c scripts/run_stage0_as_xlfs.sh
sudo su xlfs -c "/bin/bash $(pwd)/scripts/run_stage0_as_xlfs.sh"
exit 255
check_status "run_stage0_as_xlfs"
sudo scripts/change_ownership.sh
check_status "change_ownership"
