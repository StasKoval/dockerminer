#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM		ubuntu:14.04
ENV v=0.0.2
#MAINTAINER	Guillaume J. Charmes <guillaume@charmes.net>

RUN		apt-get update -qq

RUN		apt-get install -qqy gcc build-essential automake
RUN		apt-get install -qqy libssl-dev libcurl4-openssl-dev libjansson-dev
RUN		apt-get install -qqy git libboost-dev libboost-system-dev  libboost-thread-dev
RUN		apt-get install -qqy make

RUN		git clone https://github.com/StasKoval/dockerminer.git

RUN		cd dockerminer && ./autogen.sh
RUN		cd dockerminer && ./configure CFLAGS="-O3"
RUN		cd dockerminer && make

WORKDIR		/dockerminer
ENTRYPOINT	["./cpuminer"]
