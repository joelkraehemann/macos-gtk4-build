#!/bin/bash

AGS_DEPENDENCY=()
AGS_TARBALL="libjpeg-turbo-2.1.2.tar.gz"

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

export CPATH==/opt/leap-"${ags_arch}"/include:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
export CPLUS_INCLUDE_PATH=/opt/leap-"${ags_arch}"/include

if [[ -z "${AGS_PREFIX}" ]]
then
  ags_prefix="/opt/leap-${ags_arch}"
else
  ags_prefix="${AGS_PREFIX}"
fi

# unpack
tar -xxf libjpeg-turbo-2.1.2.tar.gz
cd libjpeg-turbo-2.1.2

# build
mkdir build
cd build

cmake  -DCMAKE_BUILD_TYPE=Release   \
       -DCMAKE_INSTALL_PREFIX="${ags_prefix}" \
       -DENABLE_STATIC=FALSE       \
       -DCMAKE_INSTALL_DOCDIR="${ags_prefix}"/share/doc/libjpeg-turbo-2.1.2 \
       -DCMAKE_INSTALL_DEFAULT_LIBDIR=lib \
       -DWITH_SIMD=FALSE \
       ..
make

sudo make install

