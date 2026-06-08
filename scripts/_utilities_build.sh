#!/bin/bash

source scripts/_utilities.sh

for arg in "$@"; do
    case $arg in
        --force)
            FORCE=true
            ;;
        --buildpackage)
            BUILDPACKAGE=true
            ;;
        --notest)
            NOTEST=true
            ;;
        --noinstall)
            NOINSTALL=true
            ;;
        --installbinary)
            INSTALLBINARY=true
            ;;
        --generatebinary)
            GENERATEBINARY=true
            ;;
        *)
            echo "unknown option: $arg"
            terminate
            ;;
    esac
done


check_flag ()  {
    if [ "$FORCE" != "true" ]; then
        if [ -f "$FLAG" ]; then
            echo "Package '$SCRIPT' has already been built"
            exit 0
        fi
    fi
}



readonly URI_REGEX='^(([^:/?#]+):)?(//((([^:/?#]+)@)?([^:/?#]+)(:([0-9]+))?))?(/([^?#]*))(\?([^#]*))?(#(.*))?'

parse_rpath () {
    [[ "$@" =~ $URI_REGEX ]] && echo "${BASH_REMATCH[11]}"
}

load_archive () {
    local url=$1
    local sumtype=$2
    local sum=$3

    echo "copying archive $1"
    pushd $SRCDIR
    local path=$(parse_rpath "$1")
    local name=$(basename $path)
    if  [ ! -f "$name" ]; then
        exit "File '$name' is not available in /mnt/shared/shared"
    fi
    verify_checksum "$name" "$subtype" "$sum"
    popd

    echo "copy $name to $TMPDIR"
    cp "shared/$name" "$TMPDIR"
}

load_patch () {
    echo "copying patch $1"
    local path=$(parse_rpath "$1")
    local name=$(basename $path)
    pushd $SRCDIR
        if  [ ! -f "$name" ]; then
            echo "File '$name' does not exist"
        else
            cp "$name" "$TMPDIR"
            fi
            ADDITIONALPATCH="$name"
    popd
}

# The function verify_checksum verifies the checksum (either md5 or sha256)
# of a file
verify_checksum () {
    local file=$1
    local sumtype=$2
    local sum=$3
    if [ "$sumtype" = "MD5" -a "$sum" != "" ]; then
        pushd "$SRCDIR"
            if [ "$(md5sum $SOURCE)" != "$sum  $file" ]; then
                echo "BAD MD5 CHECKSUM : $file"
                exit 255
            fi
        popd
    fi
    if [ "$sumtype" = "SHA256" -a "$sum" != "" ]; then
        pushd "$SRCDIR"
            if [ "$(sha256sum $file)" != "$sum  $file" ]; then
                echo "BAD SHA256 CHECKSUM : $file"
                exit 255
            fi
        popd
    fi
}

# check_archive verify that the archive excists,
# and verifies the checksums
check_archive () {
    if [ "$SOURCE" != "" ]; then
        if [ ! -f "$SRCDIR/$SOURCE"  ]; then
            echo "File '$SOURCE' is not available"
            terminate
        fi
        verify_checksum "$SOURCE" "MD5" "$MD5"
        verify_checksum "$SOURCE" "SHA256" "$SHA256"
    fi
}

# the function extract_archive extracts the archive
# in the temporary directory, and cd in the extractyed directory
extract_archive () {
    if [ "$PACKAGE" != "" ]; then
        pushd $TMPDIR

        if [ -d $PACKAGE ]; then
            rm -rf $PACKAGE
        fi

        echo "extracting archive $SOURCE"
        tar xf $SRCDIR/$SOURCE
        if [ $? -eq 1 ]; then
            echo "unable to extract archive $SRCDIR/$SOURCE"
            terminate
        fi

        popd
    fi
}


run_prolog () {
    check_flag
    check_archive
    extract_archive
}

remove () {
    if [ "$1" != "" ]; then
        pushd "$TMPDIR"
            rm -rf "$1"
        popd
    fi
}

run_cleanup () {
    [ "$NOINSTALL" = "true" ] || touch $FLAG
    remove "$PACKAGE"
    remove "$ADDITIONALARCHIVE"
    remove "$ADDITIONALPATCH"
    echo "$SCRIPT : ok "
}


run_buildpackage() {
    echo building package of $PACKAGE
    rm -rf $TMPDIR/_$PACKAGE/XLFS
    mkdir -pv $TMPDIR/_$PACKAGE/XLFS
    DISTDIR=$TMPDIR/_$PACKAGE/XLFS
    run_install
    pushd $TMPDIR/_$PACKAGE
    echo "---" > meta.yaml
    YQ=$ROOT/bin/yq
    $YQ -i '.format = "XLFS"' meta.yaml
    $YQ -i '.version = "0.1"' meta.yaml
    $YQ -o json meta.yaml > meta.json
    rm meta.yaml
    tar cvJf $PACKAGEDIR/$PACKAGE.tar.xz .
    popd
    rm -rf $TMPDIR/_$PACKAGE
    echo "Binary package $PACKAGEDIR/_$PACKAGE.tar.xz created"
}


run_all () {
    start=`date +%s`

    local bn=$(basename "$0")
    echo "Starting $bn..."

    run_prolog

    if [ "$PACKAGE" != "" ]; then
        pushd "$TMPDIR/$PACKAGE"
    fi

    PKG="_unnamed_"
    [ "$PACKAGE" != "" ] && PKG=$PACKAGE

        if [ "$INSTALLBINARY" != "true" ]; then
            run_build
            check_status "Build of $PKG failed"
        else
            echo "Installing binary; build and test are skipped"
        fi

        if [ "$NOTEST" != "true" ]; then
            [ "$INSTALLBINARY" = "true" ] || run_test
            check_status "Test of $PKG failed"
        fi

        if [ "$NOINSTALL" != "true" ]; then
            if [ "$INSTALLBINARY" = "true"  ]; then
                local archive="$ROOT/packages/$PACKAGE.tar.xz"
                if [ -f "$archive" ]; then
                    echo "Loading from built package $archive"
                    rm -rf "$TMPDIR/_$PACKAGE"
                    mkdir "$TMPDIR/_$PACKAGE"
                    pushd "$TMPDIR/_$PACKAGE"
                        tar xf "$archive" .
                        check_status "tar failed"
                        cd XLFS
                        cp -rv * /
                    popd
                    echo "binary package installed: $archive"
                else
                    echo "Binary package not available: $archive"
                    terminate
                fi
            else
                if [ "$GENERATEBINARY" = "true" ]; then
                    if [ "$SUPPORTBINARY" = "true" ]; then
                        run_buildpackage
                    else
                        echo "Generate binary package asked but not supported: $SCRIPT"
                        terminate
                    fi
                else
                    DESTDIR=
                    run_install
                    check_status "Install of $PACKAGE failed"
                fi
            fi
        fi

    if [ "$PACKAGE" != "" ]; then
        popd
    fi

    run_cleanup

    end=`date +%s`
    runtime=$((end-start))
    touch $LOGDIR/$STAGE/stage0.log
    echo "$(date '+%F %T') $SCRIPT ${runtime}s" >> $LOGDIR/stage0/stage0.log
}


depends-on () {
    local flag1="/flags/stage1/$1.sh"
    local flag2="/flags/stage2/$1.sh"

    if [ ! -f "$flag1" -a ! -f "$flag2" ]; then
        echo "Missing dependency: $1"
        terminate
    fi

    echo "Dependency on $1: ok";
}


if [ "$INCHROOT" == "1" ]; then
    # stage 1

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

    sudo=

    echo "Start build of $SCRIPT"

    check_flag
fi
