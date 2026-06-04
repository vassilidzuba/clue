#!/nothing

source scripts/_utilities_build.sh

SCRIPT=$(basename "$0")
ROOT=$(pwd)
FLAG=$XLFS/flags/stage0/$SCRIPT
TMPDIR=/tmp
SRCDIR=$ROOT/shared
LOGDIR=$XLFS/var/log

STAGE=stage0
