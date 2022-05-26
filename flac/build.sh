#!/bin/bash

AGS_DEPENDENCY=()
AGS_TARBALL="flac-1.3.3.tar.xz"
AGS_PATCH=("patches/flac-1.3.3-security_fixes-1.patch")
AGS_MD5="26703ed2858c1fc9ffc05136d13daa69"

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
	
	export PKG_CONFIG_PATH="/opt/leap-x86_64/lib/pkgconfig"
    elif [ "$2" == "arm64" ]
    then
	ags_arch="arm64"

	export CFLAGS="-arch arm64"
        export CXXFLAGS="-arch arm64"
	export OBJCFLAGS="-arch arm64"

	export PATH=/opt/leap-arm64/bin:$PATH

	export PKG_CONFIG_PATH="/opt/leap-arm64/lib/pkgconfig"
    else
	echo "unknown arch: $2"
	
	exit 1
    fi
else
    echo "you have to specify --arch"
    
    exit 1
fi

CFLAGS+=" -include /opt/leap-${ags_arch}/include/libintl.h -include /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/uuid/uuid.h"
CXXFLAGS+=" -include /opt/leap-${ags_arch}/include/libintl.h -include /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/uuid/uuid.h"
OBJCFLAGS+=" -include /opt/leap-${ags_arch}/include/libintl.h -include /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/uuid/uuid.h"

export CFLAGS
export CXXFLAGS
export OBJCFLAGS
export LDFLAGS="-L/opt/leap-${ags_arch}/lib -lintl"

if [[ -z "${AGS_PREFIX}" ]]
then
  ags_prefix="/opt/leap-${ags_arch}"
else
  ags_prefix="${AGS_PREFIX}"
fi

# unpack
tar -xxf flac-1.3.3.tar.xz
cd flac-1.3.3

# build
patch -Np1 -i ../flac-1.3.3-security_fixes-1.patch
./configure --prefix="${ags_prefix}"                                \
            --disable-thorough-tests                     \
            --docdir="${ags_prefix}"/share/doc/flac-1.3.3
make

sudo make install
