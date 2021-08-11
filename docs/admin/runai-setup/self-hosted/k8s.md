
# Install Kubernetes in Airgapped environments

The following are instructions on how to install vanilla Kubernetes in an air-gapped environment. 


## Prerequisites 

* These instructions assume Ubuntu 18.04. For instructions for other Operating Systems please contact Run:AI customer support. 
* At least one node for a Kubernetes master and one node for a Kubernetes worker.
* NVIDIA Drivers are installed for machines with GPUs.
* A compressed tar file `k8s.tar` from Run:AI customer support containing a version of Kubernetes
* __Docker Registry__ Network address and port for a Docker registry (referenced below as `<REGISTRY_URL>`). 


## Master Node 

Unzip the Kubernetes tar file

```
tar xvf k8s.tar.gz
```

If docker is not installed:

```
sudo dpkg -i k8s/deb/docker.io/*
```

Load all docker images:
```
ls -1 k8s/kube-images/*.tar | xargs --no-run-if-empty -L 1 sudo docker load -i
```

Set the location of the Docker registry (IP and port):

``` bash
export REGISTRY_URL=<REGISTRY_URL>
```

Load images to Docker registry:

``` bash
sudo docker images | sed '1d' | awk '{print $1 " " $2}' > kube-images.list

while read REPOSITORY TAG
do
	IMAGE_NAME=$(echo "$REPOSITORY" | rev | cut -d "/" -f1 | rev)
        sudo docker tag  "$REPOSITORY:$TAG" "$REGISTRY_URL/$IMAGE_NAME:$TAG"
	sudo docker push "$REGISTRY_URL/$IMAGE_NAME:$TAG"
done < kube-images.list

``` 

Install k8s:
``` bash
sudo sh -c 'cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF'
sudo dpkg -i k8s/deb/kubelet/*
sudo dpkg -i k8s/deb/kubectl/*
sudo dpkg -i k8s/deb/kubeadm/*
swapoff -a
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.18.4  \
    --image-repository $REGISTRY_URL

```

The init command emits a join command for the workers. Save it.

Copy the Kubernetes access configuration file:
``` shell
mkdir .kube
sudo cp -i /etc/kubernetes/admin.conf .kube/config
sudo chown $(id -u):$(id -g) .kube/config
```

Change Kubernetes networking (flannel) to point to a local registry:

```
sed -i -e "s/quay.io\/coreos/$REGISTRY_URL/g" k8s/kube-flannel.yml
```

Install Kubernetes Networking:
```
kubectl apply -f k8s/kube-flannel.yml
```

Permanently remove swap by editing the file `/etc/fstab` and commenting out any swap entry


## Kubernetes Workers 

Unzip the Kubernetes tar file
``` 
tar xvf k8s.tar.gz
```

If docker is not installed:
```
sudo dpkg -i k8s/deb/docker.io/*
```

If this Worker node contains GPUs, perform the instructions in the GPU Workers section below.


Install k8s:
``` shell
sudo sh -c 'cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF'

sudo dpkg -i k8s/deb/kubelet/*
sudo dpkg -i k8s/deb/kubeadm/*
swapoff -a
```


Replace the following command with the one saved from the init command above:

```
sudo kubeadm join <master-ip>:6443 --token <token> 
    --discovery-token-ca-cert-hash <hash> 
```

!!! Note
    The default token expires after 24 hours. If the token has expired, go to the master node and run `sudo kubeadm token create --print-join-command`. This will produce an up-to-date join command.


Permanently remove swap by editing the file `/etc/fstab` and commenting out any swap entry.


### GPU Workers

In __addition__ to the above section, do the following to install NVIDIA Docker __after__ installing Docker:

```
sudo dpkg -i k8s/deb/nvidia-docker2/*
sudo vi /etc/docker/daemon.json
```

Add the following configuration to the file (see details [here](../../../cluster-setup/cluster-install/#step-14-make-nvidia-docker-the-default-docker-runtime) ):

```
"default-runtime": "nvidia",
```

Restart docker:
```
sudo systemctl restart docker
```
