# Quick Install of Run:AI on a Single Node

Below are instructions on how to install Run:AI cluster on a single node. The installation script has been significantly simplified to include a built-in Kubernetes using [minikube](https://minikube.sigs.k8s.io/docs/). 

# Prerequisites 

The installation below assumes:

* A single node, with at least one GPU.
* Running Ubuntu 18.04 or similar.
* `sudo` access to the node.
* An email and a password provided by Run:AI customer support.

If NVIDIA Drivers are not installed, the script will install the latest NVIDIA Drivers.


# Installation steps

Get the script:

``` shell
wget https://raw.githubusercontent.com/run-ai/docs/master/install/single-node-install.sh && chmod +x single-node-install.sh
```

Run the script: 

```
sudo ./single-node-install.sh <email> '<password>'
```

(note that the password may have special characters, hence the need for surrounding quotes)

If the NVIDIA Drivers have not been pre-installed, they will be installed now. If that happens, the script will ask to reboot, after which, re-run the command above. 




## Next Steps

* Set up at least one project [Working with Projects](../Admin-User-Interface-Setup/Working-with-Projects.md).
* Review [Quickstart Guides](../../Researcher/Walkthroughs/Run-AI-Walkthroughs.md) to run workloads. 
