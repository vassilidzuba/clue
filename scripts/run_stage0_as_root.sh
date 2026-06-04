#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

script_dir=buildscripts

start=`date +%s`

$script_dir/P001-create-dirs.sh
$script_dir/P002-add-user.sh

end=`date +%s`
runtime=$((end-start))
echo "Execution time: $runtime"
