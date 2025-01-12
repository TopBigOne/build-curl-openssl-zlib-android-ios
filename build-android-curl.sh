#!/bin/bash

source ./build-android-env.sh

ARCHIVE=curl-7.88.0.tar.xz

DIR=curl-7.88.0

INSTALL_DIR=$BUILD_DIR/curl

if [ -d $INSTALL_DIR ]; then
    rm -rf $INSTALL_DIR
fi

mkdir -p $INSTALL_DIR

if [ -d $DIR ];then
    rm -rf $DIR
fi

tar xzf $ARCHIVE

cd $DIR

# --with-zlib=$BUILD_DIR/zlib/$ANDROID_ARCH \
# --enable-shared \
function build() {
    export TARGET_HOST=$1
    export ANDROID_ARCH=$2
    export AR=$TOOLCHAIN/bin/llvm-ar
    export CC=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang
    export AS=$CC
    export CXX=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang++
    export LD=$TOOLCHAIN/bin/ld
    export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
    export STRIP=$TOOLCHAIN/bin/llvm-strip

    ./configure --host=$TARGET_HOST \
                --target=$TARGET_HOST \
                --prefix=$INSTALL_DIR/$ANDROID_ARCH \
                --with-openssl=$BUILD_DIR/openssl/$ANDROID_ARCH \
                --with-pic \
                --enable-static \

    make -j8
    make install
    make clean
}


build aarch64-linux-android arm64-v8a
build armv7a-linux-androideabi armeabi-v7a
#build i686-linux-android x86
#build x86_64-linux-android x86_64

cd ..

#rm -rf cd $DIR