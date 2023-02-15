# Best Practice: From Bare Metal to Docker Images

## Introduction

Some Researchers do data science on _bare metal_. The term bare-metal relates to connecting to a server and working directly on its operating system and disks.

This is the fastest way to start working, but it introduces problems when the data science organization scales:

*   More Researchers mean that the machine resources need to be efficiently shared
*   Researchers need to collaborate and share data, code, and results

To overcome that, people working on bare-metal typically write scripts to gather data, code as well as code dependencies. This soon becomes an overwhelming task.

## Why Use Docker Images?
Docker images and _containerization_ in general provide a level of abstraction which, by large, frees developers and Researchers from the mundane tasks of _setting up an environment_. The image is an operating system by itself and thus the 'environment' is by large, a part of the image.

When a docker image is instantiated, it creates a _container_. A container is the running manifestation of a docker image.

## Moving a Data Science Environment to Docker

A data science environment typically includes:

<li>Training data</li>
<li>Machine Learning (ML) code and inputs</li>
<li>Libraries: Code dependencies that must be installed before the ML code can be run</li>

### Training data

Training data is usually significantly large (from several Gigabytes to Petabytes) and is read-only in nature. Thus, training data is typically left outside of the docker image. Instead, the data is _mounted_ onto the image when it is instantiated. Mounting a volume allows the code within the container to access the data as though it was within a directory on the local file system.

The best practice is to store the training data on a shared file system. This allows the data to be accessed uniformly on whichever machine the Researcher is currently using, allowing the Researcher to easily migrate between machines. 

Organizations without a shared file system typically write scripts to copy data from machine to machine.

### Machine Learning Code and Inputs

As a rule, code needs to be saved and versioned in a __code repository__.

There are two alternative practices:

*   The code resides in the image and is being periodically pulled from the repository. This practice requires building a new container image each time a change is introduced to the code.
*   When a shared file system exists, the code can reside outside the image on a shared disk and mounted via a volume onto the container. 

Both practices are valid.

Inputs to machine learning models and artifacts of training sessions, like model checkpoints, are also better stored in and loaded from a shared file system.

### Code Dependencies

Any code has code dependencies. These libraries must be installed for the code to run. As the code is changing, so do the dependencies.

ML Code is typically python and python dependencies are typically declared together in a single ``requirements.txt`` file which is saved together with the code.

The best practice is to have your docker startup script (see below) run this file using ``pip install -r requirements.txt``. This allows the flexibility of adding and removing code dependencies dynamically.

## ML Lifecycle: Build and Train

Deep learning workloads can be divided into two generic types:

<li>Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter Notebook, remote PyCharm, or similar and accesses GPU resources directly. Build workloads are typically meant for debugging and development sessions.
</li>
<li>Unattended "training" sessions. Training is characterized by a machine learning run that has a start and a finish. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the data scientist can examine the results. A Training session can take from a few minutes to a couple of days. It can be interrupted in the middle and later restored (though the data scientist should save checkpoints for that purpose). Training workloads typically utilize large percentages of the GPU and at the end of the run automatically frees the resources.
</li>

Getting your docker ready is also a matter of which type of workload you are currently running.

### Build Workloads

With "build" you are actually coding and debugging small experiments. You are __interactive__. In that mode, you can typically take a well known standard image (e.g. <a data-saferedirecturl="https://www.google.com/url?q=https://ngc.nvidia.com/catalog/containers/nvidia:tensorflow&amp;source=gmail&amp;ust=1592498144070000&amp;usg=AFQjCNGTAief8-leIAVR4wSzfzvkGEphDA" href="https://ngc.nvidia.com/catalog/containers/nvidia:tensorflow" rel="noopener" target="_blank">https://ngc.nvidia.com/<wbr/>catalog/containers/nvidia:<wbr/>tensorflow</a>) and use it directly.

Start a docker container by running:

<pre><code>docker run -it .... "the well known image" -v /where/my/code/resides bash </code></pre>

You get a shell prompt to a container with a mounted volume of where your code is. You can then install your prerequisites and run your code via ssh.

You can also access the container remotely from tools such as PyCharm, Jupyter Notebook, and more. In this case, the docker image needs to be customized to install the "server software" (e.g. a Jupyter Notebook service).

### Training Workloads

For training workloads, you can use a well-known image (e.g. the TensorFlow image from the link above) but more often than not, you want to create your own docker image. The best practice is to use the well-known image (e.g. TensorFlow from above) as a __base image__ and add your own customizations __on top__ of it. To achieve that, you create a __Dockerfile__. A Dockerfile is a declarative way to build a docker image and is built in layers. e.g.:

<ol><li>Base image is nvidia-tensorflow</li>
<li>Install popular software</li>
<li>(Optional) Run a script</li>
</ol>

The script can be part of the image or can be provided as part of the command line to run the docker. It will typically include additional dependencies to install as well as a reference to the ML code to be run. 

The best practice for running training workloads is to test the container image in a "build" session and then send it for execution as a training Job. For further information on how to set up and parameterize a training workload via docker or Run:ai see [Converting your Workload to use Unattended Training Execution](convert-to-unattended.md).