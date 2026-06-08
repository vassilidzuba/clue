#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities_build.sh

PACKAGE=
SOURCE=
URL=
MD5=

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    if [ ! -d /etc/skel ]; then
        cp -r $ROOT/config/etc/skel /etc
    fi

    user="$(get-value '.config.user')"
    password="$(get-value '.config.password')"

    if ! id -g "$user" > /dev/null 2>&1 ; then
        echo "Creating group $user"
        groupadd "$user"
    fi

    if ! id -u "$user" > /dev/null 2>&1 ; then
        echo "Creating user $user"
        useradd -m -g "$user" "$user"
        echo "$password" | passwd --stdin "$user"
        usermod -aG wheel $user
    fi

    echo "creating user $user with password $password."
    echo "do not forget to change it."
}

run_all
