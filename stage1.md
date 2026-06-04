# CLUE : stage 1

This stage corresponds to chapters 7 to 10 of the Book, plus some BLFS packages.
Here, most of the scripts will be run in a chroot environment.

## Enter chroot

The script `scripts/chroot.sh` enter the chroot. It must be run at the root
of the repo, and as user `root`.

## Access to the scripts and the archives

To be able to access the scripts iwhen in the chrooted environment,
one mounts the root of the repo to `/mnt/shared`.
To run the scripts, it will then be necessary to `cd` to this directory.

The chrooted environment is not able to get files from the internet,
but it will be able to access the directory `shared` at the root of the 
repo. The build process will not need to have the archives in the directory
'/sources' anymore.


## Running the builds

The scripts are stored in directory 'stage1/scripts':

- when their name starts with '7', they belong to chepter 7 of the book
- when their name starts with '8', they belong to chepter 8 of the book
- when their name starts with 'B', they belong to the BLFS book
- when their name starts with 'E', they are extra packages, not described in the Books

The packages from the BLFS are :

- nano
- openssh and its dependencies
- fastfetch

The extra packages are:

- s6 and its depndencies

### ncurses

The build of ncurses copies the terminfo from `stage1/usr/share/terminfo`
for the terminfo that are not available in the ncurses package.
Currently, it contains only `xterm-kitty`, but you might want to add more.
The right terminfo is necessary for 'make menuconfig' when building manually the kernel.

### sudo

To facilitate stage2, where the builds are run as an ordinary user, 
we set a non password policy to sudo.

## Options

## Running the installation using qemu

The most basic command to launch the VM is:

    qemu-system-x86_64 \
        -kernel boot/vmlinuz-7.0.9-xlfs \
        -drive file=/dev/sdb,format=raw \
        -append "root=/dev/sda5 console=ttyS0" \
        -enable-kvm \
        -cpu host \
        -nographic

Note that the drive id /dev/sdb (in my case) but in the VM
the root parition is not '/dev/sdb5' (as seen in the host) 
but `/dev/sda5'

### Without init system

As a test, it is possible to run with a simple
bash script as the init command, `/sbin/init`.
You can see for instance [Linux From Nothing](https://www.youtube.com/watch?v=fk-KGj3pimA).

The script can be as simple as:

    #!/bin/bash
    mount -t proc none /proc
    mount -t sysfs none /sys
    exec /bin/bash

Of course, we have no network, and the kernel panic if we quit the shell.

### Without init system but with network
