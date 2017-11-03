#!/bin/bash

: '

  Author: Lander Usategui lander.usategui@gmail.com
'

# Dependencies
apt-get update && apt-get install -y -qq --no-install-recommends \
apt-utils bc build-essential gcc-aarch64-linux-gnu git unzip \
libncurses5-dev libncursesw5-dev ca-certificates \
&& rm -rf /var/lib/apt/lists/*

#Clone Linux source
git clone --single-branch -b rpi-4.9.y https://github.com/raspberrypi/linux

cd linux
# Checkout to 4.9.47
git checkout 458ca52f1564938c158d271f45bce0bc6ede2b3f #URL: https://github.com/raspberrypi/linux/commit/458ca52f1564938c158d271f45bce0bc6ede2b3f

#Copy config file with PREEMPT-RT option enabled
mv /PREEMPT-RT_defconfig .config

#Patch the Kernel with PREEMPT-RT patches
gunzip -d /patch-4.9.47-rt37.patch.gz
cat ../patch-4.9.47-rt37.patch | patch -p1

#Necessary exports to compile
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

#Compile the kernel and modules
make -j 2
mkdir 64_modules
INSTALL_MOD_PATH=64_modules make modules_install

# #Remove symlinks
rm -rf 64_modules/lib/modules/4.9.47-rt37-v8+/source
rm -rf 64_modules/lib/modules/4.9.47-rt37-v8+/build

# #Create .tar.gz
# mkdir 64bits_kernel
# mv /deploy .
