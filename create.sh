#!/bin/sh - 
# set -x 




PRJDIR=$1

############################################################################### 

# used for Apple builds
export APPLE=1

export QTDIR=/local/qt/5.4
export BOOSTDIR=$HOME/local/packages/boost_1_59_0                      
export DOXYGENDIR=/local/Doxygen.app/Contents/Resources/

export CMAKEDIR=/Applications/CMake.app/Contents
export QMAKEDIR/local/qt/5.4/clang_64

###############################################################################

export PATH=$CMAKEDIR/bin:$PATH
export PATH=$qmakedir/bin:$PATH



# This is the head location of the project. It will assume the following 
# hierarchy:
# 
# <head>
#   +---source
#   |     +--<scripts>
#   |     +--<pacakge1>
#   |     +--<package2>
#   |     ...
#   |
#   +--- build      # the location of the builds for each package
#   |      +--<debug>
#   |
#   |
#   +--  <install>  # the final install directory
#          |
#          +-- bin
#          +-- lib
#          +-- include 
#          |     +-- <package1>
#          |     +-- <package2>
#          |     +-- <package3> ....
#          +-- etc
#
#
HEAD_DIR=`pwd`

############################################################################### 


# location for the install dir - final
INSTALL_DIR=$HEAD_DIR/install
SOURCE_DIR=$HEAD_DIR/source
BUILD_DIR=$HEAD_DIR/build


UTIL_DIR=$SOURCE_DIR/build_util

# GENERATOR="-G Xcode"

###############################################################################

function create_cmake_file( )
{
    # location of the source dir
    thissrcdir=$1
    # location of the build dir
    thisblddir=$2   
    # location of the install directory
    thisinstdir=$3

    inst_lib_dir=$thisinstdir/lib
    inst_include_dir=$thisinstdir/include
    inst_bin_dir=$thisinstdir/bin
    inst_etc_dir=$thisinstdir/etc
    inst_doc_dir=$thisinstdir/doc

    rm -rf $thisblddir
    mkdir -p $thisblddir
    cd $thisblddir

    cmake \
        $GENERATOR \
        -D inst_lib_dir=$inst_lib_dir \
    	-D inst_include_dir=$inst_include_dir \
    	-D inst_bin_dir=$inst_bin_dir \
        -D inst_etc_dir=$inst_etc_dir \
        -D inst_doc_dir=$inst_doc_dir \
        -D QTDIR=$QTDIR \
        -D BOOSTDIR=$BOOSTDIR \
        -D SCRIPT_DIR=$UTIL_DIR \
	    $thissrcdir 

}
###############################################################################


liblist="mylib"

liblist="myqtlib"

liblist="logviewer"

liblist="tree"

liblist=$PRJDIR



###############################################################################

for thislib in $liblist; do
    thissrcdir=$SOURCE_DIR/$thislib
    thisblddir=$BUILD_DIR/$thislib

    create_cmake_file $thissrcdir $thisblddir $installdir 

done


###############################################################################




