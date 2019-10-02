#!/bin/sh
# to run it 
# chmod +x build.sh
docker-compose up --build
# docker-compose up -d --build
# find / -xdev 2>/dev/null -name "tensorflow_1_4"
# nohup ./build.sh >> my.log 2>>&1 &
# nohup ./build.sh > my.log 2>&1 &

# curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key --keyring /etc/apt/trusted.gpg.d/nvidia-docker.gpg add -

