#!/bin/bash

set -e
set -o pipefail

# update install msys2 packages according package db
if true; then
  pacman --noconfirm -Suu
else
  pacman --noconfirm -Syuu
fi

# update install new mys2 packages according package db
pacman --noconfirm -S "$@"

if true; then
  # pack and store msys2 package cache
  tar -C /var/cache/pacman/pkg/ -czf /cache.tar.gz .

  # pack and store msys2 package db
  tar -C /var/lib/pacman/sync/ -czf /db.tar.gz .
fi

# remove msys2 cache
pacman --noconfirm -Scc
