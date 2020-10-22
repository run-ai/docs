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
echo -e "Navigate to https://app.run.ai and wait for cluster metrics to show."
echo -e "When the system is up, use the Run:AI Quickstart Guides (https://bit.ly/2Hmby08) to learn how to run workloads. ${NC}"






