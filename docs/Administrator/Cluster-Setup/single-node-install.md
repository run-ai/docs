# Quick Install of Run:AI on a Single Node

Below are instructions on how to install Run:AI cluster on a single node. This process is good for __learning__ Run:AI or using a Run:AI cluster __on a single node__.  Multiple nodes are __not supported__ with this installation. To install a cluster with multiple nodes use [Cluster Installation](cluster-install.md).

The installation process below is comprised of a single script and includes the installation of a built-in Kubernetes using [minikube](https://minikube.sigs.k8s.io/docs/){target=_blank}.

## Prerequisites 

The installation below assumes:

* A single node, with at least one GPU.
* Running Ubuntu 18.04 or Ubuntu 20.04.
* `sudo` access to the node.
* An email and a password provided by Run:AI customer support.
* Outbound internet connectivity

If NVIDIA Drivers are not installed, the script will install the latest NVIDIA Drivers.


## Installation steps

Get the script:

``` shell
wget https://raw.githubusercontent.com/run-ai/docs/master/install/single-node-install.sh && chmod +x single-node-install.sh
```

Run the script: 

```
sudo ./single-node-install.sh <email> '<password>'
```

(note that the password may have special characters, hence the need for surrounding quotes)

If the NVIDIA Drivers have not been pre-installed, they will be installed by the script. The script will then ask for a reboot, after which, re-run the command above. 


## Node Shutdown and Restart

To shut down your node, you must first perform an orderly shutdown of Kubernetes by running:

```
sudo minikube stop
```

When you restart your node, Kubernetes must be restarted as well, using the following command:

```
sudo minikube start --driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost
```

The Run:AI cluster will automatically start following Kubernetes.


## Deleting Run:AI

Run:

```
sudo minikube delete --all
```

## Next Steps

* Set up at least one project [Working with Projects](../Admin-User-Interface-Setup/Working-with-Projects.md).
* Review [Quickstart Guides](../../Researcher/Walkthroughs/Run-AI-Walkthroughs.md) to run workloads. 
