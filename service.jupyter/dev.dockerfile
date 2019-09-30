#ARG BASE_CONTAINER=jupyter/base-notebook
ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER
 
ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

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

# USER root

# RUN conda install nb_conda_kernels;

COPY ./service.jupyter/demo /tmp/demo
RUN bash /tmp/demo/install-demos.sh

USER jovyan


# Install Tensorflow

# conda update -n base conda

# https://github.com/CanDIG/CanDIGv2/tree/master/lib/jupyter


