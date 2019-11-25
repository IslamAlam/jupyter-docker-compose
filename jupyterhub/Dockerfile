# For the latest tag, see: https://hub.docker.com/r/jupyter/datascience-notebook/tags/
FROM jupyter/datascience-notebook:latest

ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"


# GPU powered ML
# ----------------------------------------
RUN conda install -c conda-forge --yes --quiet \
    tensorflow-gpu \
    cudatoolkit=9.2 \
    && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER \
    ;

SHELL ["/bin/bash", "-c"]


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

# Install tools
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

# Install tools for Jupyterlab 
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


RUN conda create --name tf_1_14  -c conda-forge --yes --quiet \
    "matplotlib<=3.0.3" \
    "numpy<1.16.7" \
    "scipy<=1.2.1" \
    "pillow<=4.3.0" \
    "scikit-image" \
    python=3.6\
    tensorflow-gpu \
    cudatoolkit=9.2 \
    ipykernel \
    ;\
	source activate tf_1_14;\
	python -m ipykernel install --user --name "tf_1_14" --display-name "Tensorflow GPU 1.14";\
	source deactivate;


# Allow drivers installed by the nvidia-driver-installer to be located
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/nvidia/lib64
# Also, utilities like `nvidia-smi` are installed here
ENV PATH=${PATH}:/usr/local/nvidia/bin

# RUN nvidia-smi

#################################
# initializing GPU 
#################################

RUN mkdir /tmp/sample

WORKDIR /tmp/sample


RUN /bin/bash -c "source activate"

# exercise GPU 
RUN printf "import tensorflow as tf;mnist = tf.keras.datasets.mnist;(x_train, y_train),(x_test, y_test) = mnist.load_data();x_train, x_test = x_train / 255.0, x_test / 255.0;model = tf.keras.models.Sequential([tf.keras.layers.Flatten(),tf.keras.layers.Dense(512, activation=tf.nn.relu),tf.keras.layers.Dropout(0.2),tf.keras.layers.Dense(10, activation=tf.nn.softmax)]);model.compile(optimizer='adam',loss='sparse_categorical_crossentropy',metrics=['accuracy']);model.fit(x_train, y_train, epochs=5);model.evaluate(x_test, y_test)" > sample.py
# RUN python3 sample.py
CMD [ "python", "sample.py" ]

# clean
RUN rm -r /tmp/sample

USER jovyan
WORKDIR $HOME
