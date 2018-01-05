FROM ubuntu:16.04

MAINTAINER Lander Usategui lander.usategui@gmail.com

WORKDIR /

ARG KERNEL_VERSION=
COPY compile.sh /
COPY patch-4.9.65-rt57-rc2.patch.gz /
COPY patch-4.14.8-rt9.patch.gz /
COPY configFiles/4.9-PREEMPT-RT_defconfig /
COPY configFiles/4.14-PREEMPT-RT_defconfig /
COPY deploy /
RUN chmod +x compile.sh && ./compile.sh ${KERNEL_VERSION}

CMD ["bash"]
