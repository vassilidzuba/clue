# CLUE

CLUE (*Constructing Linux as a Useful Exercice*) contains experimentations based on LFS and BLFS.

[LFS](https://www.linuxfromscratch.org/lfs/) is a book describing
how to install Linux while compiling everything from scratch.

[BLFS](https://www.linuxfromscratch.org/blfs/) is a book describing
how to add useful programs to the LFS.

In this repo, you will find scripts to make the installation
using scripts. These scripts are manually written and not 
automatically derived from the book as in
[ALFS](https://www.linuxfromscratch.org/alfs/), but the computer instructions are mostly copied from the book.

This work is distributed under the *Creative Commons Attribution-NonCommercial-ShareAlike 2.0 License*, as the LFS book.

## Prerequisites

You will need a running Linux installation (I use Arch btw) with :

- an access to Internet to download the archives
- sudo priviledges
- qemu

## Generalities

The general procedure will be to :

- clone this repo; all the scripts are expected to be run from the root of the repo unless when running in a chroot or a VM
- configure the build in the `config.yaml` file
- initialize the media by `scripts/prepare_media.sh`
- follow the instructions to run the scripts

This project is expected in term to provide some variants from the 
Book, for instance:

- root volume encryption
- alternate init systems
- additional programs

The build is done in three stages:

- stag0 is done from the host
- stage1 is done in a chroot (as root)
- stage2 is done in a VM, as an ordinary user

It will be configured through a configuration file `config.yaml`
at the root of the repo.

## Installation media

The installation can be done on :

- a disk partition, or
- a qemu disk image

## The basic scripts

These are scripts in subdirectory `scripts`, that are independent
from the stages.

- checkconfig.sh: perform sanity checks on the config file
- prepare_media.sh : create and initialmizes the media where the installation will be built
- mount.sh: mount the installatin media
- umount.sh: umount the installation media
- reset_target.sh: remove everything but directory `sources` from the installation media
- chroot.sh: enter chroot in thje installation (if possible)
- start-quemu.sh: run the installation in a VM
- backup.sh: backup the installation in a tar file
- restore.sh: restore the installation from a tar file
- switch.sh: switch from one configuration file to another


An empty file `i_am_the_root` is present at the root of the
repo. It uis used to easily check that we are indeed at the root
of the repo when running a script.

## Organisation of the scripts

The scripts are organized in three stage:

- [stage0.md](./stage0.md) run from the host machine
- [stage1](./stage1/README.md) run in a chroot environment
- [stage3](./stage2/README.md) run in a qemu virtual machine (or possibly from the new installation)

## The configuration file

The configuration file is `config.yaml` at the root of the repo.
It will be read using `yq` that you will have to download 
the binary from
[https://github.com/mikefarah/yq](https://github.com/mikefarah/yq).

This program is used only to read the configuration file
and is not installed in the final target.

A script `scripts/checkconfig.sh` can be used to do some sanity 
checks on the configuration file.

We now describe the properties defined in the configuration file.

The repo contain some sample config files:

- systemd : installation with systemd (plain LFS+BLFS) on a disk formatted with ext4
- qlsystemd: installation with systemd on a encrypted dtrfs drive
- qsystemd : installation with systemd (plain LFS + BLFS) on a qemu drive
- s6: installation with s6 init on a disk formatted with ext4

WARNING: these sample config files contain device paths and names of mount points directories that you would want to change !!!

### suffix

This is the suffix used to save the configuration file
with the `switch.sh` command.

### devicetype

This is the type of device on which the installation will be made.
It can be one of the two values:

- disk: a disk partition
- image : a quemu image file

### device

This is the device on which the installation will be performed.

For a disk drive, it should be something like `/dev/sda3` or
`/dev/nvme0n1p3`, that is the name of the partition,

For a qemu virtual drive, it will be the name of the nbd device, for instance
`/dev/nbd0`.  The scripts will derive from it the name of the partition by adding the suffix `p1`.

### fstype

This is the type of file system created on the device; it can be:

- ext4, or
- btrfs

### image

When using a qemu virtual device, this is the name of the image file.

### luks

This indicates if the installation media will be encrypted 
using LUKS. It can take a value `yes` or `no`.

### label

The label of the device

### xlfs

The mount point of the CLUE installation.

### backup

The directory where the backup tar files will be stored

### options

This will be a group of options allowing to select the packages
that will be installed.


    options:
       with_systemd:    true
       with_s6:         false
       with_vim:        false
       with_nano:       true
       with_initramfs:  false

Most of the packages are installed unconditionally. The options allow to select:

- which editor to install (`vim` or `nano`). One can select both.
- which init system to install ('systemd' or 's6'). Only one should be chosen
- if an `initramfs` shoud be created (necessary when using luks)
