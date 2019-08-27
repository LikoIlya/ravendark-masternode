ARG MNPRIVKEY
ARG MNIP

FROM ubuntu:trusty

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y \
  g++ \
  libzmq3-dev \
  libzmq3-dbg \
  libzmq3 \
  make \
  python \
  software-properties-common \
  curl \
  build-essential \
  libssl-dev \
  wget \
  libtool \
  autotools-dev \
  automake \
  pkg-config \
  libevent-dev \
  bsdmainutils \
  git

RUN add-apt-repository ppa:bitcoin/bitcoin -y
RUN apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev

RUN apt-get install -y \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-chrono-dev \
  libboost-program-options-dev \
  libboost-test-dev \
  libboost-thread-dev

ENV VERSION=0.3.2

WORKDIR /ravendark
COPY . .

RUN ./autogen.sh && \
 ./configure --without-gui && make

RUN ln -sf /ravendark/src/ravendarkd /usr/bin/ravendarkd
RUN ln -sf /ravendark/src/ravendark-cli /usr/bin/ravendark-cli

WORKDIR /ravendark/src

RUN apt-get autoclean && \
  apt-get autoremove -y

WORKDIR /ravendark
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x entrypoint.sh

EXPOSE 17207 7207 17107 16666 16665 6665 6666

VOLUME /root/.ravendarkcore
COPY ravendark.conf /root/.ravendarkcore/ravendark.conf
RUN sed 's/<MNPRIVKEY>/${MNPRIVKEY}/g' /root/.ravendarkcore/ravendark.conf
RUN sed 's/<MNIP>/${MNIP}/g' /root/.ravendarkcore/ravendark.conf

ENTRYPOINT ["./entrypoint.sh"]

