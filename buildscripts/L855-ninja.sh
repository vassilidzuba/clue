#!/bin/bash

if [ "$INCHROOT" != "1" ]; then
    echo "Not in chroot"
    exit 255
fi
cd /mnt/shared
if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_stage1.sh

PACKAGE=ninja-1.13.2
SOURCE=ninja-1.13.2.tar.gz
URL=https://github.com/ninja-build/ninja/archive/v1.13.2/ninja-1.13.2.tar.gz
MD5=76c00637fde44909cd7d56f8d73f2042


run_build () {
    sed -i '/int Guess/a \
      int   j = 0;\
      char* jobs = getenv( "NINJAJOBS" );\
      if ( jobs != NULL ) j = atoi( jobs );\
      if ( j > 0 ) return j;\
    ' src/ninja.cc &&

    python3 configure.py --bootstrap --verbose
}

run_test () {
    echo -n
}

run_install () {
    install -vm755 ninja /usr/bin/ &&
    install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja &&
    install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja
}

run_all
