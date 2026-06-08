#!/bin/bash

if [ ! -f i_am_at_root ]; then
    script=$(basename "$0")
    echo "The script '$script' must be run at the root of the repo."
    exit 255
fi

source scripts/_utilities.sh
XLFS=

run () {
    if [ -f $XLFS/flags/stage1/$1 ]; then
        echo "Script already executed: $1."
        return
    fi
    if [ "$INCHROOT" = "1" ]; then
        buildscripts/$1 $2 $3 $4 $5 $6 2>&1 | tee /var/log/stage1/$1.log
    else
        XLFS=$(get-value '.xlfs')
        scripts/chroot.sh /mnt/shared/buildscripts/$1 $2 $3 $4 $5 $6 2>&1 | tee $XLFS/var/log/$1.log
    fi
    if [ ! -f $XLFS/flags/stage1/$1 ]; then
        echo "Last command $1 failed, build is interrupted. Sorry."
        exit 255
    fi
}

with-option () {
    if [ "$(get-value .options.with_$1)" == "true" ]; then
        (exit 0)
    else
        (exit 1)
    fi
}

run L701-create-dirs.sh
run L702-create-essential-files.sh
run L703-gettext.sh
run L704-bison.sh
run L705-perl.sh
run L706-python.sh
run L707-texinfo.sh
run L708-util-linux.sh
run L709-cleanup.sh
run L800-man-pages.sh
run L801-iana-etc.sh
run L802-glibc-configure.sh
run L802-glibc.sh --notest
run L803-zlib.sh
run L804-bzip2.sh
run L805-xz.sh
run L806-lz4.sh
run L807-zstd.sh
run L808-file.sh
run L809-readline.sh
run L810-pcre2.sh
run L811-m4.sh
run L812-bc.sh
run L813-flex.sh
run L814-tcl.sh
run L815-expect.sh
run L816-dejagnu.sh
run L817-pkgconf.sh
run L818-binutils.sh
run L819-gmp.sh
run L820-mpfr.sh
run L821-mpc.sh
run L822-attr.sh
run L823-acl.sh
run L824-libcap.sh
run L825-libxcrypt.sh
run L826-shadow.sh
run L827-gcc.sh --notest
run L828-ncurses.sh
run L829-sed.sh
run L830-psmisc.sh
run L831-gettext.sh
run L832-bison.sh
run L833-grep.sh
run L834-bash.sh
run L835-libtool.sh
run L836-gdbm.sh
run L837-gperf.sh
run L838-expat.sh
run L839-inetutils.sh
run L840-less.sh
run L841-perl.sh
run L842-xml-parser.sh
run L843-intltool.sh
run L844-autoconf.sh
run L845-automake.sh
run L846-openssl.sh
run L847-libelf.sh
run L848-libffi.sh
run L849-sqlite.sh
run L850-python.sh
run L851-flit-core.sh
run L852-packaging.sh
run L853-wheel.sh
run L854-setuptools.sh
run L855-ninja.sh
run L856-meson.sh
run L857-kmod.sh
run L858-coreutils.sh
run L859-diffutils.sh
run L860-gawk.sh
run L861-findutils.sh
run L862-groff.sh
run L863-grub.sh
run L864-gzip.sh
run L865-iproute2.sh
run L866-kbd.sh
run L867-libpipeline.sh
run L868-make.sh
run L869-patch.sh
run L870-tar.sh
run L871-texinfo.sh
with-option vim && run L872-vim.sh
run L873-markupsafe.sh
run L874-jinja2.sh
run L877-man-db.sh
run L878-procps-ng.sh
run L879-util-linux.sh
run L880-e2fsprogs.sh
run L881-stripping.sh
run L882-cleanup.sh

run L951-kernel.sh

run L900-network-configuration.sh

with-option systemd && run L875-systemd.sh
with-option systemd && run L876-d-bus.sh
with-option systemd && run L907-configuring-systemd.sh

run B0301-create-user.sh
run B0401-openssh.sh
with-option nano && run B0601-nano.sh
run B0402-sudo.sh

run E016-neofetch.sh
