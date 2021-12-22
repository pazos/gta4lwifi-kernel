#!/bin/bash

export ARCH=arm64
[ -d out ] || mkdir out

RELEASE=SM-T500-GSI-kernel.zip
NAME=SM-T500-GSI
FW_VERSION=T500XXU3BUJ1

BUILD_CROSS_COMPILE=$(pwd)/toolchain/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
KERNEL_LLVM_BIN=$(pwd)/toolchain/llvm-arm-toolchain-ship/10.0/bin/clang
CLANG_TRIPLE=aarch64-linux-gnu-
KERNEL_MAKE_ENV="LOCALVERSION=-T500XXU3BUJ1"
TC="ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE"

case $1 in
	no-watchdog)
		RELEASE=$NAME-no-watchdog.zip
		DEFCONFIG=vendor/gta4lwifi_aosp_nowatchdog_defconfig
		ID="-NO-WATCHDOG-$FW_VERSION"
		;;
	stock)
		RELEASE=$NAME-stock.zip
		DEFCONFIG=vendor/gta4lwifi_eur_open_defconfig
		ID="-STOCK-$FW_VERSION"
		;;
	* )
		RELEASE=$NAME.zip
		DEFCONFIG=vendor/gta4lwifi_aosp_defconfig
		ID="-$FW_VERSION"
		;;
esac

echo "Building out/$RELEASE"
make -j8 -C $(pwd) O=$(pwd)/out LOCALVERSION=$ID $TC $DEFCONFIG
make -j8 -C $(pwd) O=$(pwd)/out LOCALVERSION=$ID $TC
rm -rf out/dist out/*.zip
mkdir out/dist
cp $(pwd)/out/arch/arm64/boot/Image $(pwd)/out/dist
cp -pR $(pwd)/vendor/anykernel3/* $(pwd)/out/dist
(cd out/dist && zip -r9 ../$RELEASE .)
