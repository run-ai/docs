## Install a bare-bones Kubeneretes

## Prerequisites:

* All machines use Ubuntu 18.04
* NVDIA Drivers are installed for machines with GPUs.
* tar file containing Kubernetes artifcats



### Run on Master Node (only)

```
tar xvf k8s.tar
```

If docker is not installed:
```
sudo dpkg -i transfer/deb/docker.io/*
```
Load all docker images:
```
ls -1 transfer/kube-images/*.tar | xargs --no-run-if-empty -L 1 sudo docker load -i
```
Install k8s:
```
sudo sh -c 'cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF'
sudo dpkg -i transfer/deb/kubelet/*
sudo dpkg -i transfer/deb/kubectl/*
sudo dpkg -i transfer/deb/kubeadm/*
swapoff -a
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.18.4
```
Disable swap for good:
1. Edit the file /etc/fstab
2. Comment any swap entry

Save the output of the init command.

```
mkdir .kube
sudo cp -i /etc/kubernetes/admin.conf .kube/config
sudo chown $(id -u):$(id -g) .kube/config

kubectl apply -f transfer/kube-flannel.yml
```

### Run on Kubernetes Workers 



```
tar xvf k8s.tar
```

If docker is not installed:
```
sudo dpkg -i transfer/deb/docker.io/*
```
Load all docker images:
```
ls -1 transfer/kube-images/*.tar | xargs --no-run-if-empty -L 1 sudo docker load -i
```
Install k8s:
```
sudo sh -c 'cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF'

sudo dpkg -i transfer/deb/kubelet/*
sudo dpkg -i transfer/deb/kubeadm/*
swapoff -a
```
Disable swap for good:
1. Edit the file /etc/fstab
2. Comment any swap entry

Replace the following command with the one saved from the init command above:

```
sudo kubeadm join 10.0.0.3:6443 --token 7wo4nf.ojpxltg7wbf7pqgj \
    --discovery-token-ca-cert-hash sha256:f4f481eba0d6a094d092a956f9d0bbd4e316211212bd58f445665e3fced399e3
```


