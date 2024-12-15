#!/bin/bash

RSYNC_PASSWORD=$mbsimenvsec_filestoragePassword

# download/install msys2 package db
rsync -r $MSYS2INSTALLERDB/ /var/lib/pacman/sync/

# download/install msys2 package cache
rsync -r $MSYS2INSTALLERCACHE/ /var/cache/pacman/pkg/

# update install msys2 packages according package db
pacman --noconfirm -Suu

# update install new mys2 packages according package db
pacman --noconfirm -S "$@"

# pack/upload msys2 package cache
rsync -r --delete /var/cache/pacman/pkg/ $MSYS2INSTALLERCACHE/

# pack/upload msys2 package db
rsync -r --delete /var/lib/pacman/sync/ $MSYS2INSTALLERDB/

# remove msys2 cache
pacman --noconfirm -Scc
