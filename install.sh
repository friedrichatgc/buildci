#!/bin/bash

if [ $MSYS2INSTALLERDOWNLOAD -eq 1 ]; then
  # download/install msys2 package db
  wget $MSYS2INSTALLERDB -O msys2db.tar.bz2
  tar -C / -xjf msys2db.tar.bz2
  rm msys2db.tar.bz2

  # download/install msys2 package cache
  wget $MSYS2INSTALLERCACHE -O msys2cache.tar.bz2
  tar -C / -xjf msys2cache.tar.bz2
  rm msys2cache.tar.bz2
fi

# update install msys2 packages according package db
pacman --noconfirm -Suu

# update install new mys2 packages according package db
pacman --noconfirm -S \
  dos2unix \
  patch

if [ $MSYS2INSTALLERUPLOAD -eq 1 ]; then
  # pack/upload msys2 package cache
  tar -C / -cjf msys2cache.tar.bz2 /var/cache/pacman/pkg/
  wput $MSYS2INSTALLERCACHE -O msys2cache.tar.bz2
  rm msys2cache.tar.bz2
  
  # pack/upload msys2 package db
  tar -C / -cjf msys2db.tar.bz2 /var/lib/pacman/sync/
  wput $MSYS2INSTALLERDB -O msys2db.tar.bz2
  rm msys2db.tar.bz2
fi

# remove msys2 cache
pacman --noconfirm -Scc"
