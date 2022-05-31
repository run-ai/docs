#!/bin/bash
# set -x  #debug script
GREEN='\033[0;32m'
NC='\033[0m'

# install utils
function utils-install {
	echo -e "${GREEN} Installing Utilities ${NC}"
	sudo apt update
	sudo apt-get install jq -y
	#sudo apt-get install -y conntrack

	# **** Install Kubectl **** 	
	# Microk8s has its own kubectl, but we prefer a normal one

	if ! type kubectl > /dev/null; then
		echo -e "${GREEN} Installing Kubectl ${NC}"
		sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
		curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
		echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
		sudo apt-get update
		sudo apt-get install -y kubectl
	fi

	# **** Install Helm ****
	# Microk8s has its own helm, but we prefer a normal one

	if ! type helm > /dev/null; then
		echo -e "${GREEN} Installing Helm ${NC}"

		curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
 		chmod 700 get_helm.sh
 		./get_helm.sh
	fi
}



# *** Install MicroK8s
function microk8s-install {
# https://microk8s.io/docs/getting-started
	if ! type microk8s > /dev/null; then
		sudo snap install microk8s --classic --channel=1.23/stable
		microk8s status --wait-ready

		mkdir .kube
		sudo usermod -a -G microk8s $USER
		sudo chown -f -R $USER ~/.kube

		echo  -e "${GREEN} Logout and login again to have docker group changes take effect. Then re-run the single-node-install.sh script${NC}"
		exit 0
	fi

	microk8s config > .kube/config
	microk8s enable gpu

	echo  -e "${GREEN} Waiting for NVIDIA device drivers to be installed. Setting a 20 minutes timeout. This may take awhile ${NC}"
	sleep 120 # wait for resources to start getting created. 
 	kubectl wait --for=condition=ready  --timeout=1200s pod -n gpu-operator-resources -l app=nvidia-operator-validator
 	echo  -e "${GREEN} NVIDIA device drivers installed ${NC}"

}

# **** install Run:AI CLI
function runai-cli-install {
	if ! type runai > /dev/null; then
		echo -e "${GREEN} Installing Run:AI CLI ${NC}"
		mkdir runai && cd runai		
		wget https://github.com/run-ai/runai-cli/releases/download/v2.3.4/runai-cli-v2.3.4-linux-amd64.tar.gz
		tar xvf runai-cli-v2.3.4-linux-amd64.tar.gz
		sudo ./install-runai.sh
		sudo runai update
		cd ..
	fi
}


# *** Log into Run:AI
function runai-login {

	curl -X POST https://app.run.ai/auth/realms/$RUNAI_TENANT/protocol/openid-connect/token \
	--header 'Content-Type: application/x-www-form-urlencoded' \
	--data-urlencode 'grant_type=client_credentials' \
	--data-urlencode 'scope=openid' \
	--data-urlencode 'response_type=id_token' \
	--data-urlencode 'client_id='$RUNAI_CLIENTID'' \
	--data-urlencode 'client_secret='$RUNAI_SECRET'' > /tmp/runai-auth-data.txt

	BEARER=$(eval cat /tmp/runai-auth-data.txt | jq -r '.access_token')

	if [ -z $BEARER ]; then
	echo "Error on Run:AI login"
	exit 1
	fi
	echo $BEARER
}



function cluster-create {

	# **** Get cluster list
	curl -X GET 'https://'$COMPANY_URL'/v1/k8s/clusters' \
	--header 'Accept: application/json' \
	--header 'Content-Type: application/json' \
	--header 'Authorization: Bearer '$BEARER'' > /tmp/runai-clusters.txt

	# **** Are there  existing clusters?
	if [ $(eval cat /tmp/runai-clusters.txt | jq '. | length') -ne 0 ]; then

		# Clusters already exist. Find our cluster by its name
		cat /tmp/runai-clusters.txt | jq '.[] | select(.name | contains("'$CLUSTER_NAME'"))' > /tmp/runai-our-cluster.txt
		if [ -s /tmp/runai-our-cluster.txt ]; then
        	# Cluster found, get UUID.
			CLUSTER_UUID=$(eval cat /tmp/runai-our-cluster.txt | jq  -r  '.uuid')
			return
		fi
	fi

	# Our cluster does not exist. Need to create it
	curl -X POST 'https://'$COMPANY_URL'/v1/k8s/clusters' \
	--header 'Accept: application/json' \
	--header 'Content-Type: application/json' \
	--header 'Authorization: Bearer '$BEARER'' \
	--data '{ "name": "'$CLUSTER_NAME'"}' > /tmp/runai-cluster-data.txt

	CLUSTER_UUID=$(eval cat /tmp/runai-cluster-data.txt | jq -r '.uuid')

	if [ -z $CLUSTER_UUID ]; then
		echo "Error on cluster creation"
		exit 1
	fi
} 

# **** Download YAML File used to install cluster
function cluster-download {
    CLUSTER_IPS=$(curl ifconfig.me)%2C$(hostname -i)
    echo $CLUSTER_IPS
    
	 # **** Download a cluster operator values file
    curl 'https://'$COMPANY_URL'/v1/k8s/clusters/'$CLUSTER_UUID'/installfile?cloud=op&clusterip='$CLUSTER_IPS'' \
		--header 'Authorization: Bearer '$BEARER'' > runai-values-$CLUSTER_NAME.yaml
}


# **** Install Run:AI 
function cluster-install {
	echo -e "${GREEN} Installing Run:AI Cluster ${NC}"

	helm repo add runai https://run-ai-charts.storage.googleapis.com
	helm repo update

	helm upgrade -i runai-cluster runai/runai-cluster -n runai -f runai-values-$CLUSTER_NAME.yaml --create-namespace
}

## START HERE


if [ "$#" -ne 3 ]; then
    echo "Usage: install-cluster.sh tenant-name clientid secret"
    exit 1
fi

RUNAI_TENANT=$1
RUNAI_CLIENTID=$2
RUNAI_SECRET=$3
COMPANY_URL=$RUNAI_TENANT.run.ai
CLUSTER_NAME=cluster1
MY_USER=$SUDO_USER

utils-install
microk8s-install
runai-cli-install

runai-login

cluster-create
echo $CLUSTER_UUID

cluster-download
cluster-install

## temporary until April 2022
kubectl -n gpu-operator-resources patch daemonset nvidia-device-plugin-daemonset  -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
kubectl -n gpu-operator-resources patch daemonset nvidia-dcgm-exporter -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'


# **** Wait on Run:AI cluster installation progress 
echo -e "${GREEN}Run:AI cluster installation is now in progress. Waiting for sucessful finish for 10 minutes. If not successful, send /tmp/runai* files to support@run.ai ${NC}"

kubectl wait --for=condition=available deploy -n runai --all  --timeout=600s
# sleep 15
# until [ "$(kubectl get pods -n runai --field-selector=status.phase!=Running  2> /dev/null)" = "" ] && [ $(kubectl get pods -n runai | wc -l) -gt 10 ]; do
#     printf '.'
#     sleep 5
# done

printf "\n\n"
echo -e "${GREEN}Congratulations, The single-node Run:AI cluster is now active ${NC}".
printf "\n"
echo  "Next steps: "
echo  "- Navigate to the administration console at https://'$COMPANY_URL'.run.ai."
echo -e  "- Use the Run:AI Quickstart Guides (https://bit.ly/2Hmby08) to learn how to run workloads. ${NC}"





