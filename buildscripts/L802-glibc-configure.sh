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

load_archive https://www.iana.org/time-zones/repository/releases/tzdata2025c.tar.gz \
             MD5 7250c862872c33104b73e7d0bd3cb25f

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    cp /mnt/shared/config/etc/nsswitch.conf /etc
    cp /mnt/shared/config/etc/ld.so.conf /etc

    mkdir -pv /etc/ld.so.conf.d

    pushd /tmp

    tar -xf /sources/tzdata2025c.tar.gz

    ZONEINFO=/usr/share/zoneinfo
    mkdir -pv $ZONEINFO/{posix,right}

    for tz in etcetera southamerica northamerica europe africa antarctica  \
              asia australasia backward; do
        zic -L /dev/null   -d $ZONEINFO       ${tz}
        zic -L /dev/null   -d $ZONEINFO/posix ${tz}
        zic -L leapseconds -d $ZONEINFO/right ${tz}
    done

    cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
    zic -d $ZONEINFO -p Europe/Paris
    unset ZONEINFO tz

    popd
}

run_all
