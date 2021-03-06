#!/bin/bash

: '

  Author: Lander Usategui lander.usategui@gmail.com
'

KERNEL_VERSION=$1

# Dependencies
apt-get update && apt-get install -y -qq --no-install-recommends \
apt-utils bc build-essential gcc-aarch64-linux-gnu git unzip \
libncurses5-dev libncursesw5-dev ca-certificates \
&& rm -rf /var/lib/apt/lists/*

if [ ${KERNEL_VERSION} == "4.9" ]; then
  echo "It will compile version 4.9.X."
  #Clone Linux source
  git clone -b rpi-4.9.y https://github.com/raspberrypi/linux

  cd linux
  # Checkout to 4.9.65
  git checkout 133e6ccf46f1704a4a680ef45565e970ac9a7f9c #URL: https://github.com/raspberrypi/linux/commit/133e6ccf46f1704a4a680ef45565e970ac9a7f9c

  #Copy config file with PREEMPT-RT option enabled
  mv /4.9-PREEMPT-RT_defconfig .config

  #Patch the Kernel with PREEMPT-RT patches
  gunzip -d /patch-4.9.65-rt57-rc2.patch.gz
  cat ../patch-4.9.65-rt57-rc2.patch | patch -p1

  #Necessary exports to compile
  export ARCH=arm64
  export CROSS_COMPILE=aarch64-linux-gnu-

  #Compile the kernel and modules
  make -j `getconf _NPROCESSORS_ONLN`
  mkdir 64_modules
  INSTALL_MOD_PATH=64_modules make modules_install

  #Remove symlinks
  rm -rf 64_modules/lib/modules/4.9.65-rt57-v8+/source
  rm -rf 64_modules/lib/modules/4.9.65-rt57-v8+/build

  #Create .tar.gz
  mkdir 64bits_kernel && cd 64bits_kernel
  mv /deploy .
  cp ../arch/arm64/boot/Image kernel8.img
  cp ../arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b.dtb .
  cp -r ../64_modules .
  cd .. && tar cvzvfp 64bits_kernel.tar.gz 64_bits_kernel

elif [ ${KERNEL_VERSION} == "4.14" ]; then
  echo "It will compile version 4.14.X."
  #Clone Linux source
  git clone -b rpi-4.14.y https://github.com/raspberrypi/linux

  cd linux
  # Checkout to 4.14.15
  git checkout a16134b082346b7e7c34f594a0763eafacdcea92 #URL: https://github.com/raspberrypi/linux/commit/a16134b082346b7e7c34f594a0763eafacdcea92
  #Copy config file with PREEMPT-RT option enabled
  mv /4.14-PREEMPT-RT_defconfig .config

  #Patch the Kernel with PREEMPT-RT patches
  gunzip -d /patch-4.14.15-rt13.patch.gz
  cat ../patch-4.14.15-rt13.patch | patch -p1

  #Necessary exports to compile
  export ARCH=arm64
  export CROSS_COMPILE=aarch64-linux-gnu-

  #Compile the kernel and modules
  make -j `getconf _NPROCESSORS_ONLN`
  mkdir 64_modules
  INSTALL_MOD_PATH=64_modules make modules_install

  #Remove symlinks
  rm -rf 64_modules/lib/modules/4.14.15-rt13-v8+/source
  rm -rf 64_modules/lib/modules/4.14.15-rt13-v8+/build

  #Create .tar.gz
  mkdir 64bits_kernel && cd 64bits_kernel
  mv /deploy .
  cp ../arch/arm64/boot/Image kernel8.img
  cp ../arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b.dtb .
  cp -r ../64_modules .
  cd .. && tar cvzvfp 64bits_kernel.tar.gz 64_bits_kernel

elif [ ${KERNEL_VERSION} == "4.19" ]; then

  echo "It will compile version 4.19.X."
  #Clone Linux source
  git clone -b rpi-4.19.y https://github.com/raspberrypi/linux

  cd linux
  # Checkout to 4.19.1
  git checkout 07a03b97b9ce2a6430344386eeab9b16283b893f #URL: https://github.com/raspberrypi/linux/commit/07a03b97b9ce2a6430344386eeab9b16283b893f

  #Patch the Kernel with PREEMPT-RT patches
  xz -d /patch-4.19-rt1.patch.xz
  cat ../patch-4.19-rt1.patch | patch -p1

  #Necessary exports to compile
  export ARCH=arm64
  export CROSS_COMPILE=aarch64-linux-gnu-

  #Compile the kernel and modules
  make -j `getconf _NPROCESSORS_ONLN`
  mkdir 64_modules
  INSTALL_MOD_PATH=64_modules make modules_install

else
  echo "No version found, remember, this script only can compile following versions: 4.9 and 4.14."
fi
