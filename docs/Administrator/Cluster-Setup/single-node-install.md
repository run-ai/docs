# Install Run:AI on a Single Node

Below are instructions on how to install Run:AI cluster on a single node. The installation script has been significantly simplified to include a built-in Kubernetes using [minikube](https://minikube.sigs.k8s.io/docs/)


# Prerequisites 

The installation below assumes:

* A single node, with at least one GPU.
* Running Ubuntu 18.04 or similar.
* An email and a password provided by Run:AI customer support

If NVIDIA Drivers are not installed, the script will install the latest NVIDIA Drivers


# Installation steps

Get the scripts:

``` shell
wget https://raw.githubusercontent.com/run-ai/docs/master/install/minikube.sh
wget https://raw.githubusercontent.com/run-ai/docs/master/install/install-cluster.sh
chmod +x minikube.sh install-cluster.sh
```

Install Kubernetes and all dependencies:

```
./minikube.sh
```

If the NVIDIA Drivers were not pre-installed, they will be installed now. The script will ask to reboot, after which, re-run the command above. 

Install Run:AI and create a Run:AI cluster
```
./install-cluster.sh <email> '<password>'
```

(note that the password may have special characters, hence the need for surrounding quotes)



## Next Steps

* Set up at least one project [Working with Projects](../Admin-User-Interface-Setup/Working-with-Projects.md).
* Review [Quickstart Guides](../../Researcher/Walkthroughs/Run-AI-Walkthroughs.md) to run workloads. 
