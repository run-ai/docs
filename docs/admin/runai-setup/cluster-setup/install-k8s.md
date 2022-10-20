# Native Kubernetes Installation

Kubernetes is composed of master(s) and workers. The instructions and script below are for creating a bare-bones installation of a single master and several workers for __testing__ purposes. For a more complex, __production-grade__, Kubernetes installation, use tools such as Rancher Kubernetes Engine, or review [Kubernetes documentation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/){target=_blank} to learn how to customize the native installation.


## Prerequisites:

* The script below assumes all machines have Ubuntu 18.04 or later. For other Linux-based operating-systems see [Kubernetes documentation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/){target=_blank}. 
* The script must be run with ROOT privileges.
* Inbound ports 6443,443,8080 must be allowed. 
* The script support Kubernetes 1.24 or later.

## Install Kubernetes
### Install Kubernetes Master

* Get the script by running: 
```
wget https://raw.githubusercontent.com/run-ai/docs/master/install/kube-install.sh
```
* Run the script with ROOT privileges: `sudo ./kube-install.sh`
* When prompted, select the option to _install Kubernetes master_.
* Select the Kubernetes version you want or press `Enter` for the default script version. 
* Select the CNI (networking) version or press `Enter` for the default.

When the script finishes, it will prompt a _join_ command_ to be run on all workers. Save the command for later use.

!!! Note
    The default token expires after 24 hours. If the token has expired, go to the master node and run `sudo kubeadm token create --print-join-command`. This will produce an up-to-date join command.


Test that Kubernetes is up by running:
```
kubectl get nodes
```
Verify that the master node is ready


### Install Kubernetes Workers

On each designated worker node:

* Get the script by running: 
```
wget https://raw.githubusercontent.com/run-ai/docs/master/install/kube-install.sh
```
* Run the script with ROOT privileges: `sudo ./kube-install.sh`
* When prompted, select the option to _install Kubernetes worker_.
* Select the Kubernetes version you want or press `Enter` for the default script version. The version should be the same as the one selected for the Kubernetes master. 

When the script finishes, run the _join command_ saved above. 


To test that the worker has successfully joined, on the __master__ node run:
```
kubectl get nodes
```
Verify that the new worker node is showing and ready (may take a couple of seconds).

### Avoiding Accidental Upgrades

To avoid an accidental upgrade of Kubernetes binaries during Linux upgrades, it is recommended to _hold_ the version. Run the following on all nodes:

```
sudo apt-mark hold kubeadm kubelet kubectl
```

## Next Steps

The administrative Kubernetes profile can be found in the master node under the `.kube` folder. 

## Reset Nodes

The same script also contains an option to completely remove Kubernetes from nodes (master or workers). To use, run: 

* Get the script by running: 
```
wget https://raw.githubusercontent.com/run-ai/docs/master/install/kube-install.sh
```
* Run the script with ROOT privileges: `sudo ./kube-install.sh`
* When prompted, select the option to _reset/delete kubernetes_.
* Select yes when prompted to reset the cluster and remove Kubernetes packages.

