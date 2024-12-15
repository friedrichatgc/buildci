#!/bin/bash

#mfmf
which wget
which tar
which gzip
which bzip2
which gunzip
which bunzip2
#mfmf

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
  patch \
  unzip \
  mingw-w64-ucrt-x86_64-7zip \
  mingw-w64-ucrt-x86_64-swig \
  mingw-w64-ucrt-x86_64-arpack \
  mingw-w64-ucrt-x86_64-autotools \
  mingw-w64-ucrt-x86_64-boost \
  mingw-w64-ucrt-x86_64-cmake \
  mingw-w64-ucrt-x86_64-doxygen \
  mingw-w64-ucrt-x86_64-gcc \
  mingw-w64-ucrt-x86_64-graphviz \
  mingw-w64-ucrt-x86_64-hdf5 \
  mingw-w64-ucrt-x86_64-octave \
  mingw-w64-ucrt-x86_64-openblas \
  mingw-w64-ucrt-x86_64-python-numpy \
  mingw-w64-ucrt-x86_64-python-sympy \
  mingw-w64-ucrt-x86_64-python-scipy \
  mingw-w64-ucrt-x86_64-python-matplotlib \
  mingw-w64-ucrt-x86_64-python-h5py \
  mingw-w64-ucrt-x86_64-python-psutil \
  mingw-w64-ucrt-x86_64-python-pygithub \
  mingw-w64-ucrt-x86_64-python-paramiko \
  mingw-w64-ucrt-x86_64-pyside2 \
  mingw-w64-ucrt-x86_64-pyside2-tools \
  mingw-w64-ucrt-x86_64-qwt-qt5 \
  mingw-w64-ucrt-x86_64-diffutils \
  mingw-w64-ucrt-x86_64-soqt-qt5 \
  mingw-w64-ucrt-x86_64-spooles \
  mingw-w64-ucrt-x86_64-xalan-c \
  mingw-w64-ucrt-x86_64-xerces-c \
  mingw-w64-ucrt-x86_64-ccache \
  mingw-w64-ucrt-x86_64-python-pip \
  mingw-w64-ucrt-x86_64-python-asgiref \
  mingw-w64-ucrt-x86_64-python-pytz \
  mingw-w64-ucrt-x86_64-python-sqlparse \
  mingw-w64-ucrt-x86_64-python-requests \
  mingw-w64-ucrt-x86_64-python-pyjwt \
  mingw-w64-ucrt-x86_64-python-cryptography \
  mingw-w64-ucrt-x86_64-python-cffi \
  mingw-w64-ucrt-x86_64-python-defusedxml \
  mingw-w64-ucrt-x86_64-python-oauthlib \
  mingw-w64-ucrt-x86_64-python-psycopg2 \
  mingw-w64-ucrt-x86_64-gcc-fortran \
  mingw-w64-ucrt-x86_64-python-requests-oauthlib

if [ $MSYS2INSTALLERUPLOAD -eq 1 ]; then
  # pack/upload msys2 package cache
  tar -C / -cjf msys2cache.tar.bz2 /var/cache/pacman/pkg/
  ls -l msys2cache.tar.bz2 #mfmf
  #mfmf wput $MSYS2INSTALLERCACHE -O msys2cache.tar.bz2
  rm msys2cache.tar.bz2
  
  # pack/upload msys2 package db
  tar -C / -cjf msys2db.tar.bz2 /var/lib/pacman/sync/
  ls -l msys2db.tar.bz2 #mfmf
  #mfmf wput $MSYS2INSTALLERDB -O msys2db.tar.bz2
  rm msys2db.tar.bz2
fi

# remove msys2 cache
pacman --noconfirm -Scc
