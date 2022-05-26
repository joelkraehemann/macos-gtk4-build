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
tar -xxf dbus-1.12.20.tar.gz
cd dbus-1.12.20

# build
./configure --disable-dependency-tracking \
            --prefix="${ags_prefix}"                        \
            --sysconfdir="${ags_prefix}"/etc                    \
            --localstatedir="${ags_prefix}"/var                 \
            --disable-doxygen-docs               \
            --disable-xml-docs                   \
	    --without-x \
            --disable-static \
	    --enable-launchd \
	    --with-launchd-agent-dir="${ags_prefix}"
make
sudo make install
