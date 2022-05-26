#!/bin/bash

AGS_DEPENDENCY=()
AGS_TARBALL=""
AGS_MD5=""

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

	export CFLAGS="-g -arch x86_64 -I/opt/leap-x86_64/include"
	export CXXFLAGS="-g -arch x86_64"
	export OBJCFLAGS="-g -arch x86_64"

	export PATH=/opt/leap-x86_64/bin:$PATH
	
	export PKG_CONFIG_PATH="/opt/leap-x86_64/lib/pkgconfig:/opt/leap-x86_64/lib64/pkgconfig"
    elif [ "$2" == "arm64" ]
    then
	ags_arch="arm64"

	export CFLAGS="-g -arch arm64 -I/opt/leap-arm64/include"
        export CXXFLAGS="-g -arch arm64"
	export OBJCFLAGS="-g -arch arm64"

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

export LIBAGS_VST3_RELEASE_TYPE="-DRELEASE"
export LIBAGS_VST3_CPPFLAGS="-I$HOME/sources/VST_SDK/VST3_SDK"
export LIBAGS_VST3_LIBS="-L$HOME/sources/VST_SDK/build/lib/Debug"

if [[ -z "${AGS_PREFIX}" ]]
then
  ags_prefix="/opt/leap-${ags_arch}"
else
  ags_prefix="${AGS_PREFIX}"
fi

# unpack
tar -xxf poppler-22.02.0.tar.xz
cd poppler-22.02.0

# build
mkdir build && cd build

cmake  -DCMAKE_BUILD_TYPE=Release   \
       -DCMAKE_INSTALL_PREFIX="${ags_prefix}"  \
       -DTESTDATADIR=$PWD/testfiles \
       -DENABLE_UNSTABLE_API_ABI_HEADERS=ON \
       ..
make

sudo make install

tar -xf ../../poppler-data-0.4.11.tar.gz
cd poppler-data-0.4.11

make prefix="${ags_prefix}" install
