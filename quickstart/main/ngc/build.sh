#!/bin/bash

# example:
#   (*) ./build.sh 19.02-py3     10.0
#   (*) ./build.sh 20.03-tf1-py3 10.2
#   (*) ./build.sh 20.08-tf1-py3 11.0
#   (*) ./build.sh 21.05-tf1-py3 11.3

if [ "$#" -ne 2 ]; then
    echo "USAGE: <ngc-base-image-tag> <cuda-version>"
    exit 1
fi

if [ ! -d "./cifar-10" ]; then
    echo "Downloading CIFAR10 dataset"
    wget -nc https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
    tar zxf cifar-10-python.tar.gz
    mv cifar-10-batches-py cifar-10
    rm cifar-10-python.tar.gz
fi

docker build -f Dockerfile -t gcr.io/run-ai-demo/quickstart:cuda-$2 --build-arg ngc_image_tag=$1 --build-arg cuda=$2 .
