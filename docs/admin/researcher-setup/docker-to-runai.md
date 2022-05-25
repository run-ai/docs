## Dockers, Images, and Kubernetes

Researchers are typically proficient in working with Docker. Docker is an isolation level above the operating system which allows creating your own bundle of the operating system + deep learning environment and packaging it within a single file. The file is called __a _docker image_.__

You create a __container__ by starting a docker image on a machine.

Run:ai is based on __Kubernetes__. At its core, Kubernetes is an orchestration software above Docker: Among other things, it allows location abstraction as to where the actual container is running. This calls for some adaptation to the Researcher's workflow as follows.

## Image Repository

If your Kubernetes cluster contains a single GPU node (machine), then your image can reside on the node itself (in which case, when [runai submit](../../Researcher/cli-reference/runai-submit.md) workloads, the Researcher must use the flag ``--local-image``).

If your Kubernetes cluster contains more than a single node, then, to enable location abstraction, the image can no longer reside on the node itself.  It must be relocated to an image repository. There are quite a few repository-as-a-service, most notably <a href="https://hub.docker.com/" target="_self">Docker hub</a>. Alternatively, the organization can install a private repository on-prem.

Day-to-day work with the image located remotely is almost identical to local work. The image name now contains its location. For example, ``nvcr.io/nvidia/pytorch:19.12-py_3`` is a PyTorch image that is located in __nvcr.io__. This is the Nvidia image repository as found on the web. 

## Data

Deep learning is about data. It can be your code, the training data, saved checkpoints, etc.

If your Kubernetes cluster contains a single GPU node (machine), then your data can reside on the node itself.

If your Kubernetes cluster contains more than a single node, then, to enable location abstraction, the data must sit outside the machine, typically on network storage. The storage must be uniformly mapped to your container when it starts (using the -v command).

## Working with Containers 

Starting a container using docker usually involves a single command-line with multiple flags. A typical example: 

    docker run --runtime=nvidia --shm-size 16G -it --rm -e HOSTNAME='hostname' \
        -v /raid/public/my_datasets:/root/dataset:ro   -i  nvcr.io/nvidia/pytorch:19.12-py3

The docker command ``docker run`` should be replaced with a Run:ai command ``runai submit``. The flags are usually the same but some adaptation is required. A complete list of flags can be found here: [runai submit](../../Researcher/cli-reference/runai-submit.md). 

There are similar commands to get a shell into the container (_runai bash_), get the container logs (_runai logs_), and more. For a complete list see the Run:ai CLI [reference](../../Researcher/cli-reference/Introduction.md). 

## Schedule an Onboarding Session

It is highly recommended to schedule an onboarding session for Researchers with a Run:ai customer success professional. Run:ai can help with the above transition, but adding to that, we at Run:ai have also acquired a large body of knowledge on data science best practices which can help streamline  Researchers' work as well as save money for the organization.

 