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
        *)
            BACKUPNAME=$arg
            ;;
    esac
done

source scripts/_utilities.sh

check_yq_exists


backupdir=$(get-value '.backup')
suffix=$(get-value '.suffix')


if [ ! -d "$backupdir" ]; then
    echo "The backup directory '$backupdir' does not exists."
    exit 244
fi


if [ "$BACKUPNAME" = "" ]; then
    echo "Usage is : backup.sh [ --dryrun ] <backup name>"
    echo "The backup file will be $backupdir/xlfs-$suffix-<backup name>.tar.gz"
    exit 255
fi

backupfile="$backupdir/xlfs-$suffix-$BACKUPNAME.tar.gz"

if [ -f $backupfile ]; then
    echo "The backup file $backupfile alreadu exists. It will be overwritten"
    read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 255
fi

XLFS=$(get-value '.xlfs')

if ! mountpoint -q $XLFS ; then
    echo "The installatikon directory '$XLFS' is not mounted"
    exit 255
fi

pushd $XLFS
    tar pcJf $backupfile \
        --exclude lost+found \
        *
popd
