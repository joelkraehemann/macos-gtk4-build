#!/bin/bash
# 
# Copyright (C) 2005-2020 Joël Krähemann
# 
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

exec_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/MacOS/GSequencer`

for exec_file in $exec_files
do
    echo $exec_file

    dep_files=`otool -L $exec_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file 
    done

    dep_file=libinstpatch-1.0.2.dylib
    install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file
    
    dep_file=libags_gui.dylib
    install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file

    dep_file=libags_audio.dylib
    install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file

    dep_file=libags_server.dylib
    install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file

    dep_file=libags_thread.dylib
    install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file

    dep_file=libags.dylib
    install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file
done

exec_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/MacOS/gst-*`

for exec_file in $exec_files
do
    echo $exec_file

    dep_files=`otool -L $exec_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/*.dylib`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/*.dylib`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib64/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

for dylib_file in $dylib_files
do
    echo $dylib_file

    install_name_tool -id $(basename $dylib_file) $dylib_file
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/gdk-pixbuf-2.0/2.10.0/loaders/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/gstreamer-1.0/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/libproxy/0.4.15/modules/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/mpg123/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/gtk-3.0/3.0.0/printbackends/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/gtk-3.0/3.0.0/immodules/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/cairo/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/dri/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/krb5/plugins/preauth/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/gawk/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/pkcs11/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/gio/modules/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file 
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/nss/*.dylib`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file
    done

    dep_files=`ls /opt/leap-x86_64/lib/nss/*.dylib`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/nss/$(basename $dep_file) $dylib_file
    done

    dep_files=`ls /opt/leap-x86_64/lib/nspr/*.dylib`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/nspr/$(basename $dep_file) $dylib_file
    done

done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/nspr/*.dylib`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file
    done

    dep_files=`ls /opt/leap-x86_64/lib/nspr/*.dylib`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/nspr/$(basename $dep_file) $dylib_file
    done

done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/db48/*.dylib`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file
    done

    dep_files=`ls /opt/leap-x86_64/lib/db48/*.dylib`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/db48/$(basename $dep_file) $dylib_file
    done

done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/graphviz/*.dylib`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file
    done

    dep_files=`ls /opt/leap-x86_64/lib/graphviz/*.dylib`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/graphviz/$(basename $dep_file) $dylib_file
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/pulse-13.0/modules/*.dylib`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file
    done

    dep_files=`ls /opt/leap-x86_64/lib/pulse-13.0/modules/*.dylib`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/pulse-13.0/modules/$(basename $dep_file) $dylib_file
    done
done

dylib_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/Resources/lib/pulse-13.0/modules/*.so`

for dylib_file in $dylib_files
do
    echo $dylib_file

    dep_files=`otool -L $dylib_file | grep -E "/opt/leap-x86_64/lib/[^\\/]*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $dylib_file
    done

    dep_files=`ls /opt/leap-x86_64/lib/pulse-13.0/modules/*.dylib`

    for dep_file in $dep_files
    do
        echo "-> $dep_file"
        
        install_name_tool -change $dep_file @executable_path/../Resources/lib/pulse-13.0/modules/$(basename $dep_file) $dylib_file
    done
done

dylib_files=("Contents/Resources/lib/libgsequencer.dylib" "Contents/Resources/lib/libgsequencer.0.dylib" "Contents/Resources/lib/libags_gui.dylib" "Contents/Resources/lib/libags_gui.3.dylib" "Contents/Resources/lib/libags_audio.dylib" "Contents/Resources/lib/libags_audio.3.dylib" "Contents/Resources/lib/libags_server.dylib" "Contents/Resources/lib/libags_server.3.dylib" "Contents/Resources/lib/libags_thread.dylib" "Contents/Resources/lib/libags_thread.3.dylib" "Contents/Resources/lib/libags.dylib" "Contents/Resources/lib/libags.3.dylib")

for ix in ${!dylib_files[*]}
do
    echo "${dylib_files[$ix]}"

    dep_files=("libgsequencer.dylib" "libags_gui.dylib" "libags_audio.dylib" "libags_server.dylib" "libags_thread.dylib" "libags.dylib" "libinstpatch-1.0.2.dylib")

    for jx in ${!dep_files[*]}
    do
        echo "-> ${dep_files[$jx]}"
        
        install_name_tool -change ${dep_files[$jx]} @executable_path/../Resources/lib/$(basename ${dep_files[$jx]}) ${dylib_files[$ix]} 
    done
done

install_name_tool -change libags_vst.dylib @executable_path/../Resources/lib/libags_vst.dylib Contents/MacOS/GSequencer
install_name_tool -change @rpath/libinstpatch-1.0.2.dylib @executable_path/../Resources/lib/libinstpatch-1.0.2.dylib Contents/MacOS/GSequencer

install_name_tool -change @rpath/libinstpatch-1.0.2.dylib @executable_path/../Resources/lib/libinstpatch-1.0.2.dylib Contents/Resources/lib/libags_audio.dylib
install_name_tool -change @rpath/libinstpatch-1.0.2.dylib @executable_path/../Resources/lib/libinstpatch-1.0.2.dylib Contents/Resources/lib/libags_audio.3.dylib

install_name_tool -change libags_vst.dylib @executable_path/../Resources/lib/libags_vst.dylib Contents/Resources/lib/libags_audio.dylib
install_name_tool -change libags_vst.dylib @executable_path/../Resources/lib/libags_vst.dylib Contents/Resources/lib/libags_audio.3.dylib

install_name_tool -change libags_vst.dylib @executable_path/../Resources/lib/libags_vst.dylib Contents/Resources/lib/libgsequencer.dylib
install_name_tool -change libags_vst.dylib @executable_path/../Resources/lib/libags_vst.dylib Contents/Resources/lib/libgsequencer.0.dylib

install_name_tool -change @rpath/libinstpatch-1.0.2.dylib @executable_path/../Resources/lib/libinstpatch-1.0.2.dylib Contents/Resources/lib/libgsequencer.dylib
install_name_tool -change @rpath/libinstpatch-1.0.2.dylib @executable_path/../Resources/lib/libinstpatch-1.0.2.dylib Contents/Resources/lib/libgsequencer.0.dylib


install_name_tool -change /opt/leap-x86_64/lib/nss/libssl3.dylib @executable_path/../Resources/lib/nss/libssl3.dylib Contents/Resources/lib/libpoppler.dylib
install_name_tool -change /opt/leap-x86_64/lib/nss/libssl3.dylib @executable_path/../Resources/lib/nss/libssl3.dylib Contents/Resources/lib/libpoppler.105.dylib
install_name_tool -change /opt/leap-x86_64/lib/nss/libssl3.dylib @executable_path/../Resources/lib/nss/libssl3.dylib Contents/Resources/lib/libpoppler.105.0.0.dylib

install_name_tool -change /opt/leap-x86_64/lib/nss/libsmime3.dylib @executable_path/../Resources/lib/nss/libsmime3.dylib Contents/Resources/lib/libpoppler.dylib
install_name_tool -change /opt/leap-x86_64/lib/nss/libsmime3.dylib @executable_path/../Resources/lib/nss/libsmime3.dylib Contents/Resources/lib/libpoppler.105.dylib
install_name_tool -change /opt/leap-x86_64/lib/nss/libsmime3.dylib @executable_path/../Resources/lib/nss/libsmime3.dylib Contents/Resources/lib/libpoppler.105.0.0.dylib

install_name_tool -change /opt/leap-x86_64/lib/nss/libnssutil3.dylib @executable_path/../Resources/lib/nss/libnssutil3.dylib Contents/Resources/lib/libpoppler.dylib 
install_name_tool -change /opt/leap-x86_64/lib/nss/libnssutil3.dylib @executable_path/../Resources/lib/nss/libnssutil3.dylib Contents/Resources/lib/libpoppler.105.dylib 
install_name_tool -change /opt/leap-x86_64/lib/nss/libnssutil3.dylib @executable_path/../Resources/lib/nss/libnssutil3.dylib Contents/Resources/lib/libpoppler.105.0.0.dylib 

install_name_tool -change /opt/leap-x86_64/lib/nss/libnss3.dylib @executable_path/../Resources/lib/nss/libnss3.dylib Contents/Resources/lib/libpoppler.dylib
install_name_tool -change /opt/leap-x86_64/lib/nss/libnss3.dylib @executable_path/../Resources/lib/nss/libnss3.dylib Contents/Resources/lib/libpoppler.105.dylib 
install_name_tool -change /opt/leap-x86_64/lib/nss/libnss3.dylib @executable_path/../Resources/lib/nss/libnss3.dylib Contents/Resources/lib/libpoppler.105.0.0.dylib 

install_name_tool -change /opt/leap-x86_64/lib/nspr/libplds4.dylib @executable_path/../Resources/lib/nspr/libplds4.dylib Contents/Resources/lib/libpoppler.dylib 
install_name_tool -change /opt/leap-x86_64/lib/nspr/libplds4.dylib @executable_path/../Resources/lib/nspr/libplds4.dylib Contents/Resources/lib/libpoppler.105.dylib 
install_name_tool -change /opt/leap-x86_64/lib/nspr/libplds4.dylib @executable_path/../Resources/lib/nspr/libplds4.dylib Contents/Resources/lib/libpoppler.105.0.0.dylib

install_name_tool -change /opt/leap-x86_64/lib/nspr/libplc4.dylib @executable_path/../Resources/lib/nspr/libplc4.dylib Contents/Resources/lib/libpoppler.dylib 
install_name_tool -change /opt/leap-x86_64/lib/nspr/libplc4.dylib @executable_path/../Resources/lib/nspr/libplc4.dylib Contents/Resources/lib/libpoppler.105.dylib 
install_name_tool -change /opt/leap-x86_64/lib/nspr/libplc4.dylib @executable_path/../Resources/lib/nspr/libplc4.dylib Contents/Resources/lib/libpoppler.105.0.0.dylib 

install_name_tool -change /opt/leap-x86_64/lib/nspr/libnspr4.dylib @executable_path/../Resources/lib/nspr/libnspr4.dylib Contents/Resources/lib/libpoppler.dylib 
install_name_tool -change /opt/leap-x86_64/lib/nspr/libnspr4.dylib @executable_path/../Resources/lib/nspr/libnspr4.dylib Contents/Resources/lib/libpoppler.105.dylib 
install_name_tool -change /opt/leap-x86_64/lib/nspr/libnspr4.dylib @executable_path/../Resources/lib/nspr/libnspr4.dylib Contents/Resources/lib/libpoppler.105.0.0.dylib
