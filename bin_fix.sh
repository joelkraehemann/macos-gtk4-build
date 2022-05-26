#!/bin/bash
# 
# Copyright (C) 2005-2018 Joël Krähemann
# 
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

exec_files=`ls /Users/joelkrahemann/GSequencer.app/Contents/MacOS/GSequencer`

for exec_file in $exec_files
do
    echo $exec_file

    dep_files=`otool -L $exec_file | grep -E "/opt/leap-x86_64/lib/.*.dylib" | awk '{ print $1 }'`

    for dep_file in $dep_files
    do
	echo "-> $dep_file"
	
	install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file 
    done
    
    dep_files=`otool -L $exec_file | grep -E "/opt/leap-x86_64/lib64/.*.dylib" | awk '{ print $1 }'`

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
    
    dep_file=libags_vst.dylib
    install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file

    dep_file=libags.dylib
    install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file

    dep_file=libgsequencer.dylib
    install_name_tool -change $dep_file @executable_path/../Resources/lib/$(basename $dep_file) $exec_file
done
