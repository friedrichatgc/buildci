#!/bin/bash

set -e
set -o pipefail

SSHPASS=$mbsimenvsec_filestoragePassword

# download/install msys2 package db
sshpass -e rsync -e "ssh -p $MSYS2INSTALLERDBPORT -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" -r $MSYS2INSTALLERDB/msys2mbsimenv-downloads/db/ /var/lib/pacman/sync/

# download/install msys2 package cache
sshpass -e rsync -e "ssh -p $MSYS2INSTALLERCACHEPORT -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" -r $MSYS2INSTALLERCACHE/ /var/cache/pacman/pkg/

# update install msys2 packages according package db
pacman --noconfirm -Suu

# update install new mys2 packages according package db
pacman --noconfirm -S "$@"

# pack/upload msys2 package cache
sshpass -e rsync -e "ssh -p $MSYS2INSTALLERCACHEPORT -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" -r --delete /var/cache/pacman/pkg/ $MSYS2INSTALLERCACHE/

# pack/upload msys2 package db
sshpass -e rsync -e "ssh -p $MSYS2INSTALLERDBPORT -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" -r --delete /var/lib/pacman/sync/ $MSYS2INSTALLERDB/

# remove msys2 cache
pacman --noconfirm -Scc
