#!/bin/sh

if [ ! -d "./cifar-10" ]; then
    echo "Downloading CIFAR10 dataset"
    wget -nc https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
    tar zxf cifar-10-python.tar.gz
    mv cifar-10-batches-py cifar-10
    rm cifar-10-python.tar.gz
fi

tag=$1

docker build -f "${tag:+$tag.}Dockerfile" -t "runai.jfrog.io/demo/quickstart-distributed${tag:+:$tag}" .
