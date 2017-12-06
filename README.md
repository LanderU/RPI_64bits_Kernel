# RPI_64bits_Kernel

The idea behind this repository is to try to reproduce the work of the following [link](https://www.osadl.org/Latency-plot-of-system-in-rack-7-slot.qa-latencyplot-r7s3.0.html?shadow=1).

## Prerequisites

* git
* docker

## How to build it?

### 4.9

```
git clone https://github.com/LanderU/RPI_64bits_Kernel
cd RPI_64bits_Kernel
docker build --build-arg KERNEL_VERSION=4.9 -t kernel4.9 .
```

### 4.14

```
git clone https://github.com/LanderU/RPI_64bits_Kernel
cd RPI_64bits_Kernel
docker build --build-arg KERNEL_VERSION=4.14 -t kernel4.14 .
```
