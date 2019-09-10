#!/bin/bash

usage ()
{
  echo "$(basename "$0")"' -m <masternode priv key> -a <IP address>'
  exit
}

while [ "$1" != "" ]; do
case $1 in
        -h )           usage
                       exit
                       ;;
        -m )           shift
                       MNKEY=$1
                       ;;
        -a )           shift
                       ADDRESS=$1
                       ;;
        * )            QUERY=$1
    esac
    shift
done

# extra validation suggested by @technosaurus
if [ "$MNKEY" = "" ]
then
    echo "MNKEY"
    echo "$MNKEY"
    usage
fi
if [ "$ADDRESS" = "" ]
then
    echo "ADDRESS"
    usage
fi


sudo apt-get update && \
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common vim && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
sudo apt-get update && sudo apt-get install -y docker-ce

sudo dd if=/dev/zero of=swapfile bs=1M count=3000 && \
sudo mkswap swapfile && \
sudo chmod 0600 swapfile && \
sudo swapon swapfile

sudo docker build --build-arg MNPRIVKEY="$MNKEY" --build-arg MNIP="$ADDRESS" -t ravendark-mn:latest .
sudo docker run -p 80:80 -p 443:443 -p 16665:16665 -p 16666:16666 -p 6666:6666 -p 17207:17207 -p 7207:7207 -p 17107:17107 -p 6665:6665 -d --name ravendark-mn ravendark-mn:latest