# Quick Install of Run:AI on a Single Node

Below are instructions on how to install the Run:AI cluster on a single node. This process is good for __learning__ Run:AI or using a Run:AI cluster __on a single node__.  Multiple nodes are __not supported__ with this installation. To install a cluster with multiple nodes or for running a formal pilot with Run:AI, use [Cluster Installation](cluster-install.md).

The installation process below is comprised of a single script and includes the installation of a built-in Kubernetes using [microk8s](https://microk8s.io/docs/getting-started){target=_blank}.

## Prerequisites 

The installation below assumes:

* A single node, with at least one GPU.
* Running Ubuntu 20.04.
* `sudo` access to the node (you may be prompted for sudo password during the installation).
* A client id and a secret provided by Run:AI customer support. 
* Outbound internet connectivity


## Installation steps


Get the script:

``` shell
wget https://raw.githubusercontent.com/run-ai/docs/master/install/single-node-install.sh && chmod +x single-node-install.sh
```

Run the script: 

```
./single-node-install.sh <client-id>> <secret>
```

!!! Notes
    * The script will stop at one point, require that you log out and log in again
    * You may be prompted for a sudo password during the installation



## Next Steps

* Set up at least one Project [Working with Projects](../../admin-ui-setup/project-setup.md).
* Review [Quickstart Guides](../../../Researcher/Walkthroughs/quickstart-overview.md) to run workloads. 
