# this file is expected to be sourced, not runindependently

if [ "$CONFIG" = "" ]; then
    CONFIG=config.yaml
fi

check_is_root () {
    if [ $(whoami) != 'root' ]; then
        script=$(basename "$0")
        echo "The script '$script' must be run as user 'root'."
        exit 255
    fi
}

check_yq_exists () {
    if [ ! -f bin/yq ]; then
        echo "The program 'yq' should be in directory 'bin'"
        exit 255
    fi
}

check_status () {
    if [ $? != 0 ]; then
        echo "script failed: $1"
        terminate
    fi
}

terminate () {
    echo "script interrupted"
    exit 255
}

check_mount () {
    if ! mountpoint -q "$XLFS" ; then
        scripts/mount.sh
    fi
}

check_is_xlfs () {
    if [ "$(whoami)" != "xlfs" ]; then
        script=$(basename "$0")
        echo "The script '$script' should be run as user 'xlfs'"
        terminate
    fi
}

check_not_root () {
    if [ "$(whoami)" = "root" ]; then
        echo "This script should not be run as root"
        terminate
    fi
}

check_xlfs () {
    if [ "$XLFS" = "" ]; then
        echo "The variable XLFS is not defined"
        terminate
    fi
}

confirm () {
    read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 255
}

pushd() {
    command pushd "$@" > /dev/null
}

popd() {
    command popd > /dev/null
}

get-value () {
    local val=$(bin/yq "$1" "$CONFIG")
    if [ "$val" = "null" ]; then
        if [ "$2" == "" ]; then
            echo "Configuration value '$1' is not defined"
            exit 255
        fi
        echo "$2"
    else
        echo "$val"
    fi
}


exec-command () {
    if [ "$DRYRUN" = "true" ]; then
        echo $1
    else
        echo $1
        eval "$1"
        status=$?
        if [ "$status" != 0 ]; then
            echo "command '$1' failed with status $status"
            exit 255
        fi
    fi
}

check_yq_exists

XLFS=$(get-value '.xlfs')
