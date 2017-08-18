FROM ubuntu:14.04

RUN export DEBIAN_FRONTEND=noninteractive && \
        apt-get update -y && \
        apt-get install -y software-properties-common && \
        add-apt-repository ppa:bitcoin/bitcoin && \
        apt-get update && \
        apt-get install -y libdb5.3-dev libdb5.3++-dev && \
        apt-get install -y libminiupnpc-dev libgmp10 libcurl3-gnutls && \
        apt-get install -y bitcoind && \
        apt-get remove --purge -y software-properties-common && \
        apt-get autoremove -y && \
        apt-get clean

WORKDIR /root

RUN mkdir dogecoin && \
    mkdir dogecoin/data

ADD app/ dogecoin/app/
ADD start.sh dogecoin/app/start.sh
RUN chmod -R 700 dogecoin/app/*
ADD dogecoin_data/dogecoin.conf dogecoin/data/dogecoin.conf

WORKDIR /root/dogecoin/app

EXPOSE 64222 64223

CMD ["/bin/bash"]
