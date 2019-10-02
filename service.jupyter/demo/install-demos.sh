#!/usr/bin/env bash

set -x

cd /tmp/demo

# git clone https://github.com/ericmjl/bayesian-stats-modelling-tutorial

#pushd bayesian-stats-modelling-tutorial
# conda env create --clone base -f tensorflow_1.4.yml

conda env create -f tensorflow_1.4.yml
source activate tensorflow_1_4
python -m ipykernel install --user --name "tensorflow_1_4" --display-name "Tensorflow 1.4"
source deactivate

#conda env create -f tensorflow_1.4_gpu.yml
#source activate tensorflow_1_4_gpu
#python -m ipykernel install --user --name "tensorflow_1_4_gpu" --display-name "Tensorflow GPU 1.4"
#source deactivate

conda env create -f tensorflow_1.14.yml
source activate tensorflow_1_14
python -m ipykernel install --user --name "tensorflow_1_14" --display-name "Tensorflow 1.14"
source deactivate

#conda env create -f tensorflow_1.14_gpu.yml
#source activate tensorflow_1_14_gpu
#python -m ipykernel install --user --name "tensorflow_1_14_gpu" --display-name "Tensorflow GPU 1.14"
#source deactivate
# popd
# cd /home/jovyan/work
# git clone https://github.com/IslamAlam/DSAC.git 


# ipython-kernel-install [-h] [--user] [--name NAME]                       
#                               [--display-name DISPLAY_NAME]                     
#                               [--profile PROFILE] [--prefix PREFIX]             
#                               [--sys-prefix]
