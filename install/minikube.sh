set -x 


# **** NVIDIA-DRIVERS ****
if ! type nvidia-smi > /dev/null; then
	echo 'NVIDIA Drivers not installed, installing now'
	sudo apt update
	sudo apt install ubuntu-drivers-common -y
	sudo ubuntu-drivers autoinstall
	echo 'Reboot your machine and run this script again'
	exit
fi

# **** Docker ****
if ! type docker > /dev/null; then
	echo 'Installing Docker'
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
fi

# **** remove sudo constraint
sudo usermod -aG docker $USER

sudo apt install jq -y

# **** install NVIDIA docker ****
if ! type nvidia-docker > /dev/null; then
	echo 'Installing NVIDIA-Docker'
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
	curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
	curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
	sudo apt-get update && sudo apt-get install -y nvidia-docker2

	# Update the default configuration and restart
	# Taken from https://lukeyeager.github.io/2018/01/22/setting-the-default-docker-runtime-to-nvidia.html
	pushd $(mktemp -d)
	(sudo cat /etc/docker/daemon.json 2>/dev/null || echo '{}') | \
		jq '. + {"default-runtime": "nvidia"}' | \
		tee tmp.json
	sudo mv tmp.json /etc/docker/daemon.json
	popd
	sudo systemctl restart docker
fi



# **** Install Kubectl **** 
# TODO: +++ Look into codyfing a specific k8s version

#From: https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux
if ! type kubectl > /dev/null; then
	sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl
fi

# **** install Run:AI CLI
if ! type runai > /dev/null; then
	echo 'Installing Run:AI CLI'
	#intentionally overriding other helm versions in case helm 2 exists. 
	mkdir runai && cd runai
	wget https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz
	tar xvf helm-v3.3.4-linux-amd64.tar.gz
	sudo mv linux-amd64/helm /usr/local/bin/
	mkdir runai && cd runai 
	wget https://github.com/run-ai/runai-cli/releases/download/v2.2.7/runai-cli-v2.2.7-linux-amd64.tar.gz
	tar xvf runai-cli-v2.2.7-linux-amd64.tar.gz
	sudo ./install-runai.sh
	sudo runai update
	cd ..
fi

# **** install minikube
echo 'Installing minikube'
 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
 sudo install minikube-linux-amd64 /usr/local/bin/minikube

# **** GPU minikube startup. Using https://minikube.sigs.k8s.io/docs/tutorials/nvidia_gpu/#using-the-none-driver
sudo apt-get install -y conntrack

echo 'Starting Kubernetes...'
sudo minikube start --driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost
sudo chown -R $USER .kube .minikube


