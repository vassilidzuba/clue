#!/bin/bash

for arg in "$@"; do
    case $arg in
        --dryrun)
            DRYRUN=true
            echo '*** dry run in test'
            ;;
        --force)
            echo 'force in test'
            ;;
        *)
            echo "unknown option in test: $arg"
            ;;
    esac
done
