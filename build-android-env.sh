#!/bin/bash

export ANDROID_NDK_ROOT=/Users/dev/Documents/Android_Env/Sdk/ndk/25.2.9519653

HOST_TAG=darwin-x86_64

MIN_SDK_VERSION=23

TOOLCHAIN=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/$HOST_TAG

PATH=$TOOLCHAIN/bin:$PATH

BUILD_DIR=$PWD/build/android