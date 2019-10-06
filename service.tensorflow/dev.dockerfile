FROM tensorflow/tensorflow:1.14.0-gpu-py3-jupyter

MAINTAINER is3mansour@gmail.com

# ENV NVIDIA_VISIBLE_DEVICES=all
# ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility,video
#ENV PATH /usr/local/cuda/bin/:$PATH
#ENV LD_LIBRARY_PATH /usr/local/cuda/lib:/usr/local/cuda/lib64


ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
#ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility,video,graphics,display
#ENV NVIDIA_REQUIRE_CUDA="cuda>=9.0"
#LABEL com.nvidia.volumes.needed="nvidia_driver"

RUN nvidia-smi -a
#  install tzdata 
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive 

# without those env vars installing unittest_data_provider broke

# Configure environment
ENV CONDA_DIR=/opt/conda \
#   SHELL=/bin/bash \
#    NB_USER=$NB_USER \
#    NB_UID=$NB_UID \
#    NB_GID=$NB_GID \
#    LC_ALL=en_US.UTF-8 \
    LC_CTYPE=C.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
#ENV PATH=$CONDA_DIR/bin:$PATH \
#    HOME=/home/$NB_USER

#SHELL ["/bin/bash", "-c"]

USER root
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    wget \
    aria2 \
    python-pip\
    python-pil \
    python-lxml \
    python-tk \
    python-opencv \
    python3-setuptools \
    python3-tk\
    htop\
	;\
	apt-get -qq clean;\
	apt-get -qq autoremove;\
	rm -rf /var/lib/apt/lists/* /root/.cache;
	#usermod -aG sudo jovyan;\
	#echo 'jovyan ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/jovyan

#RUN pip install --upgrade pip
RUN pip install \
    Cython \
    contextlib2 \
    jupyter \
    setuptools \
    matplotlib==3.0.3 \
    python_utils \
    pylint \
    pylint_runner \
    progressbar2 \
    scikit-image \
    fastcache \
    unittest_data_provider \
    pytest \
    pytest-cov\
    numpy \
    pandas \
    sklearn \
    scipy==1.2.1 \
    pandas \
    statsmodels \
    sklearn \
    pandas \
    statsmodels \
    seaborn \
    keras-tcn \
    pillow==4.3.0 \
    keras-rectified-adam



#RUN nvidia-smi

#################################
# initializing GPU 
#################################

RUN mkdir /tmp/sample

WORKDIR /tmp/sample

# exercise GPU 
RUN printf "import tensorflow as tf;mnist = tf.keras.datasets.mnist;(x_train, y_train),(x_test, y_test) = mnist.load_data();x_train, x_test = x_train / 255.0, x_test / 255.0;model = tf.keras.models.Sequential([tf.keras.layers.Flatten(),tf.keras.layers.Dense(512, activation=tf.nn.relu),tf.keras.layers.Dropout(0.2),tf.keras.layers.Dense(10, activation=tf.nn.softmax)]);model.compile(optimizer='adam',loss='sparse_categorical_crossentropy',metrics=['accuracy']);model.fit(x_train, y_train, epochs=5);model.evaluate(x_test, y_test)" > sample.py
RUN python3 sample.py

# clean
RUN rm -r /tmp/sample




