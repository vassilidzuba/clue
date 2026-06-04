# Initialize media

This document describes the behaviour of the script
[prepare-media.sh](../prepare-media.sh). It prepares the media for the linux installation, as specified in the configuration file `config.yaml`.

## The variants

The variants when executing this scripts are:

- using a disk partition or a qemu virtual disk
- using encryption with LUKS or not
- choosing the file system (ext4 or btrfs). When using btrfs, `/` and `/home` are in distinct subvolumes

It is also possible to prepare and mount the device manually,
ouside of the scripts proposed here. In that case, the property 'devicetype'
must be 'other', and it must be mounted 
before callingh the installation scripts.

## Device and partition

When using a hardware disk partition, we have two properties:

- device: the device (e.g. '/dev/sdb'), where the partition table is expected to exist
- partition: the installation partition (e.g. `/dev/sdb5`)

When using a qemu virtual disk, we need to specify:

- the file name of the image (e.g. `qlsystemd.img`)
- the nbd device to which the image will be connected (e.g. `/dev/nbd2`)
- the partition to which the installation will be performed (e.g. `/dev/nbd2p1`)

As the script creates the partition table with a single partition, the partition will always be the first one.

## Encrypting

When encrypting, we will need :

- to encrypt the partition to which we will perform the installation
- to open the encrypted partition

Now, the partition to be formatted will be `/dev/mapper/<name>` where
`<name>` is the name used when opening the encrypted partition.

The encryption passphrase can be either entered manually (but that might be boring after some time), and also stored in the configuration file. This last option is quite bad from a security standpoint, but this might not be very important in this case of exercice, and can be changed afterwards is needed.

## The configuration options

The configuration options are:

- devicetype: the device type, either `disk` or `qemu`
- fstype: the file system type, either 'ext4' or 'btrfs'
- image: the image name, when using qemu
- device: the device (e.g. /dev/sdb or /dev/nbd2)
- base_partition: the partition (e.g. /dev/sdb5 or /dev/nbd2p1)
- actual_partition: identical to the partition if no encryption is used, and a mapped device (e.g. `/dev/mapper/xlfs_qsl`) when it is used

## Formatting

The formaatting will be performed on the actual partition.


## Mounting the partition

Mounting the partition will not be performed in this script,
The mounted device will be the actual partition, as desribed before.

Nothe that the mountpoint is the only parameter required during
the actual installation, so the use of the `prepare-media` is
completely optional, and the device may be prepared (or with another script), and mounted manually.



-------------------------

[top](../README.md)
