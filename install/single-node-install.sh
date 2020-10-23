#Requires Auth0 grant type connection to be added 'password'. Try without this, not sure.
if [ "$#" -ne 2 ]; then
    echo "Usage: install-cluster.sh email password"
    exit 1
fi

GREEN='\033[0;32m'
NC='\033[0m'

RUNAI_USERNAME=$1
RUNAI_PASSWORD=$2

CLUSTER_NAME=cluster1



# **** NVIDIA-DRIVERS ****
if ! type nvidia-smi > /dev/null; then
	echo -e "${GREEN} NVIDIA Drivers not installed, installing now ${NC}"
	sudo apt update
	sudo apt install ubuntu-drivers-common -y
	sudo ubuntu-drivers autoinstall
	echo -e "${GREEN} NVIDIA Drivers installed. Reboot your machine and run this script again to continue ${NC}"
	exit
fi

# **** Docker ****
if ! type docker > /dev/null; then
	echo -e "${GREEN} Installing Docker ${NC}"
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
fi

# **** remove sudo constraint
sudo usermod -aG docker $USER

sudo apt install jq -y

# **** install NVIDIA docker ****
if ! type nvidia-docker > /dev/null; then
	echo -e "${GREEN} Installing NVIDIA-Docker ${NC}"
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
	curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
	curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
	sudo apt-get update && sudo apt-get install -y nvidia-docker2

	if [ ! -f /etc/docker/daemon.json ]; then
		sudo mkdir -p /etc/docker
		cat <<EOF | sudo tee /etc/docker/daemon.json
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
EOF
	fi
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
	echo -e "${GREEN} Installing Kubectl ${NC}"
	sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl
fi

# **** install Run:AI CLI
if ! type runai > /dev/null; then
	echo -e "${GREEN} Installing Run:AI CLI ${NC}"
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
echo -e "${GREEN} Installing minikube ${NC}"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# **** GPU minikube startup. Using https://minikube.sigs.k8s.io/docs/tutorials/nvidia_gpu/#using-the-none-driver
sudo apt-get install -y conntrack

echo -e "${GREEN} Starting Kubernetes... ${NC}"
sudo minikube start --driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost
sudo chown -R $USER ~/.kube ~/.minikube


# Log into Run:AI
curl https://app.run.ai/v1/k8s/tenantFromEmail/$RUNAI_USERNAME > /tmp/auth0-data
AUTH0_CLIENT_ID=$(eval cat /tmp/auth0-data | jq -r '.authClientID')
AUTH0_REALM=$(eval cat /tmp/auth0-data | jq -r '.authRealm')

echo $AUTH0_CLIENT_ID
echo $AUTH0_REALM

curl --request POST \
  --url 'https://runai-prod.auth0.com/oauth/token' \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data grant_type='http://auth0.com/oauth/grant-type/password-realm' \
  --data username=$RUNAI_USERNAME \
  --data password=$RUNAI_PASSWORD \
  --data audience='https://api.run.ai' \
  --data scope=read:sample \
  --data 'client_id='$AUTH0_CLIENT_ID'' \
  --data realm=runaidemo > /tmp/token-data

BEARER=$(eval cat /tmp/token-data | jq -r '.access_token')

echo $BEARER

# Create a cluster
curl -X POST 'https://app.run.ai/v1/k8s/clusters' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer '$BEARER'' \
--data '{ "name": "'$CLUSTER_NAME'"}' > /tmp/cluster-data

CLUSTER_UUID=$(eval cat /tmp/cluster-data | jq -r '.uuid')


# Download a cluster operator install file
curl 'https://app.run.ai/v1/k8s/clusters/'$CLUSTER_UUID'/installfile?cloud=op' \
--header 'Authorization: Bearer '$BEARER'' > runai-operator-$CLUSTER_NAME.yaml

# disable local-path-provisioner (not needed with minikube)
sed 's/grafanaLab:/local-path-provisioner:\
    enabled: false\
  &/' runai-operator-$CLUSTER_NAME.yaml > runai-operator-$CLUSTER_NAME-mod.yaml

# **** Install runai (twice do to possible race condition bug)
kubectl apply -f runai-operator-$CLUSTER_NAME-mod.yaml
kubectl apply -f runai-operator-$CLUSTER_NAME-mod.yaml

echo -e "${GREEN}Run:AI installation is now in progress."

sleep 15
until [ "$(kubectl get pods -n runai --field-selector=status.phase!=Running)" = "" ]; do
    printf '.'
    sleep 5
done

echo -e "Run:AI is now active".
echo -e "Next steps: "
echo -e "- Navigate to Administration console at https://app.run.ai ."
echo -e "- Use the Run:AI Quickstart Guides (https://bit.ly/2Hmby08) to learn how to run workloads. ${NC}"






