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
tar -xxf sgml-common-0.6.3.tgz
cd sgml-common-0.6.3

# build
patch -Np1 -i ../sgml-common-0.6.3-manpage-1.patch
autoreconf -f -i

./configure --prefix="${ags_prefix}" --sysconfdir="${ags_prefix}"/etc
make

sudo make docdir="${ags_prefix}"/share/doc install &&

sudo install-catalog --add "${ags_prefix}"/etc/sgml/sgml-ent.cat \
    "${ags_prefix}"/usr/share/sgml/sgml-iso-entities-8879.1986/catalog &&

sudo install-catalog --add "${ags_prefix}"/etc/sgml/sgml-docbook.cat \
    "${ags_prefix}"/etc/sgml/sgml-ent.cat
