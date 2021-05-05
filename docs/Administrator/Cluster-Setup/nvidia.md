
The document refers to the installation of NVIDIA CUDA drivers and NVIDIA Docker on __each node__ containing GPUs. For using the (recommended) NVIDIA GPU Operator instead, see the [Cluster Installation](cluster-install.md) documentation. 

If you are using [DGX OS](https://docs.nvidia.com/dgx/index.html){target=_blank} then NVIDIA preqrequisites are already installed and you may skip this document


On __each machine__ with GPUs run the following steps.

## Step 1: Install the NVIDIA CUDA Toolkit

Run: 

``` 
nvidia-smi
```

If the command is __not__ successful, you must install the CUDA Toolkit. Follow the instructions [here](https://developer.nvidia.com/cuda-downloads){target=_blank} to install. When the installation is finished you must reboot your computer. 

If the machine is __DGX A100__, then apart from the CUDA Toolkit you must also install the __NVIDIA Fabric Manager__:

* Run: `nvidia-smi` and get the NVIDIA Driver version (it must be 450 or later).
* Run: `sudo apt search fabricmanager` to find a Fabric Manager package with the same version and install it.

## Step 2: Install Docker

Install Docker by following the steps here: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/){target=_blank}. Specifically, you can use a convenience script provided in the document:
``` shell
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## Step 3:  NVIDIA Container Toolkit (previously named NVIDIA Docker)

To install NVIDIA Docker on Debian-based distributions (such as Ubuntu), run the following:

``` shell
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
```

For RHEL-based distributions, run:

``` shell
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo
sudo yum install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
```

For a detailed review of the above instructions, see the [NVIDIA Container Toolkit  installation instructions](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html){target=_blank}.

!!! Warning
    Kubernetes does [not currently support](https://github.com/NVIDIA/nvidia-docker/issues/1268){target=_blank}  the [NVIDIA container runtime](https://github.com/NVIDIA/nvidia-container-runtime){target=_blank}, which is the successor of NVIDIA Docker/NVIDIA container toolkit.

## Step 4: Make NVIDIA Docker the default docker runtime

Set the NVIDIA runtime as the default Docker runtime on your node. Edit the docker daemon config file at ``/etc/docker/daemon.json `` and add the ``default-runtime`` key as follows: 

``` json
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```
Then run the following again:

    sudo pkill -SIGHUP dockerd
