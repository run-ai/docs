# Working with DeepSpeed on top of RunAI

DeepSpeed is a deep learning optimization library for PyTorch designed to reduce computing power and memory use, and to train large distributed models with better parallelism on existing computer hardware. DeepSpeed is optimized for low latency, high throughput training and it includes the Zero Redundancy Optimizer (ZeRO) for training models with 1 trillion or more parameters. Features include mixed precision training, single-GPU, multi-GPU, and multi-node training as well as custom model parallelism.

This article will show you how to run
 a distributed workload on Kubernetes using an MPIJob with
DeepSpeed.

## Prerequisites

The following prerequisites are needed to run DeepSpeed on a RunAI cluster:

* Kubernetes Cluster version `1.21` or later

* RunAI Cluster version `2.9` or later

* Kubeflow MPIOperator version `v0.4.0` or later

!!! Note
    Earlier versions may work but have not tested.

## AI Workload - Cifar10

This article will use `Cifar 10`, which is a dataset that contains thousands of images and an image recognition model. For more information about the `Cifar 10` model go to: [CIFAR-10 and
CIFAR-100 datasets(toronto.edu)](https://www.cs.toronto.edu/~kriz/cifar.html)

Microsoft has released an examples of DeepSpeed training models in the following repository: [microsoft/DeepSpeedExamples:
Example models using DeepSpeed(github.com)](https://github.com/microsoft/DeepSpeedExamples)

We will use the `Cifar 10` model which can be found in `training/cifar`
directory. In this directory we can find the following relevant files:

* `cifar10_tutorial.py`&mdash;For running the train without DeepSpeed

* `cifar10_deepspeed.py`&mdash;For running the train with DeepSpeed

* `run_ds.sh`&mdash;Entrypoint for running the train

* `ds_config.json`&mdash;DeepSpeed configuration file

## Docker Image

A Docker image needs to be prepared so that the workload can be submitted. It will run a an MPIJob and needs to support distributed workloads using OpenMPI.
The image needs to have SSH serveer for the workers, SSH client for the launcher, and the model files for the remote commands.

To create the Docker image:

```console

FROM deepspeed/deepspeed

WORKDIR /home/deepspeed        #inherit from deepspeed/deepspeed as base image, for having the DeepSpeed tools available

RUN git clone https://github.com/microsoft/DeepSpeedExamples.git #imports the model files to the image

WORKDIR /home/deepspeed/DeepSpeedExamples/training/cifar

RUN pip install -r requirements.txt #install dependencies

RUN ssh-keygen -t rsa -N \"\" -f /home/deepspeed/.ssh/id_rsa #generate SSH keys

RUN cp /home/deepspeed/.ssh/id_rsa.pub
/home/deepspeed/.ssh/authorized_keys

RUN sudo chmod 644 /etc/ssh/\*

RUN sudo chmod 700 /home/deepspeed

RUN sudo chmod 700 /home/deepspeed/.ssh

RUN sudo mkdir /tmp

RUN sudo chmod 777 /tmp
```

After completing the configuration, the following command will build the image:

```cli
docker build . -t gcr.io/run-ai-lab/omer/deepspeed
```

## Interactive Workflow

Running this workload can be done through the UI / CLI / API. In this
example we will run the image with the CLI:

```cli
runai submit-mpi \--processes 2 -i
gcr.io/run-ai-lab/omer/deepspeed-example -g 1 \--command -p team-a \--
sleep infinity
```

This command run an MPI job with 2 processes (workers), each with 1 GPU.
The entry point for the launcher is `sleep infinity` providing
access to the container.

Run the DeepSpeed command as follows:

```dotnetcli
deepspeed --hostfile /etc/mpi/hostfile cifar10_deepspeed.py --deepspeed --deepspeed_config ds_config.json
```

!!!Note
    Typically DeepSpeed looks for the `hostfile` in `/job/hostfile`. However, MPIOperator is
injecting this file to `/etc/mpi/hostfile`.
