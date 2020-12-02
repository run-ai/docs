#!/bin/sh

if [ ! -d "./cifar-10-batches-py" ]; then
    echo "Downloading CIFAR10 dataset"
    wget -nc https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
    tar zxf cifar-10-python.tar.gz
    rm cifar-10-python.tar.gz
fi

docker build -f Dockerfile -t gcr.io/run-ai-demo/quickstart-elasticity-pytorch .
