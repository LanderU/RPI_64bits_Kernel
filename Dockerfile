FROM ubuntu:16.04

MAINTAINER Lander Usategui lander.usategui@gmail.com

WORKDIR /

COPY compile.sh /
COPY patch-4.9.47-rt37.patch.gz /
COPY configFiles/PREEMPT-RT_defconfig /
COPY deploy /
RUN chmod +x compile.sh && ./compile.sh

CMD ["bash"]
