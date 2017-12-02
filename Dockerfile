FROM ubuntu:16.04

MAINTAINER Lander Usategui lander.usategui@gmail.com

WORKDIR /

COPY compile.sh /
COPY patch-4.9.65-rt57-rc2.patch.gz /
COPY configFiles/PREEMPT-RT_defconfig /
COPY deploy /
RUN chmod +x compile.sh && ./compile.sh

CMD ["bash"]
