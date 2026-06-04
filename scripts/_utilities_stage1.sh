#!/nothing

# This file is expected to be sources

source scripts/_utilities_build.sh

ROOT=$(pwd)
SCRIPT=$(basename "$0")
TMPDIR=/tmp
SRCDIR=/mnt/shared/shared
FLAG=/flags/stage1/$SCRIPT
LOGDIR=/var/log

PACKAGEDIR=/mnt/shared/packages
[ "$BUILDPACKAGE" = "" ] &&  BUILDPACKAGE=false
[ "$NOTEST" = "" ] &&  NOTEST=false
[ "$NOINSTALL" = "" ] && NOINSTALL=false
[ "$INSTALLBINARY" = "" ] && INSTALLBINARY=false
[ "$GENERATEBINARY" = "" ] && GENERATEBINARY=false

ADDITIONALARCHIVE=
ADDITIONALPATCH=

STAGE=stage1

echo "Start build of $SCRIPT"

check_flag
