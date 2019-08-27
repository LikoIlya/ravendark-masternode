#!/bin/bash

sudo apt-get update && \
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common vim && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
sudo apt-get update && sudo apt-get install -y docker-ce

sudo dd if=/dev/zero of=swapfile bs=1M count=3000 && \
sudo mkswap swapfile && \
sudo chmod 0600 swapfile && \
sudo swapon swapfile

sudo docker build --build-arg MNPRIVKEY="$1" --build-arg MNIP="$2" -t ravendark-mn:latest .
sudo docker run -p 16665:16665 -p 16666:16666 -p 6666:6666 -p 17207:17207 -p 7207:7207 -p 17107:17107 -p 6665:6665 -d --name ravendark-mn ravendark-mn:latest