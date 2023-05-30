# Working with DeepSpeed on top of RunAI

RunAI is a platform for running workloads on Kubernetes clusters. RunAI
is installed on a Kubernetes cluster as add-on and does not replace any
existing component of Kubernetes. Running workloads in RunAI is done
through multiple ways:

* Web UI Interface - RunAI has a dedicated UI for submitting workloads

* CLI - A tool for submitting workload into the cluster

* Kubernetes API - Creating workloads through Kubernetes YAMLs

When dedicated operator exists in the cluster, the RunAI platform can
integrate with them. For example, if the MPI Operator is installed in
the cluster, RunAI can create MPIJob. In such case, RunAI automatically
inject the parameters for running as RunAI workload (Project + Scheduler
fields in the YAML).

DeepSpeed is a tool for helping optimize Deep Learning workloads.

In the following article we are going to demonstrate how to run
distributed workload on Kubernetes using MPIJob that runs using
DeepSpeed.

## Prerequisites

In order to run DeepSpeed workload on RunAI cluster one needs the
following:

* Kubernetes Cluster version `1.21` or above

* RunAI Cluster version `2.9` or above

* Kubeflow MPIOperator version `v0.4.0` or above

Running with other version might work, however not tested in RunAI

## AI Workload - Cifar10

In this article we are going to train a `Cifar 10`, which is a dataset of
thousands of images, with image recognition model.

For more information about the `Cifar 10` model go to: [CIFAR-10 and
CIFAR-100 datasets
(toronto.edu)](https://www.cs.toronto.edu/~kriz/cifar.html)

Microsoft has released an examples of DeepSpeed training models which
can be found in the following repository: [microsoft/DeepSpeedExamples:
Example models using DeepSpeed
(github.com)](https://github.com/microsoft/DeepSpeedExamples)

We will use the `Cifar 10` model which can be found in `training/cifar`
directory. In this directory we can find the following relevant files:

* `cifar10_tutorial.py`&mdash;For running the train without DeepSpeed

* `cifar10_deepspeed.py`&mdash;For running the train with DeepSpeed

* `run_ds.sh`&mdash;Entrypoint for running the train

* `ds_config.json`&mdash;DeepSpeed configuration file

## Docker Image

In order to prepare our workload we need to create a docker image that
will be used as the image for the submittion command. We are running the
workload as MPIJob so the image should support distribute workload using
OpenMPI. In order to do that we need to make sure that the image have
SSH server for the workers, SSH Client for the launcher, and the model
files themself for the remote commands.

```cli

FROM deepspeed/deepspeed

WORKDIR /home/deepspeed

RUN git clone https://github.com/microsoft/DeepSpeedExamples.git

WORKDIR /home/deepspeed/DeepSpeedExamples/training/cifar

RUN pip install -r requirements.txt

RUN ssh-keygen -t rsa -N \"\" -f /home/deepspeed/.ssh/id_rsa

RUN cp /home/deepspeed/.ssh/id_rsa.pub
/home/deepspeed/.ssh/authorized_keys

RUN sudo chmod 644 /etc/ssh/\*

RUN sudo chmod 700 /home/deepspeed

RUN sudo chmod 700 /home/deepspeed/.ssh

RUN sudo mkdir /tmp

RUN sudo chmod 777 /tmp
```

This is the `Dockerfile` we will use.

As we can see:

1. We inherit from deepspeed/deepspeed as base image, for having the
    DeepSpeed tools available

2. We clone the https://github.com/microsoft/DeepSpeedExamples.git in
    order to have the model files in the image

3. We install the dependencies

4. We generate SSH Keys and set the appropriate permissions to the SSH
    keys

Building this image can be done with the following command:

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

This command run an MPI job with 2 processes (workers), each with 1 GPU,
and the entry point for the launcher is `sleep infinity` so we could
interactively get into the container and run the DeepSpeed command, as
can be shown in the following example.

One thing to notice regarding this demo is that usually DeepSpeed is
searching for the `hostfile` in `/job/hostfile` however MPIOperator is
injecting this file to `/etc/mpi/hostfile`.
