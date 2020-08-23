#!/bin/sh

if [ ! -f "./cifar-10-batches-py.tar.gz" ]; then
    echo "Downloading CIFAR10 dataset"
    wget -nc https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz -O cifar-10-batches-py.tar.gz
fi

if [ ! -d "./cifar-10-batches-py" ]; then
    echo "Extracting CIFAR10 dataset"
    tar zxf cifar-10-batches-py.tar.gz
fi

docker build -f Dockerfile -t gcr.io/run-ai-demo/quickstart-hpo .
