#!/bin/bash

AGS_DEPENDENCY=()
AGS_TARBALL=""

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

if [[ -z "${AGS_PREFIX}" ]]
then
  ags_prefix="/opt/leap-${ags_arch}"
else
  ags_prefix="${AGS_PREFIX}"
fi

# unpack
tar -xxf gtk-4.6.1.tar.xz
cd gtk-4.6.1

# build
mkdir build &&
cd    build

meson --prefix="${ags_prefix}" --buildtype=release -Dx11-backend=false -Dmacos-backend=true -Dbuild-examples=false -Dbuild-tests=false -Dintrospection=disabled -Dmedia-gstreamer=disabled -Dgtk_doc=false ..
ninja

sudo ninja install
