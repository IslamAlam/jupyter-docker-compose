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
conda update -n base conda
conda create --name tf_gpu -c anaconda tensorflow-gpu=1.4 ipykernel scipy=1.2.1 matplotlib pillow scikit-image scikit-learn
conda install -c anaconda numpy=1.16.5 tensorflow-gpu=1.4 ipykernel scipy=1.2.1 matplotlib pillow scikit-image scikit-learn 


cloudpickle	0.6.1
html5lib	0.9999999
imageio	2.4.1
intel-openmp	2019.0
ipykernel	4.6.1
ipython	5.5.0
matplotlib	3.0.3
mkl	2019.0
networkx	2.3
olefile	0.46
pillow	4.3.0
protobuf	3.7.1
pygments	2.1.3
python-dateutil	2.5.3
pytz	2018.9
pyzmq	17.0.0
tensorflow-tensorboard	0.4.0
tornado	4.5.3

