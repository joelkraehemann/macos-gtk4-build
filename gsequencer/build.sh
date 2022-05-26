#!/bin/bash

AGS_DEPENDENCY=()
AGS_TARBALL="gsequencer-3.11.7.tar.gz"
AGS_PATCH=("patches/configure-ac-header.patch" "patches/makefile-am.patch")
AGS_MD5="42ce36b35869e822ca4afd4ae5e42c23"

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

	export PATH=/opt/leap-x86_64/bin:/opt/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin
	
	export PKG_CONFIG_PATH="/opt/leap-x86_64/lib/pkgconfig:/opt/leap-x86_64/lib64/pkgconfig"
    elif [ "$2" == "arm64" ]
    then
	ags_arch="arm64"

	export CFLAGS="-g -arch arm64 -I/opt/leap-arm64/include"
        export CXXFLAGS="-g -arch arm64"
	export OBJCFLAGS="-g -arch arm64"

	export PATH=/opt/leap-arm64/bin:/opt/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin

	export PKG_CONFIG_PATH="/opt/leap-arm64/lib/pkgconfig:/opt/leap-arm64/lib64/pkgconfig"
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
git checkout tarball -- "${AGS_TARBALL}"

for p in "${AGS_PATCH[@]}"
do
    git checkout tarball -- "${p}"
done

mkdir source
cd source
tar -xxf ../"${AGS_TARBALL}" --strip-components=1

for p in "${AGS_PATCH[@]}"
do
    patch -p0 < ../"${p}"
done

# build
autoreconf -fi
./configure --prefix="${ags_prefix}" --enable-osxapi --enable-mac-integration --enable-osx-dmg-env --disable-x11 --disable-rt --disable-alsa --disable-pulse --disable-jack --enable-alsa-compat --enable-core-audio --enable-vst3 --enable-quartz --disable-introspection --without-gstreamer --without-webkit --with-poppler
make -j8

sudo make install

# clean
cd ..
# rm -rf source
# rm -f "${AGS_TARBALL}"
