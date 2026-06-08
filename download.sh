#/bin/bash

download() {
    if [ ! -f "shared/$SRC" ]; then
        echo "Downloading $URL"
        pushd shared
        wget -O "$SRC" "$URL"
        if [ $? != 0 ]; then
            echo "Unable to download $URL"
        else
            if [ "$MD5" != "" ]; then
                if [ "$(md5sum $SRC)" != "$MD5  $SRC" ]; then
                    echo "BAD MD5 CHECKSUM : $SRC"
                fi
            fi
            if [ "$SHA256" != "" ]; then
                if [ "$(sha256sum $SRC)" != "$SHA256  $SRC" ]; then
                    echo "BAD SHA256 CHECKSUM : $SRC"
                fi
            fi
        fi
        popd
    fi

    SOURCE=
    URL=
    MD5=
    SHA256=
    VERSION=
}

# buildscripts/B003-cpio.sh
URL=https://ftpmirror.gnu.org/cpio/cpio-2.15.tar.bz2
SRC=cpio-2.15.tar.bz2
MD5=3394d444ca1905ea56c94b628b706a0b
download

# buildscripts/B004-icu.sh
URL=https://github.com/unicode-org/icu/releases/download/release-78.2/icu4c-78.2-sources.tgz
SRC=icu4c-78.2-sources.tgz
download

# buildscripts/B005-libxml2.sh
URL=https://download.gnome.org/sources/libxml2/2.15/libxml2-2.15.1.tar.xz
SRC=libxml2-2.15.1.tar.xz
MD5=fcf38f534bb8996984dba978ee3e27f4
download

# buildscripts/B006-libxslt.sh
URL=https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.45.tar.xz
SRC=libxslt-1.1.45.tar.xz
MD5=84bb3f6ba7f5ee98af5dcd72e828c73e
download

# buildscripts/B007-wget.sh
URL=https://ftpmirror.gnu.org/wget/wget-1.25.0.tar.gz
SRC=wget-1.25.0.tar.gz
MD5=c70ba58b36f944e8ba1d655ace552881
download

# buildscripts/B009-lzo.sh
URL=https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz
SRC=lzo-2.10.tar.gz
MD5=39d3f3f9c55c87b1e5d6888e1420f4b5
download

# buildscripts/B010-btrfs-progs.sh
URL=https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/btrfs-progs-v6.17.1.tar.xz
SRC=btrfs-progs-v6.17.1.tar.xz
MD5=c52275337b5682c24ed0ccf5cc8a7b9a
download

# buildscripts/B011-json-c.sh
URL=https://s3.amazonaws.com/json-c_releases/releases/json-c-0.18.tar.gz
SRC=json-c-0.18.tar.gz
MD5=e6593766de7d8aa6e3a7e67ebf1e522f
download

# buildscripts/B012-cmake.sh
URL=https://cmake.org/files/v4.2/cmake-4.2.3.tar.gz
SRC=cmake-4.2.3.tar.gz
MD5=803a1720ec822a8660118a38ca51fc1b
download

# buildscripts/B013-curl.sh
URL=https://curl.se/download/curl-8.18.0.tar.xz
SRC=curl-8.18.0.tar.xz
MD5=dae6088bf7af69d3b0a87c762de92248
download

# buildscripts/B014-libpsl.sh
URL=https://github.com/rockdaboot/libpsl/releases/download/0.21.5/libpsl-0.21.5.tar.gz
SRC=libpsl-0.21.5.tar.gz
MD5=870a798ee9860b6e77896548428dba7b
download

# buildscripts/B015-libunistring.sh
URL=https://ftpmirror.gnu.org/libunistring/libunistring-1.4.1.tar.xz
SRC=libunistring-1.4.1.tar.xz
MD5=7419fcbca7c0b29d3b218a09a15cbc76
download

# buildscripts/B016-libidn2.sh
URL=https://ftpmirror.gnu.org/libidn/libidn2-2.3.8.tar.gz
SRC=libidn2-2.3.8.tar.gz
MD5=a8e113e040d57a523684e141970eea7a
download

# buildscripts/B017-libtasn1.sh
URL=https://ftpmirror.gnu.org/libtasn1/libtasn1-4.21.0.tar.gz
SRC=libtasn1-4.21.0.tar.gz
MD5=2ee1d9f3aa66f1e308c46a283aa9a8c2
download

# buildscripts/B018-nettle.sh
URL=ttps://ftpmirror.gnu.org/nettle/nettle-3.10.2.tar.gz
SRC=nettle-3.10.2.tar.gz
MD5=b28bcbf6f045ff007940a9401673600d
download

# buildscripts/B019-libarchive.sh
URL=https://github.com/libarchive/libarchive/releases/download/v3.8.5/libarchive-3.8.5.tar.xz
SRC=libarchive-3.8.5.tar.xz
MD5=2cd5a73ed7fe7f9da22d34ac1048534e
download

# buildscripts/B020-libuv.sh
URL=https://dist.libuv.org/dist/v1.52.0/libuv-v1.52.0.tar.gz
SRC=libuv-v1.52.0.tar.gz
MD5=fc5065a74649e94ea84a06beb8a7e42f
download

# buildscripts/B021-nghttp2.sh
URL=https://github.com/nghttp2/nghttp2/releases/download/v1.69.0/nghttp2-1.69.0.tar.xz
SRC=nghttp2-1.69.0.tar.xz
MD5=7015bee1f5a24012b848a98bfe4864b1
download

# buildscripts/B022-cryptsetup.sh
URL=https://www.kernel.org/pub/linux/utils/cryptsetup/v2.8/cryptsetup-2.8.4.tar.xz
SRC=cryptsetup-2.8.4.tar.xz
MD5=f157bc9287e422b0ec036e11d14611eb
download

# buildscripts/B023-popt.sh
URL=https://ftp.osuosl.org/pub/rpm/popt/releases/popt-1.x/popt-1.19.tar.gz
SRC=popt-1.19.tar.gz
MD5=eaa2135fddb6eb03f2c87ee1823e5a78
download

# buildscripts/B024-libaio.sh
URL=https://pagure.io/libaio/archive/libaio-0.3.113/libaio-0.3.113.tar.gz
SRC=libaio-0.3.113.tar.gz
MD5=605237f35de238dfacc83bcae406d95d
download

# buildscripts/B025-lvm2.sh
URL=https://sourceware.org/ftp/lvm2/LVM2.2.03.38.tgz
SRC=LVM2.2.03.38.tgz
MD5=a661c55b5a1fcaa068b9e4a561c35f36
download

# buildscripts/B026-libssh2.sh
URL=https://www.libssh2.org/download/libssh2-1.11.1.tar.gz
SRC=libssh2-1.11.1.tar.gz
MD5=38857d10b5c5deb198d6989dacace2e6
download

# buildscripts/B0301-create-user.sh
# buildscripts/B0401-openssh.sh
URL=https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.2p1.tar.gz
SRC=openssh-10.2p1.tar.gz
MD5=801b5ad6da38e0045de20dd5dd2f6a80
download

# archive https://www.linuxfromscratch.org/blfs/downloads/systemd/blfs-systemd-units-20251204.tar.xz
URL=https://www.linuxfromscratch.org/blfs/downloads/systemd/blfs-systemd-units-20251204.tar.xz
SRC=blfs-systemd-units-20251204.tar.xz
download

# buildscripts/B0402-sudo.sh
URL=https://www.sudo.ws/dist/sudo-1.9.17p2.tar.gz
SRC=sudo-1.9.17p2.tar.gz
MD5=dcbf46f739ae06b076e1a11cbb271a10
download

# buildscripts/B0601-nano.sh
URL=https://www.nano-editor.org/dist/v8/nano-8.7.1.tar.xz
SRC=nano-8.7.1.tar.xz
MD5=d873085c342e3670d108c08a0c3ebe2f
download

# buildscripts/E001-skalibs.sh
URL=https://skarnet.org/software/skalibs/skalibs-2.15.0.0.tar.gz
SRC=skalibs-2.15.0.0.tar.gz
SHA256=7fde96e8afb4191593a15328883e9c7726c96891cf071222146821e8c87f8007
download

# buildscripts/E002-exeline.sh
URL=https://skarnet.org/software/execline/execline-2.9.9.1.tar.gz
SRC=execline-2.9.9.1.tar.gz
SHA256=be63533297a93c36fd267195117b4e668687a526f834517a8db47d85b6c7ec6a
download

# buildscripts/E003-s6.sh
URL=https://skarnet.org/software/s6/s6-2.15.0.0.tar.gz
SRC=s6-2.15.0.0.tar.gz
SHA256=27dff73d626285540133e075e75887087f5117fd51de59503ef7d29e96f69e4c
download

# buildscripts/E004-s6-rc.sh
URL=https://skarnet.org/software/s6-rc/s6-rc-0.6.1.1.tar.gz
SRC=s6-rc-0.6.1.1.tar.gz
SHA256=b54f226a35be1ee56a228bf1a4c39437f072bc64e69dbf356e733e606a86402d
download

# buildscripts/E006-s6-portable-utils.sh
URL=https://skarnet.org/software/s6-portable-utils/s6-portable-utils-2.3.1.2.tar.gz
SRC=s6-portable-utils-2.3.1.2.tar.gz
SHA256=cfb90186d0c0eb204e1e5c6f9379e99413c546bccf38bb6e76177f82371aa3aa
download

# buildscripts/E007-s6-linux-init.sh
URL=https://skarnet.org/software/s6-linux-init/s6-linux-init-1.2.0.1.tar.gz
SRC=s6-linux-init-1.2.0.1.tar.gz
SHA256=72d59b13683d1390f7df9a286be467e73293416021af9fa1023c9293ec5c7d7c
download

# buildscripts/E008-dracut-install.sh
URL=https://github.com/dracut-ng/dracut/archive/refs/tags/111.tar.gz
SRC=dracut-111.tar.gz
download

# buildscripts/E009-dracut-run.sh
URL=https://github.com/dracut-ng/dracut/archive/refs/tags/111.tar.gz
SRC=dracut-111.tar.gz
download

# buildscripts/E010-eudev.sh
URL=https://github.com/eudev-project/eudev/archive/refs/tags/v3.2.14.tar.gz
SRC=eudev-3.2.14.tar.gz
download

# buildscripts/E011-simple-init.sh
# buildscripts/E012-dnsmasq.sh
URL=https://thekelleys.org.uk/dnsmasq/dnsmasq-2.92rel2.tar.xz
SRC=dnsmasq-2.92rel2.tar.xz
download

# buildscripts/E013-simple-ca.sh
# archive https://curl.se/ca/cacert.pem
URL=https://curl.se/ca/cacert.pem
SRC=cacert.pem
download

# buildscripts/E014-util-linux.sh
URL=https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.3.tar.xz
SRC=util-linux-2.41.3.tar.xz
MD5=d2faa85303dea29e7f6ee40a9465e528
download

# buildscripts/E015-sysklogd.sh
URL=https://github.com/troglobit/sysklogd/releases/download/v2.7.2/sysklogd-2.7.2.tar.gz
SRC=sysklogd-2.7.2.tar.gz
download

# buildscripts/E016-neofetch.sh
# buildscripts/L701-create-dirs.sh
# buildscripts/L702-create-essential-files.sh
# buildscripts/L703-gettext.sh
URL=https://ftpmirror.gnu.org/gettext/gettext-1.0.tar.xz
SRC=gettext-1.0.tar.xz
MD5=dc8b2911535929cec1e263706b0a13a1
download

# buildscripts/L704-bison.sh
URL=https://ftpmirror.gnu.org/bison/bison-3.8.2.tar.xz
SRC=bison-3.8.2.tar.xz
MD5=c28f119f405a2304ff0a7ccdcc629713
download

# buildscripts/L705-perl.sh
URL=https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz
SRC=perl-5.42.0.tar.xz
MD5=7a6950a9f12d01eb96a9d2ed2f4e0072
download

# buildscripts/L706-python.sh
URL=https://www.python.org/ftp/python/3.14.3/Python-3.14.3.tar.xz
SRC=Python-3.14.3.tar.xz
MD5=ef513dcb836d219ae0e2b16ac9c87d0f
download

# buildscripts/L707-texinfo.sh
URL=https://ftpmirror.gnu.org/texinfo/texinfo-7.2.tar.xz
SRC=texinfo-7.2.tar.xz
MD5=11939a7624572814912a18e76c8d8972
download

# buildscripts/L708-util-linux.sh
URL=https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.3.tar.xz
SRC=util-linux-2.41.3.tar.xz
MD5=d2faa85303dea29e7f6ee40a9465e528
download

# buildscripts/L709-cleanup.sh
# buildscripts/L800-man-pages.sh
URL=https://www.kernel.org/pub/linux/docs/man-pages/man-pages-6.17.tar.xz
SRC=man-pages-6.17.tar.xz
MD5=4327b009d63a6e0fc27df3e4c9e7369b
download

# buildscripts/L801-iana-etc.sh
URL=https://github.com/Mic92/iana-etc/releases/download/20260202/iana-etc-20260202.tar.gz
SRC=iana-etc-20260202.tar.gz
MD5=fe91258a0760912f61f1d6b200a1d885
download

# buildscripts/L802-glibc-configure.sh
# archive https://www.iana.org/time-zones/repository/releases/tzdata2025c.tar.gz
URL=https://www.iana.org/time-zones/repository/releases/tzdata2025c.tar.gz
SRC=tzdata2025c.tar.gz
download

# buildscripts/L802-glibc.sh
URL=https://ftpmirror.gnu.org/glibc/glibc-2.43.tar.xz
SRC=glibc-2.43.tar.xz
MD5=7ec2588300b299215a65aec7e6afa04f
download

# buildscripts/L803-zlib.sh
URL=https://zlib.net/fossils/zlib-1.3.2.tar.gz
SRC=zlib-1.3.2.tar.gz
MD5=a1e6c958597af3c67d162995a342138a
download

# buildscripts/L804-bzip2.sh
URL=https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
SRC=bzip2-1.0.8.tar.gz
MD5=67e051268d0c475ea773822f7500d0e5
download

# buildscripts/L805-xz.sh
URL=https://github.com//tukaani-project/xz/releases/download/v5.8.2/xz-5.8.2.tar.xz
SRC=xz-5.8.2.tar.xz
MD5=87c8bb8addf7189d3a51f6a5f03163fc
download

# buildscripts/L806-lz4.sh
URL=https://github.com/lz4/lz4/releases/download/v1.10.0/lz4-1.10.0.tar.gz
SRC=lz4-1.10.0.tar.gz
MD5=dead9f5f1966d9ae56e1e32761e4e675
download

# buildscripts/L807-zstd.sh
URL=https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz
SRC=zstd-1.5.7.tar.gz
MD5=780fc1896922b1bc52a4e90980cdda48
download

# buildscripts/L808-file.sh
URL=https://astron.com/pub/file/file-5.46.tar.gz
SRC=file-5.46.tar.gz
MD5=459da2d4b534801e2e2861611d823864
download

# buildscripts/L809-readline.sh
URL=https://ftpmirror.gnu.org/readline/readline-8.3.tar.gz
SRC=readline-8.3.tar.gz
MD5=25a73bfb2a3ad7146c5e9d4408d9f6cd
download

# buildscripts/L810-pcre2.sh
URL=https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.47/pcre2-10.47.tar.bz2
SRC=pcre2-10.47.tar.bz2
MD5=aded5840ab5a7d772dd4e16fc294b665
download

# buildscripts/L811-m4.sh
URL=https://ftpmirror.gnu.org/m4/m4-1.4.21.tar.xz
SRC=m4-1.4.21.tar.xz
MD5=8051eef7239b2f187791f2ab0034d6b7
download

# buildscripts/L812-bc.sh
URL=https://github.com/gavinhoward/bc/releases/download/7.0.3/bc-7.0.3.tar.xz
SRC=bc-7.0.3.tar.xz
MD5=ad4db5a0eb4fdbb3f6813be4b6b3da74
download

# buildscripts/L813-flex.sh
URL=https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz
SRC=flex-2.6.4.tar.gz
MD5=2882e3179748cc9f9c23ec593d6adc8d
download

# buildscripts/L814-tcl.sh
URL=https://downloads.sourceforge.net/tcl/tcl8.6.17-src.tar.gz
SRC=tcl8.6.17-src.tar.gz
MD5=1ec3444533f54d0f86cd120058e15e48
download

# archive https://downloads.sourceforge.net/tcl/tcl8.6.17-html.tar.gz
URL=https://downloads.sourceforge.net/tcl/tcl8.6.17-html.tar.gz
SRC=tcl8.6.17-html.tar.gz
download

# buildscripts/L815-expect.sh
URL=https://prdownloads.sourceforge.net/expect/expect5.45.4.tar.gz
SRC=expect5.45.4.tar.gz
MD5=00fce8de158422f5ccd2666512329bd2
download

# buildscripts/L816-dejagnu.sh
URL=https://ftpmirror.gnu.org/dejagnu/dejagnu-1.6.3.tar.gz
SRC=dejagnu-1.6.3.tar.gz
MD5=68c5208c58236eba447d7d6d1326b821
download

# buildscripts/L817-pkgconf.sh
URL=https://distfiles.ariadne.space/pkgconf/pkgconf-2.5.1.tar.xz
SRC=pkgconf-2.5.1.tar.xz
MD5=3291128c917fdb8fccd8c9e7784b643b
download

# buildscripts/L818-binutils.sh
URL=https://sourceware.org/pub/binutils/releases/binutils-2.46.0.tar.xz
SRC=binutils-2.46.0.tar.xz
MD5=81bb6810bcd1119819dc0804956e1c92
download

# buildscripts/L819-gmp.sh
URL=https://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz
SRC=gmp-6.3.0.tar.xz
MD5=956dc04e864001a9c22429f761f2c283
download

# buildscripts/L820-mpfr.sh
URL=https://ftpmirror.gnu.org/mpfr/mpfr-4.2.2.tar.xz
SRC=mpfr-4.2.2.tar.xz
MD5=7c32c39b8b6e3ae85f25156228156061
download

# buildscripts/L821-mpc.sh
URL=https://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz
SRC=mpc-1.3.1.tar.gz
MD5=5c9bc658c9fd0f940e8e3e0f09530c62
download

# buildscripts/L822-attr.sh
URL=https://download.savannah.gnu.org/releases/attr/attr-2.5.2.tar.gz
SRC=attr-2.5.2.tar.gz
MD5=227043ec2f6ca03c0948df5517f9c927
download

# buildscripts/L823-acl.sh
URL=https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.xz
SRC=acl-2.3.2.tar.xz
MD5=590765dee95907dbc3c856f7255bd669
download

# buildscripts/L824-libcap.sh
URL=https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.77.tar.xz
SRC=libcap-2.77.tar.xz
MD5=58048c92f90ef8513c17fb9c24c2c1bd
download

# buildscripts/L825-libxcrypt.sh
URL=https://github.com/besser82/libxcrypt/releases/download/v4.5.2/libxcrypt-4.5.2.tar.xz
SRC=libxcrypt-4.5.2.tar.xz
MD5=25e888919ddcd153a07daa95224fa436
download

# buildscripts/L826-shadow.sh
URL=https://github.com/shadow-maint/shadow/releases/download/4.19.3/shadow-4.19.3.tar.xz
SRC=shadow-4.19.3.tar.xz
MD5=c56d98c09e5dbae816250ba5c2285a37
download

# buildscripts/L827-gcc.sh
URL=https://ftpmirror.gnu.org/gcc/gcc-16.1.0/gcc-16.1.0.tar.xz
SRC=gcc-16.1.0.tar.xz
download

# archive https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.24.tar.bz2
URL=https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.24.tar.bz2
SRC=isl-0.24.tar.bz2
download

# buildscripts/L828-ncurses.sh
URL=https://invisible-mirror.net/archives/ncurses/ncurses-6.6.tar.gz
SRC=ncurses-6.6.tar.gz
MD5=dd45bf6854430af403452a7a6a40652c
download

# buildscripts/L829-sed.sh
URL=https://ftpmirror.gnu.org/sed/sed-4.9.tar.xz
SRC=sed-4.9.tar.xz
MD5=6aac9b2dbafcd5b7a67a8a9bcb8036c3
download

# buildscripts/L830-psmisc.sh
URL=https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.7.tar.xz
SRC=psmisc-23.7.tar.xz
MD5=53eae841735189a896d614cba440eb10
download

# buildscripts/L831-gettext.sh
URL=https://ftpmirror.gnu.org/gettext/gettext-1.0.tar.xz
SRC=gettext-1.0.tar.xz
MD5=dc8b2911535929cec1e263706b0a13a1
download

# buildscripts/L832-bison.sh
URL=https://ftpmirror.gnu.org/bison/bison-3.8.2.tar.xz
SRC=bison-3.8.2.tar.xz
MD5=c28f119f405a2304ff0a7ccdcc629713
download

# buildscripts/L833-grep.sh
URL=https://ftpmirror.gnu.org/grep/grep-3.12.tar.xz
SRC=grep-3.12.tar.xz
MD5=5d9301ed9d209c4a88c8d3a6fd08b9ac
download

# buildscripts/L834-bash.sh
URL=https://ftpmirror.gnu.org/bash/bash-5.3.tar.gz
SRC=bash-5.3.tar.gz
MD5=977c8c0c5ae6309191e7768e28ebc951
download

# buildscripts/L835-libtool.sh
URL=https://ftpmirror.gnu.org/libtool/libtool-2.5.4.tar.xz
SRC=libtool-2.5.4.tar.xz
MD5=22e0a29df8af5fdde276ea3a7d351d30
download

# buildscripts/L836-gdbm.sh
URL=https://ftpmirror.gnu.org/gdbm/gdbm-1.26.tar.gz
SRC=gdbm-1.26.tar.gz
MD5=aaa600665bc89e2febb3c7bd90679115
download

# buildscripts/L837-gperf.sh
URL=https://ftpmirror.gnu.org/gperf/gperf-3.3.tar.gz
SRC=gperf-3.3.tar.gz
MD5=31753b021ea78a21f154bf9eecb8b079
download

# buildscripts/L838-expat.sh
URL=https://github.com/libexpat/libexpat/releases/download/R_2_7_4/expat-2.7.4.tar.xz
SRC=expat-2.7.4.tar.xz
MD5=5d3d1e1c829f8fb6f42b8e3e2371afa3
download

# buildscripts/L839-inetutils.sh
URL=https://ftpmirror.gnu.org/inetutils/inetutils-2.8.tar.gz
SRC=inetutils-2.8.tar.gz
download

# buildscripts/L840-less.sh
URL=https://www.greenwoodsoftware.com/less/less-692.tar.gz
SRC=less-692.tar.gz
MD5=4efd31e34ecf7682a6c62a3c53007600
download

# buildscripts/L841-perl.sh
URL=https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz
SRC=perl-5.42.0.tar.xz
MD5=7a6950a9f12d01eb96a9d2ed2f4e0072
download

# buildscripts/L842-xml-parser.sh
URL=https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz
SRC=XML-Parser-2.47.tar.gz
MD5=89a8e82cfd2ad948b349c0a69c494463
download

# buildscripts/L843-intltool.sh
URL=https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz
SRC=intltool-0.51.0.tar.gz
MD5=12e517cac2b57a0121cda351570f1e63
download

# buildscripts/L844-autoconf.sh
URL=https://ftpmirror.gnu.org/autoconf/autoconf-2.72.tar.xz
SRC=autoconf-2.72.tar.xz
MD5=1be79f7106ab6767f18391c5e22be701
download

# buildscripts/L845-automake.sh
URL=https://ftpmirror.gnu.org/automake/automake-1.18.1.tar.xz
SRC=automake-1.18.1.tar.xz
MD5=cea31dbf1120f890cbf2a3032cfb9a68
download

# buildscripts/L846-openssl.sh
URL=https://github.com/openssl/openssl/releases/download/openssl-3.6.1/openssl-3.6.1.tar.gz
SRC=openssl-3.6.1.tar.gz
MD5=589777dc85ebbfeca70161c0c384d572
download

# buildscripts/L847-libelf.sh
URL=https://sourceware.org/ftp/elfutils/0.194/elfutils-0.194.tar.bz2
SRC=elfutils-0.194.tar.bz2
MD5=1137792ea10e9194637d7344439a5955
download

# buildscripts/L848-libffi.sh
URL=https://github.com/libffi/libffi/releases/download/v3.5.2/libffi-3.5.2.tar.gz
SRC=libffi-3.5.2.tar.gz
MD5=92af9efad4ba398995abf44835c5d9e9
download

# buildscripts/L849-sqlite.sh
URL=https://sqlite.org/2026/sqlite-autoconf-3510200.tar.gz
SRC=sqlite-autoconf-3510200.tar.gz
MD5=49600a5739d382c648b1a317e4b57446
download

# archive https://anduin.linuxfromscratch.org/LFS/sqlite-doc-3510200.tar.xz
URL=https://anduin.linuxfromscratch.org/LFS/sqlite-doc-3510200.tar.xz
SRC=sqlite-doc-3510200.tar.xz
download

# buildscripts/L850-python.sh
URL=https://www.python.org/ftp/python/3.14.3/Python-3.14.3.tar.xz
SRC=Python-3.14.3.tar.xz
MD5=ef513dcb836d219ae0e2b16ac9c87d0f
download

# archive https://www.python.org/ftp/python/doc/3.14.3/python-3.14.3-docs-html.tar.bz2
URL=https://www.python.org/ftp/python/doc/3.14.3/python-3.14.3-docs-html.tar.bz2
SRC=python-3.14.3-docs-html.tar.bz2
download

# buildscripts/L851-flit-core.sh
URL=https://pypi.org/packages/source/f/flit-core/flit_core-3.12.0.tar.gz
SRC=flit_core-3.12.0.tar.gz
MD5=c538415c1f27bd69cbbbf3cdd5135d39
download

# buildscripts/L852-packaging.sh
URL=https://files.pythonhosted.org/packages/source/p/packaging/packaging-26.0.tar.gz
SRC=packaging-26.0.tar.gz
MD5=2cbdbb5754f038736c3c361826c6872a
download

# buildscripts/L853-wheel.sh
URL=https://pypi.org/packages/source/w/wheel/wheel-0.46.3.tar.gz
SRC=wheel-0.46.3.tar.gz
MD5=61fb0c9633fe7492933a8f338db23508
download

# buildscripts/L854-setuptools.sh
URL=https://pypi.org/packages/source/s/setuptools/setuptools-82.0.0.tar.gz
SRC=setuptools-82.0.0.tar.gz
MD5=6e65b88d2466b35e86e5187b99502b1c
download

# buildscripts/L855-ninja.sh
URL=https://github.com/ninja-build/ninja/archive/v1.13.2/ninja-1.13.2.tar.gz
SRC=ninja-1.13.2.tar.gz
MD5=76c00637fde44909cd7d56f8d73f2042
download

# buildscripts/L856-meson.sh
URL=https://github.com/mesonbuild/meson/releases/download/1.10.1/meson-1.10.1.tar.gz
SRC=meson-1.10.1.tar.gz
MD5=e1c12d275f8aae9fae71dff3d6891746
download

# buildscripts/L857-kmod.sh
URL=https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.2.tar.xz
SRC=kmod-34.2.tar.xz
MD5=36f2cc483745e81ede3406fa55e1065a
download

# buildscripts/L858-coreutils.sh
URL=https://ftpmirror.gnu.org/coreutils/coreutils-9.11.tar.xz
SRC=coreutils-9.11.tar.xz
MD5=e52e9857e4aa9ae38ef32f8ed6a27604
download

# buildscripts/L859-diffutils.sh
URL=https://ftpmirror.gnu.org/diffutils/diffutils-3.12.tar.xz
SRC=diffutils-3.12.tar.xz
MD5=d1b18b20868fb561f77861cd90b05de4
download

# buildscripts/L860-gawk.sh
URL=https://ftpmirror.gnu.org/gawk/gawk-5.3.2.tar.xz
SRC=gawk-5.3.2.tar.xz
MD5=b7014650c5f45e5d4837c31209dc0037
download

# buildscripts/L861-findutils.sh
URL=https://ftpmirror.gnu.org/findutils/findutils-4.10.0.tar.xz
SRC=findutils-4.10.0.tar.xz
MD5=870cfd71c07d37ebe56f9f4aaf4ad872
download

# buildscripts/L862-groff.sh
URL=https://ftpmirror.gnu.org/groff/groff-1.23.0.tar.gz
SRC=groff-1.23.0.tar.gz
MD5=5e4f40315a22bb8a158748e7d5094c7d
download

# buildscripts/L863-grub.sh
URL=https://ftpmirror.gnu.org/gzip/gzip-1.14.tar.xz
SRC=gzip-1.14.tar.xz
MD5=4bf5a10f287501ee8e8ebe00ef62b2c2
download

# buildscripts/L864-gzip.sh
URL=https://ftpmirror.gnu.org/gzip/gzip-1.14.tar.xz
SRC=gzip-1.14.tar.xz
MD5=4bf5a10f287501ee8e8ebe00ef62b2c2
download

# buildscripts/L865-iproute2.sh
URL=https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.18.0.tar.xz
SRC=iproute2-6.18.0.tar.xz
MD5=9e3f70620db43fe0ecab29b36a47914d
download

# buildscripts/L866-kbd.sh
URL=https://www.kernel.org/pub/linux/utils/kbd/kbd-2.9.0.tar.xz
SRC=kbd-2.9.0.tar.xz
MD5=7be7c6f658f5fb9512e2c490349a8eeb
download

# buildscripts/L867-libpipeline.sh
URL=https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.8.tar.gz
SRC=libpipeline-1.5.8.tar.gz
MD5=17ac6969b2015386bcb5d278a08a40b5
download

# buildscripts/L868-make.sh
URL=https://ftpmirror.gnu.org/make/make-4.4.1.tar.gz
SRC=make-4.4.1.tar.gz
MD5=c8469a3713cbbe04d955d4ae4be23eeb
download

# buildscripts/L869-patch.sh
URL=https://ftpmirror.gnu.org/patch/patch-2.8.tar.xz
SRC=patch-2.8.tar.xz
MD5=149327a021d41c8f88d034eab41c039f
download

# buildscripts/L870-tar.sh
URL=https://ftpmirror.gnu.org/tar/tar-1.35.tar.xz
SRC=tar-1.35.tar.xz
MD5=a2d8042658cfd8ea939e6d911eaf4152
download

# buildscripts/L871-texinfo.sh
URL=https://ftpmirror.gnu.org/texinfo/texinfo-7.2.tar.xz
SRC=texinfo-7.2.tar.xz
MD5=11939a7624572814912a18e76c8d8972
download

# buildscripts/L872-vim.sh
URL=https://github.com/vim/vim/archive/v9.2.0078/vim-9.2.0078.tar.gz
SRC=vim-9.2.0078.tar.gz
MD5=592819d17a5f76d39ddba5651912afe0
download

# buildscripts/L873-markupsafe.sh
URL=https://pypi.org/packages/source/M/MarkupSafe/markupsafe-3.0.3.tar.gz
SRC=markupsafe-3.0.3.tar.gz
MD5=13a73126d25afa72a1ff0daed072f5fe
download

# buildscripts/L874-jinja2.sh
URL=https://pypi.org/packages/source/J/Jinja2/jinja2-3.1.6.tar.gz
SRC=jinja2-3.1.6.tar.gz
MD5=66d4c25ff43d1deaf9637ccda523dec8
download

# buildscripts/L875-systemd.sh
URL=https://codeload.github.com/systemd/systemd/tar.gz/refs/tags/v260.2
SRC=systemd-260.2.tar.gz
MD5=9f066cdb9c32177830add1e21d13c4f6
download

# archive https://anduin.linuxfromscratch.org/LFS/systemd-man-pages-260.2.tar.xz
URL=https://anduin.linuxfromscratch.org/LFS/systemd-man-pages-260.2.tar.xz
SRC=systemd-man-pages-260.2.tar.xz
download

# buildscripts/L876-d-bus.sh
URL=https://dbus.freedesktop.org/releases/dbus/dbus-1.16.2.tar.xz
SRC=dbus-1.16.2.tar.xz
MD5=97832e6f0a260936d28536e5349c22e5
download

# buildscripts/L877-man-db.sh
URL=https://download.savannah.gnu.org/releases/man-db/man-db-2.13.1.tar.xz
SRC=man-db-2.13.1.tar.xz
MD5=b6335533cbeac3b24cd7be31fdee8c83
download

# buildscripts/L878-procps-ng.sh
URL=https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.6.tar.xz
SRC=procps-ng-4.0.6.tar.xz
MD5=20c23dc3dd1569a2bb1d1fa93de213ed
download

# buildscripts/L879-util-linux.sh
URL=https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.3.tar.xz
SRC=util-linux-2.41.3.tar.xz
MD5=d2faa85303dea29e7f6ee40a9465e528
download

# buildscripts/L880-e2fsprogs.sh
URL=https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.3/e2fsprogs-1.47.3.tar.gz
SRC=e2fsprogs-1.47.3.tar.gz
MD5=113d7a7ee0710d2a670a44692a35fd2e
download

# buildscripts/L881-stripping.sh
# buildscripts/L882-cleanup.sh
# buildscripts/L900-network-configuration.sh
# buildscripts/L901-devices.sh
# buildscripts/L902-system-clock.sh
# buildscripts/L903-configure-console.sh
# buildscripts/L904-configure-system-locale.sh
# buildscripts/L905-create-inputrc.sh
# buildscripts/L906-create-shells.sh
# buildscripts/L907-configuring-systemd.sh
# buildscripts/L950-create-fstab.sh
# buildscripts/L951-kernel.sh
URL=https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.0.11.tar.xz
SRC=linux-7.0.11.tar.xz
SHA256=
download

# buildscripts/P001-create-dirs.sh
# buildscripts/P002-add-user.sh
# buildscripts/P500-binutils-pass1.sh
URL=https://sourceware.org/pub/binutils/releases/binutils-2.46.0.tar.xz
SRC=binutils-2.46.0.tar.xz
MD5=81bb6810bcd1119819dc0804956e1c92
download

# buildscripts/P501-gcc-pass1.sh
URL=https://ftpmirror.gnu.org/gcc/gcc-16.1.0/gcc-16.1.0.tar.xz
SRC=gcc-16.1.0.tar.xz
SHA256=50efb4d94c3397aff3b0d61a5abd748b4dd31d9d3f2ab7be05b171d36a510f79
download

# archive https://ftpmirror.gnu.org/mpfr/mpfr-4.2.2.tar.xz
URL=https://ftpmirror.gnu.org/mpfr/mpfr-4.2.2.tar.xz
SRC=mpfr-4.2.2.tar.xz
download

# archive https://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz
URL=https://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz
SRC=gmp-6.3.0.tar.xz
download

# archive https://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz
URL=https://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz
SRC=mpc-1.3.1.tar.gz
download

# buildscripts/P502-api-headers.sh
URL=https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.0.11.tar.xz
SRC=linux-7.0.11.tar.xz
download

# buildscripts/P503-glibc.sh
URL=https://ftpmirror.gnu.org/glibc/glibc-2.43.tar.xz
SRC=glibc-2.43.tar.xz
MD5=7ec2588300b299215a65aec7e6afa04f
download

# buildscripts/P504-libstdcpp.sh
URL=https://ftpmirror.gnu.org/gcc/gcc-16.1.0/gcc-16.1.0.tar.xz
SRC=gcc-16.1.0.tar.xz
SHA256=50efb4d94c3397aff3b0d61a5abd748b4dd31d9d3f2ab7be05b171d36a510f79
download

# buildscripts/P600-m4.sh
URL=https://ftpmirror.gnu.org/m4/m4-1.4.21.tar.xz
SRC=m4-1.4.21.tar.xz
MD5=8051eef7239b2f187791f2ab0034d6b7
download

# buildscripts/P601-ncurses.sh
URL=https://invisible-mirror.net/archives/ncurses/ncurses-6.6.tar.gz
SRC=ncurses-6.6.tar.gz
MD5=dd45bf6854430af403452a7a6a40652c
download

# buildscripts/P602-bash.sh
URL=https://ftpmirror.gnu.org/bash/bash-5.3.tar.gz
SRC=bash-5.3.tar.gz
MD5=977c8c0c5ae6309191e7768e28ebc951
download

# buildscripts/P603-coreutils.sh
URL=https://ftpmirror.gnu.org/coreutils/coreutils-9.10.tar.xz
SRC=coreutils-9.10.tar.xz
MD5=b0482ebec42fd48e95cb9187d566b9e4
download

# buildscripts/P604-diffutils.sh
URL=https://ftpmirror.gnu.org/diffutils/diffutils-3.12.tar.xz
SRC=diffutils-3.12.tar.xz
MD5=d1b18b20868fb561f77861cd90b05de4
download

# buildscripts/P605-file.sh
URL=https://astron.com/pub/file/file-5.46.tar.gz
SRC=file-5.46.tar.gz
MD5=459da2d4b534801e2e2861611d823864
download

# buildscripts/P606-findutils.sh
URL=https://ftpmirror.gnu.org/findutils/findutils-4.10.0.tar.xz
SRC=findutils-4.10.0.tar.xz
MD5=870cfd71c07d37ebe56f9f4aaf4ad872
download

# buildscripts/P607-gawk.sh
URL=https://ftpmirror.gnu.org/gawk/gawk-5.3.2.tar.xz
SRC=gawk-5.3.2.tar.xz
MD5=b7014650c5f45e5d4837c31209dc0037
download

# buildscripts/P608-grep.sh
URL=https://ftpmirror.gnu.org/grep/grep-3.12.tar.xz
SRC=grep-3.12.tar.xz
MD5=5d9301ed9d209c4a88c8d3a6fd08b9ac
download

# buildscripts/P609-gzip.sh
URL=https://ftpmirror.gnu.org/gzip/gzip-1.14.tar.xz
SRC=gzip-1.14.tar.xz
MD5=4bf5a10f287501ee8e8ebe00ef62b2c2
download

# buildscripts/P610-make.sh
URL=https://ftpmirror.gnu.org/make/make-4.4.1.tar.gz
SRC=make-4.4.1.tar.gz
MD5=c8469a3713cbbe04d955d4ae4be23eeb
download

# buildscripts/P611-patch.sh
URL=https://ftpmirror.gnu.org/patch/patch-2.8.tar.xz
SRC=patch-2.8.tar.xz
MD5=149327a021d41c8f88d034eab41c039f
download

# buildscripts/P612-sed.sh
URL=https://ftpmirror.gnu.org/sed/sed-4.9.tar.xz
SRC=sed-4.9.tar.xz
MD5=6aac9b2dbafcd5b7a67a8a9bcb8036c3
download

# buildscripts/P613-tar.sh
URL=https://ftpmirror.gnu.org/tar/tar-1.35.tar.xz
SRC=tar-1.35.tar.xz
MD5=a2d8042658cfd8ea939e6d911eaf4152
download

# buildscripts/P614-xz.sh
URL=https://github.com//tukaani-project/xz/releases/download/v5.8.2/xz-5.8.2.tar.xz
SRC=xz-5.8.2.tar.xz
MD5=87c8bb8addf7189d3a51f6a5f03163fc
download

# buildscripts/P615-binutils-pass2.sh
URL=https://sourceware.org/pub/binutils/releases/binutils-2.46.0.tar.xz
SRC=binutils-2.46.0.tar.xz
MD5=81bb6810bcd1119819dc0804956e1c92
download

# buildscripts/P616-gcc-pass2.sh
URL=https://ftpmirror.gnu.org/gcc/gcc-16.1.0/gcc-16.1.0.tar.xz
SRC=gcc-16.1.0.tar.xz
SHA256=50efb4d94c3397aff3b0d61a5abd748b4dd31d9d3f2ab7be05b171d36a510f79
download

# archive https://ftpmirror.gnu.org/mpfr/mpfr-4.2.2.tar.xz
URL=https://ftpmirror.gnu.org/mpfr/mpfr-4.2.2.tar.xz
SRC=mpfr-4.2.2.tar.xz
download

# archive https://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz
URL=https://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz
SRC=gmp-6.3.0.tar.xz
download

# archive https://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz
URL=https://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz
SRC=mpc-1.3.1.tar.gz
download

