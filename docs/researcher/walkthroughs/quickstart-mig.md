# Quickstart: Launch Workloads with NVIDIA Dynamic MIG

## Introduction


A single GPU has a significant amount of memory. Ranging from a couple of gigabytes in older generations and up to 80GB per GPU in the later models of the latest NVIDIA GPU technology. A single GPU also has a vast amount of computing power. 

This amount of memory and computing power is important for processing large amounts of data, such as in training deep learning models. However, there are quite a few applications that do not need this power. Examples can be inference workloads and the model-creation phase. It would thus be convenient if we could __divide up a GPU__ between various workloads, thus achieving better GPU utilization. 

Run:ai provides two alternatives for splitting GPUs: [Fractions](walkthrough-fractions.md) and _Dynamic MIG allocation_. The focus of this article is Dynamic MIG allocation.  A detailed explanation of the two Run:ai offerings can be found [here](../scheduling/fractions.md).


## Prerequisites 

To complete this Quickstart you must have:

* Run:ai software installed on your Kubernetes cluster. See: [Installing Run:ai on a Kubernetes Cluster](../../admin/runai-setup/installation-types.md)
* Run:ai CLI installed on your machine. See: [Installing the Run:ai Command-Line Interface](../../admin/researcher-setup/cli-install.md)
* A machine with a __single__ available NVIDIA A100 GPU. This can be achieved by allocating _filler_ workloads to the other GPUs on the node, or by using Google Cloud which allows for the creation of a virtual node with a single A100 GPU. 

## Step by Step Walkthrough

### Setup

* Login to the Projects area of the Run:ai user interface.
* Allocate 2 GPUs to the Project.
* Mark the node as a dynamic MIG node as described [here](../scheduling/fractions.md).

### Run an Inference Workload - Single Replica


At the GPU node level, run: `nvidia-smi`:

``` hl_lines="10 20"
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 460.91.03    Driver Version: 460.91.03    CUDA Version: 11.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  A100-SXM4-40GB      Off  | 00000000:00:04.0 Off |                   On |
| N/A   32C    P0    42W / 400W |      0MiB / 40536MiB |     N/A      Default |
|                               |                      |              Enabled |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| MIG devices:                                                                |
+------------------+----------------------+-----------+-----------------------+
| GPU  GI  CI  MIG |         Memory-Usage |        Vol|         Shared        |
|      ID  ID  Dev |           BAR1-Usage | SM     Unc| CE  ENC  DEC  OFA  JPG|
|                  |                      |        ECC|                       |
|==================+======================+===========+=======================|
|  No MIG devices found                                                       |
+-----------------------------------------------------------------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

In the highlighted text above, note that:

* MIG is enabled (if `Enabled` has a star next to it, you need to reboot your machine).
* The GPU is not yet divided into _devices_.



At the command-line run:

```
runai config project team-a
runai submit mig1 -i gcr.io/run-ai-demo/quickstart-cuda  --gpu-memory 10GB
runai submit mig2 -i gcr.io/run-ai-demo/quickstart-cuda  --mig-profile 2g.10gb 
runai submit mig3 -i gcr.io/run-ai-demo/quickstart-cuda  --mig-profile 2g.10gb 
```

We used two different methods to create MIG partitions: 

1. Stating the amount of GPU memory we require 
2. Requiring a partition of explicit size using NVIDIA terminology. 

Both methods achieve the same effect. They result in three MIG partitions of 10GB each. You can verify that by running `nvidia-smi`, at the GPU node level:

``` hl_lines="14"
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 460.91.03    Driver Version: 460.91.03    CUDA Version: 11.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  A100-SXM4-40GB      Off  | 00000000:00:04.0 Off |                   On |
| N/A   47C    P0   194W / 400W |  27254MiB / 40536MiB |     N/A      Default |
|                               |                      |              Enabled |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| MIG devices:                                                                |
+------------------+----------------------+-----------+-----------------------+
| GPU  GI  CI  MIG |         Memory-Usage |        Vol|         Shared        |
|      ID  ID  Dev |           BAR1-Usage | SM     Unc| CE  ENC  DEC  OFA  JPG|
|                  |                      |        ECC|                       |
|==================+======================+===========+=======================|
|  0    3   0   0  |   9118MiB /  9984MiB | 28      0 |  2   0    1    0    0 |
|                  |      4MiB / 16383MiB |           |                       |
+------------------+----------------------+-----------+-----------------------+
|  0    4   0   1  |   9118MiB /  9984MiB | 28      0 |  2   0    1    0    0 |
|                  |      4MiB / 16383MiB |           |                       |
+------------------+----------------------+-----------+-----------------------+
|  0    5   0   2  |   9016MiB /  9984MiB | 28      0 |  2   0    1    0    0 |
|                  |      2MiB / 16383MiB |           |                       |
+------------------+----------------------+-----------+-----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0    3    0     142213      C   ./quickstart                     9111MiB |
|    0    4    0     146799      C   ./quickstart                     9111MiB |
|    0    5    0     132219      C   ./quickstart                     9009MiB |
+-----------------------------------------------------------------------------+
```

* Highlighted above is a list of 3 MIG devices, each 10GB large. Total of 30GB (out of the 40GB on the GPU)
* You can also run the same command inside one of the containers: `runai exec mig1 nvidia-smi`. This will show a single device (the only one that the container sees from its point of view).
* Run: `runai list` to see the 3 jobs in `Running` state.


We now want to allocate an _interactive_ job with 20GB. Interactive jobs take precedence over the default _training_ jobs:

```
runai submit mig1-int -i gcr.io/run-ai-demo/quickstart-cuda \
    --interactive --gpu-memory 20G 
```
or similarly,
```
runai submit mig1-int -i gcr.io/run-ai-demo/quickstart-cuda \
    --interactive --mig-profile 3g.20gb  
```



Using `runai list` and `nvidia-smi` on the host machine, you can see that:

* One training job is preempted, and its device is deleted.
* The new, interactive job starts running.






