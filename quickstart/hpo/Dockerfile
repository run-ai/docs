FROM tensorflow/tensorflow:1.15.0-gpu-py3

# Install Keras
RUN pip install Keras==2.2.4

# Copy CIFAR10 dataset (both extracted and non-extracted files)
COPY ./cifar-10-batches-py.tar.gz /root/.keras/datasets/cifar-10-batches-py.tar.gz
COPY ./cifar-10-batches-py /root/.keras/datasets/cifar-10-batches-py

# Install the Run:AI Python library and its dependencies
RUN pip install runai coloredlogs pyyaml

RUN mkdir /workload
COPY ./main.py /workload/

WORKDIR /workload
ENTRYPOINT ["python", "main.py", "/nfs"]
