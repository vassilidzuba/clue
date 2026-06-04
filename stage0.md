# CLUE : stage 0

This stage contains the build of the initial toolchain and temporary tools
as desribed in the book up to chapter 7 included.

note: as Arch currrently deploys gcc 16.1.1 and that
this it has trouble compiling the version indicated in the 
book (gcc 15.2), we will use verison 16.0 (the most recent one).

The processisng is :

- double check the configuration file is correct,
- create the installation media (either using the provided script or by yourself)
- check everyting is correct
- launch a script as root: [run_stage0-as-root.sh](./scripts/run_stage0-as-root.sh)
- launch a script as user `xlfs`: [run_stage0-as-xlfs.sh](./scripts/run_stage0-as-xlfs.sh)
- backup the installation as normal user

## Creating directories and user

The script `build-as-root.sh` calls two scripts and must be run as root:

- [01-create-dirs.sh](scripts/01-create-dirs.sh)
- [02-add-user.sh](scripts/01-add-user.sh)

As we will run scripts as user `xlfs`, we will need to give that user access
to the root directory of the repo, maybe using acl or creating a new group.


## Building the tools

Before running the scripts, one miught want to copy the archives of the programs to the directory '/sources' in the installation. If not, they will be downloaded automatically. 

We need to run these script as user `xlfs` in a login shell:

    su - xlfs

The script to run all the builds is 

- [build_as_xlfs.sh](scripts/build_as_xlfs.sh)

After running that script, one will be at the end of chapter 6 of the book, and ready to start stage1.

One still need top reset the ownership of the files from xlfs to root:

    sudo stage0/scripts.change_ownership.sh

One might want to backup the current state, by running for instance:

    scripts/backup.sh stage0

-------------------------

[top](../README.md)
