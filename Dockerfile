FROM ubuntu:trusty

ARG MNPRIVKEY
ARG MNIP

ENV PRIVKEY=${MNPRIVKEY}
ENV IP=${MNIP}

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

RUN mkdir /ravendark

# If you want to build from source
# RUN git clone https://github.com/konchunas/ravendark.git /ravendark
# ENV VERSION=0.3.2
# WORKDIR /ravendark
# COPY . .
# RUN ./autogen.sh && \
#   ./configure --without-gui && make -j4
# RUN ln -sf /ravendark/src/ravendarkd /usr/bin/ravendarkd
# RUN ln -sf /ravendark/src/ravendark-cli /usr/bin/ravendark-cli


# If you want to run binaries
RUN git clone https://gitlab.com/LikoIlya/raven-bin.git /ravendark
RUN ln -sf /ravendark/ravendarkd /usr/bin/ravendarkd
RUN ln -sf /ravendark/ravendark-cli /usr/bin/ravendark-cli

EXPOSE 17207 7207 17107 16666 16665 6665 6666

COPY ravendark.conf /root/.ravendarkcore/ravendark.conf
RUN sed -i 's/<MNPRIVKEY>/'$PRIVKEY'/g' /root/.ravendarkcore/ravendark.conf
RUN sed -i 's/<MNIP>/'$IP'/g' /root/.ravendarkcore/ravendark.conf 

COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]

