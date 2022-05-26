#!/bin/bash

lipo -arch x86_64 /opt/leap-x86_64/bin/gsequencer -arch arm64 /opt/leap-arm64/bin/gsequencer -create -output Contents/MacOS/GSequencer

files=( $(ls /opt/leap-x86_64/lib/*.dylib) )

for f in "${files[@]}"
do
    filename=`basename $f`

    if [ -f "/opt/leap-arm64/lib/$filename" ]
    then
	lipo -arch x86_64 /opt/leap-x86_64/lib/$filename -arch arm64 /opt/leap-arm64/lib/$filename -create -output Contents/Resources/lib/$filename
    fi
done

files=( $(ls /opt/leap-x86_64/lib64/*.dylib) )

for f in "${files[@]}"
do
    filename=`basename $f`

    if [ -f "/opt/leap-arm64/lib64/$filename" ]
    then
	lipo -arch x86_64 /opt/leap-x86_64/lib64/$filename -arch arm64 /opt/leap-arm64/lib64/$filename -create -output Contents/Resources/lib/$filename
    fi
done

files=( $(ls /opt/leap-x86_64/lib/gdk-pixbuf-2.0/2.10.0/loaders/*.so) )

for f in "${files[@]}"
do
    filename=`basename $f`

    if [ -f "/opt/leap-arm64/lib/gdk-pixbuf-2.0/2.10.0/loaders/$filename" ]
    then
	lipo -arch x86_64 /opt/leap-x86_64/lib/gdk-pixbuf-2.0/2.10.0/loaders/$filename -arch arm64 /opt/leap-arm64/lib/gdk-pixbuf-2.0/2.10.0/loaders/$filename -create -output Contents/Resources/lib/gdk-pixbuf-2.0/2.10.0/loaders/$filename
    fi
done

files=( $(ls /opt/leap-x86_64/lib/gtk-4.0/4.0.0/printbackends/*.so) )

for f in "${files[@]}"
do
    filename=`basename $f`

    if [ -f "/opt/leap-arm64/lib/gtk-3.0/3.0.0/printbackends/$filename" ]
    then
	lipo -arch x86_64 /opt/leap-x86_64/lib/gtk-3.0/3.0.0/printbackends/$filename -arch arm64 /opt/leap-arm64/lib/gtk-3.0/3.0.0/printbackends/$filename -create -output Contents/Resources/lib/gtk-3.0/3.0.0/printbackends/$filename
    fi
done
