#!/bin/sh
# to run it 
# chmod +x build.sh
docker rmi $(docker images | grep '^<none>' | awk '{print $3}')


nohup docker-compose up --build -d > start_docker.log 2>&1 &

# docker-compose up --build -d

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

# To delete volumes currently not being used by a running or stopped container:
# docker system prune --all --force --volumes

# 

#     $ sudo find /var/lib/docker/ -maxdepth 1 -mindepth 1 | xargs sudo du -sch
# 
# This should give you an idea as to what is taking up space, for example:
# 
#     4.0K    /var/lib/docker/repositories-aufs
#     56.0M   /var/lib/docker/graph
#     8.0K    /var/lib/docker/trust
#     14.7M   /var/lib/docker/init
#     104.0K  /var/lib/docker/.migration-v1-images.json
#     6.1G    /var/lib/docker/aufs
#     156.0K  /var/lib/docker/containers
#     24.3M   /var/lib/docker/image
#     272.9M  /var/lib/docker/tmp
#     1.6G    /var/lib/docker/volumes
#     108.0K  /var/lib/docker/network
#     152.0K  /var/lib/docker/linkgraph.db
#     230.5M  /var/lib/docker/vfs
#     0   /var/lib/docker/.migration-v1-tags
#     8.3G    total
# 
# ### Resolution
# 
# To clean up images, try removing all images that aren't currently in use:
# 
#     $ docker images -aq -f 'dangling=true' | xargs docker rmi
# 
# You may still have volumes to worry about. To clean those up:
# 
#     $ docker volume ls -q -f 'dangling=true' | xargs docker volume rm


