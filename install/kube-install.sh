#!/bin/bash
#description : This script will help to install k8s cluster (master / worker) and gpu operator
#author		 : Moran Guy
#date        : 19/10/2022
#version     : 1.0
#usage       : Please make sure to run this script as ROOT or with ROOT permissions
#notes       : supports ubuntu OS 18.04/20.04/22.04
#==============================================================================
NC='\033[0m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'

# ***Disable Swap
function disable-swap {
    swapoff -a
    sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
}

# ***load kernel modules for support containerd 
function load-kernel-modules {
    tee /etc/modules-load.d/containerd.conf <<EOF
    overlay
    br_netfilter
EOF
    modprobe overlay
    modprobe br_netfilter
}

# ***Setup K8s Networking
function network {
    tee /etc/sysctl.d/kubernetes.conf <<EOF
    net.bridge.bridge-nf-call-ip6tables = 1
    net.bridge.bridge-nf-call-iptables = 1
    net.ipv4.ip_forward = 1
EOF
echo 1 > /proc/sys/net/ipv4/ip_forward
sudo sysctl --system
}

function install-containerd {
        if [ -x "$(command -v containerd)" ]
        then
                echo -e "${GREEN}containerd already installed${NC}"
        else
                echo  -e "${GREEN} installing containerd...${NC}"
                apt install -y curl gpgv gpgsm gnupg-l10n gnupg dirmngr software-properties-common apt-transport-https ca-certificates
                # apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
                add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                sudo apt update
                sudo apt install -y containerd.io
                containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
                sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
                systemctl restart containerd
                systemctl enable containerd

        fi
}

# ***Install K8s
function k8s-install {
	    sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl
        sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
        echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
	    sudo apt-get update
	    echo -e "${GREEN} installing kubectl kubeadm kubelet...${NC}"
        sudo apt-get install -y kubelet="${k8s_version}-00" kubeadm="${k8s_version}-00" kubectl="${k8s_version}-00"
}

# *** init K8s
function k8s-init {
	    echo -e "${GREEN} init k8s...${NC}"
        kubeadm init --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v${k8s_version} --token-ttl 186h --control-plane-endpoint=${server_ip}
        export KUBECONFIG=/etc/kubernetes/admin.conf
        mkdir -p ${HOME}/.kube
        sudo cp -i /etc/kubernetes/admin.conf ${HOME}/.kube/config
        sudo chown $(id -u):$(id -g) .kube/config
        echo  -e "${GREEN} Please do not forget to join the other k8s nodes ${NC}"
}

# *** install cni
function install-cni {
        if [ "${cni_plugin}" == 1 ]
        then
            echo  -e "${GREEN} Deploying the Flannel Network Plugin...${NC}"
            kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml
            sleep 120
            kubectl wait pods -n kube-flannel  -l app=flannel --for condition=Ready --timeout=180s
        elif [ "${cni_plugin}" == 2 ]
        then
            echo  -e "${GREEN} Deploying the Calico Network Plugin...${NC}"
            curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
            kubectl apply -f calico.yaml
            sleep 120
        fi

}

# *** Install Helm
function install-helm {
	if [ -x "$(command -v helm)" ]
    then
        echo -e "${GREEN} Helm already installed ${NC}"
    else
		echo -e "${GREEN} Installing Helm ${NC}"
        wget https://get.helm.sh/helm-v3.9.3-linux-amd64.tar.gz
        tar -zxvf helm-v3.9.3-linux-amd64.tar.gz
        sudo mv linux-amd64/helm /usr/local/bin/helm
	fi
		
}

# ***  install nvidia gpu operator
function install-gpu-operator {
	   echo  -e "${GREEN} installing NVIDIA GPU operator...${NC}"
	   helm repo add nvidia https://nvidia.github.io/gpu-operator && helm repo update
       helm install --wait --generate-name -n gpu-operator --create-namespace nvidia/gpu-operator
       sleep 300
       kubectl wait pods -n gpu-operator  -l app=nvidia-operator-validator --for condition=Ready --timeout=1200s
       echo  -e "${GREEN}NVIDIA GPU deployed${NC}"
}

###START HERE###


echo -e "${YELLOW}Please select a task (1. install kubernetes master, 2. install kubernetes worker, 3. install gpu operator, 4. reset/delete kubernetes)${NC}"
read task
if [ "${task}" == "1" ]
then
    echo -e "${GREEN} *** Please make sure inbound ports 6443,443,8080 are allowed *** ${NC}"
    sleep 5
    read -p "$(echo -e "${YELLOW}Please enter kubernetes version, or press enter for default (1.24.7) :${NC}")" k8s_version
    k8s_version=${k8s_version:-"1.24.7"}
    read -p "$(echo -e "${YELLOW}Please select CNI plugin or press enter for default ([1] Flannel(default) , [2] Calico) :${NC}")" cni_plugin
    cni_plugin=${cni_plugin:-"1"}
    disable-swap
    load-kernel-modules
    network
    install-containerd
    if pgrep -x "containerd" >/dev/null 
    then
        echo -e "${GREEN}containerd is up and running${NC}"
    else
        echo -e "${RED}containerd is not running${NC}"
        echo -e "${RED}Please check the logs and re-run this script${NC}"
        exit
    fi
    k8s-install
    k8s-init
    install-cni
    install-helm
    echo -e "${GREEN}Now you can join the other nodes to the cluster with the join command below:${NC}"
    kubeadm token create --print-join-command
elif [ "${task}" == "2" ]
then
    read -p "$(echo -e "${YELLOW}Please enter kubernetes version, or press enter for default (1.24.7) :${NC}")" k8s_version
    k8s_version=${k8s_version:-"1.24.7"}
    disable-swap
    load-kernel-modules
    network
    install-containerd
    k8s-install
    echo -e "${GREEN}Now node is ready to join the cluster. copy the join command from the master and run here.${NC}"
elif [ "${task}" == "3" ]
then
    install-helm
    install-gpu-operator
    echo -e "${GREEN}kubernetes cluster is ready.${NC}"
    echo -e "${GREEN}Please procced to install runai${NC}"
elif [ "${task}" == "4" ]
then
    echo -e "${YELLOW}Would you like to reset kubernetes cluster (y/n)?${NC}"
    read answer
    if [ "${answer}" == "y" ]
    then 
        echo -e "${YELLOW}Reset kubernetes cluster...${NC}"
        kubeadm reset -f
        rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/run/kubernetes ~/.kube/*
        iptables -F && iptables -X
        iptables -t nat -F && iptables -t nat -X
        iptables -t raw -F && iptables -t raw -X
        iptables -t mangle -F && iptables -t mangle -X
        systemctl restart containerd
        if [ $? == 0 ]
        then 
            echo -e "${GREEN} OK! ${NC}"
        else
            echo -e "${RED}Something went wrong!${NC}"
        fi
    else
        echo -e "${YELLOW}Operation aborted{NC}"
    fi

    echo -e "${YELLOW}Would you like to remove kubernetes packages completely? (y/n)?${NC}"
    read answer
    if [ "${answer}" == "y" ]
    then 
        echo -e "${YELLOW}Removing kubeadm kubectl kubelet kubernetes-cni...${NC}"
        sudo apt-get purge -y kubeadm kubectl kubelet kubernetes-cni kube*
        if [ $? == 0 ]
        then 
            echo -e "${GREEN} OK! ${NC}"
        else
            echo -e "${RED}Something went wrong!${NC}"
        fi
    else
        echo -e "${YELLOW}Operation aborted${NC}"
    fi
fi
