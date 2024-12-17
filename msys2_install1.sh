#!/bin/bash

set -e
set -o pipefail

if true; then
  # download/install msys2 package db
  wget --no-verbose $MSYS2INSTALLERURI/db.tar.gz
  tar -C /var/lib/pacman/sync/ -xzf $PWD/db.tar.gz
  rm -f db.tar.gz

  # download/install msys2 package cache
  wget --no-verbose $MSYS2INSTALLERURI/cache.tar.gz
  tar -C /var/cache/pacman/pkg/ -xzf $PWD/cache.tar.gz
  rm -f cache.tar.gz
fi

# update install msys2 packages according package db
if true; then
  pacman --noconfirm -Suu
else
  pacman --noconfirm -Syuu
fi
