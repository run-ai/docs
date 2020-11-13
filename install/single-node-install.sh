#Requires Auth0 grant type connection to be added 'password'. Try without this, not sure.
if [ "$#" -ne 2 ]; then
    echo "Usage: sudo install-cluster.sh email password"
    exit 1
fi

if groups | grep "\<sudo\>" &> /dev/null; then
   echo "sudo access exists"
else
   echo "Command requires sudo rights."
   exit 1
fi

GREEN='\033[0;32m'
NC='\033[0m'

RUNAI_USERNAME=$1
RUNAI_PASSWORD=$2
CLUSTER_NAME=cluster1

# install utils
sudo apt update
sudo apt-get install -y conntrack
sudo apt-get install jq -y



# **** NVIDIA-DRIVERS ****
if ! type nvidia-smi > /dev/null; then
	echo -e "${GREEN} NVIDIA Drivers not installed, installing now ${NC}"
	sudo apt install ubuntu-drivers-common -y
	sudo ubuntu-drivers autoinstall
	echo -e  "${GREEN} NVIDIA Drivers installed. Reboot your machine and run this script again to continue ${NC}"
	exit
fi

# **** Docker ****
if ! type docker > /dev/null; then
	echo -e "${GREEN} Installing Docker ${NC}"
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
fi
sudo systemctl restart docker

# **** remove sudo constraint for docker
sudo usermod -aG docker $USER

# **** install NVIDIA docker ****
if ! type nvidia-docker > /dev/null; then
	echo -e "${GREEN} Installing NVIDIA-Docker ${NC}"
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
	curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
	curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
	sudo apt-get update && sudo apt-get install -y nvidia-docker2
	sudo systemctl restart docker
fi

# final check for NVIDIA-docer install
if ! type nvidia-docker > /dev/null; then
	echo "did not succeed installing nvidia-docker. Please install manually and restart (https://docs.run.ai/Administrator/Cluster-Setup/cluster-install/#step-13-install-nvidia-docker)"
	exit 1
fi

# set daemon.json file if does not exist
if [ ! -f /etc/docker/daemon.json ]; then
	sudo mkdir -p /etc/docker
	cat <<EOF | sudo tee /etc/docker/daemon.json
{
	"default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
EOF
fi

# If daemon.json exists, but nvidia-docker is not the default, rectify this
# Taken from https://lukeyeager.github.io/2018/01/22/setting-the-default-docker-runtime-to-nvidia.html
(sudo cat /etc/docker/daemon.json 2>/dev/null || echo '{}') | \
	jq '. + {"default-runtime": "nvidia"}' | \
	tee tmp.json
sudo mv tmp.json /etc/docker/daemon.json

sudo systemctl restart docker

# **** Install Kubectl **** 
# TODO: +++ Look into codyfing a specific k8s version
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
echo -e "${GREEN} Starting Kubernetes... ${NC}"
sudo minikube start --driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost --kubernetes-version=1.18.4
sudo chown -R $SUDO_USER ~/.kube ~/.minikube


# *** Log into Run:AI
curl https://app.run.ai/v1/k8s/tenantFromEmail/$RUNAI_USERNAME > /tmp/runai-auth0-data
AUTH0_CLIENT_ID=$(eval cat /tmp/runai-auth0-data | jq -r '.authClientID')
AUTH0_REALM=$(eval cat /tmp/runai-auth0-data | jq -r '.authRealm')

echo  $AUTH0_CLIENT_ID
echo  $AUTH0_REALM

curl --request POST \
  --url 'https://runai-prod.auth0.com/oauth/token' \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data grant_type='http://auth0.com/oauth/grant-type/password-realm' \
  --data username=$RUNAI_USERNAME \
  --data password=$RUNAI_PASSWORD \
  --data audience='https://api.run.ai' \
  --data scope=read:sample \
  --data 'client_id='$AUTH0_CLIENT_ID'' \
  --data realm=runaidemo > /tmp/runai-token-data

BEARER=$(eval cat /tmp/runai-token-data | jq -r '.access_token')

echo $BEARER

# **** Verify that there are no clusters

curl -X GET 'https://app.run.ai/v1/k8s/clusters' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer '$BEARER'' > /tmp/runai-clusters


if [ $(eval cat /tmp/runai-clusters | jq '. | length') -ne 0 ]; then
	echo "One or more clusters already exist. Browse to https://app.run.ai, delete the cluster and re-run this script"
	exit 1
fi



# **** Create a cluster
curl -X POST 'https://app.run.ai/v1/k8s/clusters' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer '$BEARER'' \
--data '{ "name": "'$CLUSTER_NAME'"}' > /tmp/runai-cluster-data

CLUSTER_UUID=$(eval cat /tmp/runai-cluster-data | jq -r '.uuid')


# **** Download a cluster operator install file
curl 'https://app.run.ai/v1/k8s/clusters/'$CLUSTER_UUID'/installfile?cloud=op' \
--header 'Authorization: Bearer '$BEARER'' > runai-operator-$CLUSTER_NAME.yaml


# **** disable local-path-provisioner (minikube already has a default)
sed 's/grafanaLab:/local-path-provisioner:\
    enabled: false\
  &/' runai-operator-$CLUSTER_NAME.yaml > runai-operator-$CLUSTER_NAME-mod.yaml


# **** Install Run:AI (running twice overcome a possible race condition bug)
kubectl apply -f runai-operator-$CLUSTER_NAME-mod.yaml
kubectl apply -f runai-operator-$CLUSTER_NAME-mod.yaml


# **** Wait on Run:AI cluster installation progress 
echo -e "${GREEN}Run:AI cluster installation is now in progress. ${NC}"

sleep 15
until [ "$(kubectl get pods -n runai --field-selector=status.phase!=Running  2> /dev/null)" = "" ] && [ $(kubectl get pods -n runai | wc -l) -gt 10 ]; do
    printf '.'
    sleep 5
done

printf "\n\n"
echo -e "${GREEN}Congratulations, The single-node Run:AI cluster is now active ${NC}".
printf "\n"
echo  "Next steps: "
echo  "- Navigate to the administration console at https://app.run.ai."
echo -e  "- Use the Run:AI Quickstart Guides (https://bit.ly/2Hmby08) to learn how to run workloads. ${NC}"






