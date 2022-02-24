# Requires Auth0 grant type connection to be added 'password' (automated). 
if [ "$#" -ne 3 ]; then
    echo "Usage: install-cluster.sh tenant email password"
    exit 1
fi


GREEN='\033[0;32m'
NC='\033[0m'

RUNAI_TENANT=$1
RUNAI_USERNAME=$2
RUNAI_PASSWORD=$3
RUNAI_URL=$RUNAI_TENANT.run.ai
CLUSTER_NAME=cluster1
MY_USER=$SUDO_USER



# install utils
echo -e "${GREEN} Installing Utilities ${NC}"
sudo apt update
#sudo apt-get install -y conntrack
sudo apt-get install jq -y


# # **** Docker ****
# if ! type docker > /dev/null; then
# 	echo -e "${GREEN} Installing Docker ${NC}"
# 	curl -fsSL https://get.docker.com -o get-docker.sh
# 	sudo sh get-docker.sh
# fi

# # **** remove sudo constraint for docker 
# sudo usermod -aG docker $USER

# if groups | grep "docker" &> /dev/null; then
#    echo "user belongs to docker group."
# else
#    echo  -e "${GREEN} Logout and login again to have docker group changes take affect. Then re-run the single-node-install.sh script${NC}"
#    exit 0
# fi

# sudo systemctl restart docker




# **** Install Kubectl **** 
# TODO: +++ Look into codyfing a specific k8s version
# if ! type kubectl > /dev/null; then
# 	echo -e "${GREEN} Installing Kubectl ${NC}"
# 	sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
# 	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# 	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
# 	sudo apt-get update
# 	sudo apt-get install -y kubectl
# fi


sudo snap install microk8s --classic --channel=1.23/stable
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
su - $USER
microk8s enable gpu
alias kubectl='microk8s kubectl'


# **** install Run:AI CLI
if ! type runai > /dev/null; then
	echo -e "${GREEN} Installing Run:AI CLI ${NC}"
	#intentionally overriding other helm versions in case helm 2 exists. 
	mkdir runai && cd runai
	wget https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz
	tar xvf helm-v3.3.4-linux-amd64.tar.gz
	sudo mv linux-amd64/helm /usr/local/bin/
	wget https://github.com/run-ai/runai-cli/releases/download/v2.2.77/runai-cli-v2.2.77-linux-amd64.tar.gz
	tar xvf runai-cli-v2.2.77-linux-amd64.tar.gz
	sudo ./install-runai.sh
	sudo runai update
	cd ..
fi

# # **** install minikube
# echo -e "${GREEN} Installing minikube ${NC}"
# curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# sudo install minikube-linux-amd64 /usr/local/bin/minikube

# # **** GPU minikube startup. Using https://minikube.sigs.k8s.io/docs/tutorials/nvidia_gpu/#using-the-none-driver
# echo -e "${GREEN} Starting Kubernetes... ${NC}"
# minikube start --driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost --kubernetes-version=1.20.5
# sudo chown -R $MY_USER ~/.kube ~/.minikube


# *** Install NVIDIA GPU Operator
#helm install --wait --generate-name -n gpu-operator --create-namespace nvidia/gpu-operator

# *** Log into Run:AI
curl https://$RUNAI_URL/v1/k8s/tenantFromEmail/$RUNAI_USERNAME > /tmp/runai-auth-data.txt
CLIENT_ID=$(eval cat /tmp/runai-auth-data.txt | jq -r '.authClientID')
REALM=$(eval cat /tmp/runai-auth-data.txt | jq -r '.authRealm')

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
  --data 'client_id='$CLIENT_ID'' \
  --data realm=$REALM > /tmp/runai-token-data.txt

BEARER=$(eval cat /tmp/runai-token-data.txt | jq -r '.access_token')

echo $BEARER

# **** Verify that there are no clusters

curl -X GET 'https://app.run.ai/v1/k8s/clusters' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer '$BEARER'' > /tmp/runai-clusters.txt

# **** Is there an existing cluster?

if [ $(eval cat /tmp/runai-clusters.txt | jq '. | length') -ne 0 ]; then

	# **** A cluster exists, perhaps is our cluster from a re-run of this script?
	if [ $(eval cat /tmp/runai-clusters.txt | jq '. | length') -eq 1 ] && [ $(eval cat /tmp/runai-clusters.txt | jq '.[0]'.name) = \"$CLUSTER_NAME\" ]; then
		CLUSTER_UUID=$(eval cat /tmp/runai-clusters.txt | jq  -r  '.[0].uuid')	
	else
		echo "One or more Clusters already exist. Browse to https://app.run.ai/clusters, delete the Cluster(s) and re-run this script"
		exit 1
	fi

else
	# **** Create a cluster
	curl -X POST 'https://app.run.ai/v1/k8s/clusters' \
	--header 'Accept: application/json' \
	--header 'Content-Type: application/json' \
	--header 'Authorization: Bearer '$BEARER'' \
	--data '{ "name": "'$CLUSTER_NAME'"}' > /tmp/runai-cluster-data.txt

	CLUSTER_UUID=$(eval cat /tmp/runai-cluster-data.txt | jq -r '.uuid')
fi


# **** Download a cluster operator values file
curl 'https://app.run.ai/v1/k8s/clusters/'$CLUSTER_UUID'/installfile?cloud=op' \
--header 'Authorization: Bearer '$BEARER'' > runai-values-$CLUSTER_NAME.yaml



# **** Install Run:AI 
echo -e "${GREEN} Installing Run:AI Cluster ${NC}"

helm repo add runai https://run-ai-charts.storage.googleapis.com
helm repo update

helm install runai-cluster runai/runai-cluster -n runai --create-namespace -f runai-values-$CLUSTER_NAME.yaml
 


# **** Wait on Run:AI cluster installation progress 
echo -e "${GREEN}Run:AI cluster installation is now in progress. If this process continues beyond 10 minutes, stop it and send /tmp/runai* files to support@run.ai ${NC}"

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






