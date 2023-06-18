# DeepSpeed Integration with Run:ai

# Working with DeepSpeed on top of Run:ai

DeepSpeed is a deep learning optimization library for PyTorch designed to reduce computing power and memory use, and to train large distributed models with better parallelism on existing computer hardware. DeepSpeed is optimized for low latency, high throughput training. It also includes the Zero Redundancy Optimizer (ZeRO) for training models with 1 trillion or more parameters. Other features include mixed precision training, single-GPU, multi-GPU, multi-node training, and custom model parallelism.

This article describes how to run a distributed workload on Kubernetes using an MPIJob with
DeepSpeed.

## Prerequisites

Prerequisites to run DeepSpeed on a Run:ai cluster:

* Kubernetes Cluster version `1.21` or later

* Run:ai Cluster version `2.9` or later

* Kubeflow MPIOperator version `v0.4.0` or later

!!! Note
    Earlier versions may work but weren't tested.

## AI Workload - Cifar10

This article uses the  `Cifar 10` dataset to show how to work with DeepSpeed on Run:ai. This dataset contains thousands of images and an image recognition model. For more information about the `Cifar 10` model go to: [CIFAR-10 and CIFAR-100 datasets(toronto.edu)](https://www.cs.toronto.edu/~kriz/cifar.html)

Microsoft has released an examples of DeepSpeed training models in the following repository: [microsoft/DeepSpeedExamples:
Example models using DeepSpeed(github.com)](https://github.com/microsoft/DeepSpeedExamples)

We will use the `Cifar 10` model which can be found in `training/cifar`
directory. In this directory we can find the following relevant files:

* `cifar10_tutorial.py`&mdash;run the training without DeepSpeed.

* `cifar10_deepspeed.py`&mdash;run the training with DeepSpeed.

* `run_ds.sh`&mdash;Entrypoint for running the training.

* `ds_config.json`&mdash;DeepSpeed configuration file.

## Docker Image

A Docker image needs to be prepared so that the workload can be submitted. It will run a an MPIJob that supports distributed workloads using OpenMPI. The image also needs to have an SSH server for the workers, an SSH client for the launcher, and the model files for the remote commands.

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

After completing the configuration, use the following command to build the image:

```cli
docker build . -t gcr.io/run-ai-lab/user/deepspeed
```

## Interactive Workflow

Use the *UI*, *CLI*, or the *API* to run the workload.

Using the *CLI*:

```
runai submit-mpi \--processes 2 -i
gcr.io/run-ai-lab/user/deepspeed-example -g 1 \--command -p team-a \--
sleep infinity
```

This command runs an MPI job with 2 processes (workers), each with 1 GPU.
The entry point for the launcher is `sleep infinity` and provides
access to the container.

In the *CLI*, run the DeepSpeed command as follows:

```
deepspeed --hostfile /etc/mpi/hostfile cifar10_deepspeed.py --deepspeed --deepspeed_config ds_config.json
```

!!!Note
    Typically DeepSpeed looks for the `hostfile` in `/job/hostfile`. However, MPIOperator is
puts the file in `/etc/mpi/hostfile`.
