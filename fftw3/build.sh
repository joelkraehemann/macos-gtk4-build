#!/bin/bash

AGS_DEPENDENCY=()
AGS_TARBALL="fftw-3.3.10.tar.gz"
AGS_MD5="8ccbf6a5ea78a16dbc3e1306e234cc5c"

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
	export CXXFLAGS="-arch x86_64"
	export OBJCFLAGS="-arch x86_64"

	export PATH=/opt/leap-x86_64/bin:$PATH
	
	export PKG_CONFIG_PATH="/opt/leap-x86_64/lib/pkgconfig:/opt/leap-x86_64/lib64/pkgconfig"
    elif [ "$2" == "arm64" ]
    then
	ags_arch="arm64"

	export CFLAGS="-arch arm64"
        export CXXFLAGS="-arch arm64"
	export OBJCFLAGS="-arch arm64"

	export PATH=/opt/leap-arm64/bin:$PATH

	export PKG_CONFIG_PATH="/opt/leap-arm64/lib/pkgconfig:/opt/leap-arm64/lib64/pkgconfig"
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
tar -xxf fftw-3.3.10.tar.gz
cd fftw-3.3.10

# build
./configure --prefix="${ags_prefix}"    \
            --enable-shared  \
            --disable-static \
            --enable-threads
make

sudo make install

make clean &&

./configure --prefix="${ags_prefix}"    \
            --enable-shared  \
            --disable-static \
            --enable-threads
            --enable-float
make

sudo make install

make clean &&

./configure --prefix="${ags_prefix}"    \
            --enable-shared  \
            --disable-static \
            --enable-threads \
            --enable-long-double
make

sudo make install
