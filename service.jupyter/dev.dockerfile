#ARG BASE_CONTAINER=jupyter/base-notebook
ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER
 
ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

# Using CUDA in your Docker Container 
# https://medium.com/@adityathiruvengadam/cuda-docker-%EF%B8%8F-for-deep-learning-cab7c2be67f9
ENV PATH /usr/local/cuda/bin/:$PATH
ENV LD_LIBRARY_PATH /usr/local/cuda/lib:/usr/local/cuda/lib64
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
LABEL com.nvidia.volumes.needed="nvidia_driver"


SHELL ["/bin/bash", "-c"]

USER root
RUN apt-get -qq update;\
	apt-get -qq install --no-install-recommends gnupg;\
	wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - ;\
	echo "deb http://package.perforce.com/apt/ubuntu bionic release" > /etc/apt/sources.list.d/perforce.list;\
	apt-get -qq update;\
	apt-get -qq install --no-install-recommends\
	g++\
	gcc\
	gdb\
	gnupg\
	helix-cli\
	libc6-i386\
	make\
	netbase\
	netcat-openbsd\
	openssh-client\
	perl\
	python-pip\
	rsync\
	htop\
	;\
	apt-get -qq clean;\
	apt-get -qq autoremove;\
	rm -rf /var/lib/apt/lists/* /root/.cache;\
	usermod -aG sudo jovyan;\
	echo 'jovyan ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/jovyan

# Configure environment
ENV CONDA_DIR=/opt/conda \
  SHELL=/bin/bash \
  NB_USER=$NB_USER \
  NB_UID=$NB_UID \
  NB_GID=$NB_GID \
  LC_ALL=en_US.UTF-8 \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8
ENV PATH=$CONDA_DIR/bin:$PATH \
HOME=/home/$NB_USER

USER jovyan
RUN set -eux;\
	conda install\
	# nb_conda_kernels\
	ipywidgets\
	jupyterlab-git\
	nbdime\
	numexpr\
	plotly\
	psycopg2\
	;\
	nbdime extensions --enable;\
	jupyter serverextension enable --py jupyterlab_git;\
#
	jupyter labextension install\
	@jupyter-widgets/jupyterlab-manager\
	@jupyterlab/git\
	jupyterlab-plotly\
	plotlywidget\
	--no-build;\
	NODE_OPTIONS=--max-old-space-size=4096 jupyter lab build;

# RUN conda install -y nb_conda
# Create Conda ENV and add it to Jupyter	
RUN conda create --name tf_gpu_1_4 \
	-c anaconda \
	"cudnn" \
	"cudatoolkit" \
	"h5py" \
	"ipykernel" \
	"matplotlib<=3.0.3" \
	"numpy<1.16.7" \
	"pillow=4.3.0" \
	"python=3.6" \
	"scikit-image" \
	"scipy=1.2.1" \
	"tensorflow=1.4.*" \
	"tensorflow-gpu=1.4.*" \
	"keras-gpu"\
#	"tensorboard" \
	-y;\
	source activate tf_gpu_1_4;\
	python -m ipykernel install --user --name "tf_gpu_1_4" --display-name "Tensorflow GPU 1.4";\
	source deactivate;

RUN conda create --name tf_gpu_14 \
	-c anaconda \
#	"h5py" \
	"ipykernel" \
	"matplotlib<=3.0.3" \
	"numpy<1.16.7" \
	"pillow=4.3.0" \
	"python=3.6" \
	"scikit-image" \
	"scipy=1.2.1" \
#	"tensorflow=1.14.*" \
#	"tensorflow-gpu=1.14.*" \
#	"keras-gpu"\
#	"tensorboard" \
	-y;\
	source activate tf_gpu_14;\
	pip install tensorflow-gpu==1.14.*;\
	python -m ipykernel install --user --name "tf_gpu_14" --display-name "Tensorflow GPU 1.14";\
	source deactivate;

# USER root

# RUN conda install nb_conda_kernels;

COPY ./service.jupyter/demo /tmp/demo
# RUN bash /tmp/demo/install-demos.sh

USER jovyan


# Install Tensorflow

# conda update -n base conda

# https://github.com/CanDIG/CanDIGv2/tree/master/lib/jupyter


