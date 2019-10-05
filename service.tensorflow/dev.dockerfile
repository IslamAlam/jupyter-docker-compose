FROM tensorflow/tensorflow:1.14.0-gpu-py3-jupyter

MAINTAINER martin.ludvik@gmail.com

RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    wget \
    aria2 \
    python-pil \
    python-lxml \
    python-tk \
    python-opencv \
    python3-setuptools \
    python3-tk

RUN pip install \
    Cython \
    contextlib2 \
    jupyter \
    setuptools \
    matplotlib<=3.0.3 \
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
    scipy=1.2.1 \
    pandas \
    statsmodels \
    sklearn \
    pandas \
    statsmodels \
    seaborn \
    keras-tcn \
    pillow=4.3.0 \
    keras-rectified-adam

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



# without those env vars installing unittest_data_provider broke
ENV LC_ALL C.UTF-8
ENV LC_CTYPE C.UTF-8
ENV LANG C.UTF-8
