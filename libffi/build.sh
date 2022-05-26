#!/bin/bash

AGS_DEPENDENCY=()
AGS_TARBALL="libffi-3.4.2.tar.gz"
AGS_MD5="294b921e6cf9ab0fbaea4b639f8fdbe8"

CC=clang
CXX=clang++

if [ "$1" == "--dependency" ]
then
    echo "${AGS_DEPENDENCY[*]}"

    exit 0
elif [ "$1" == "--tarball" ]
then
    echo "${AGS_TARBALL}"

    exit 0
elif [ "$1" == "--md5" ]
then
    echo "${AGS_MD5}"

    exit 0
fi

if [ "$1" == "--arch" ]
then
    if [ "$2" == "x86_64" ]
    then
	ags_arch="x86_64"

	export CFLAGS="-arch x86_64"
	export CXXFLAGS="-arch x86_64 -integrated-as"
	export OBJCFLAGS="-arch x86_64"

	export PATH=/opt/leap-x86_64/bin:/opt/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin
	
	export PKG_CONFIG_PATH="/opt/leap-x86_64/lib/pkgconfig"
    elif [ "$2" == "arm64" ]
    then
	ags_arch="arm64"

	export CFLAGS="-arch arm64"
        export CXXFLAGS="-arch arm64"
	export OBJCFLAGS="-arch arm64"

	export PATH=/opt/leap-arm64/bin:/opt/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin

	export PKG_CONFIG_PATH="/opt/leap-arm64/lib/pkgconfig"
    else
	echo "unknown arch: $2"
	
	exit 1
    fi
else
    echo "you have to specify --arch"
    
    exit 1
fi

if [[ -z "${AGS_PREFIX}" ]]
then
  ags_prefix="/opt/leap-${ags_arch}"
else
  ags_prefix="${AGS_PREFIX}"
fi

# unpack
tar -xxf libffi-3.4.2.tar.gz
cd libffi-3.4.2

# build
./configure --prefix="${ags_prefix}" --disable-multi-os-directory --disable-raw-api
make

sudo make install

