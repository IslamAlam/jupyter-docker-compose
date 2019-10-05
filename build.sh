#!/bin/sh
# to run it 
# chmod +x build.sh
docker-compose up --build -d
# docker-compose up -d --build
# find / -xdev 2>/dev/null -name "tensorflow_1_4"
# nohup ./build.sh >> my.log 2>>&1 &
# nohup ./build.sh > my.log 2>&1 &

# curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key --keyring /etc/apt/trusted.gpg.d/nvidia-docker.gpg add -

# 
# 
# Also consider removing all the unused Images.
# 
# First get rid of the <none> images (those are sometimes generated while building an image and if for any reason the image building was interrupted, they stay there).
# 
# here's a nice script I use to remove them
# 
# docker rmi $(docker images | grep '^<none>' | awk '{print $3}')