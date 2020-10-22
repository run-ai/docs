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
# {"authClientID":"AKfgFQOsXoduQTyDipzzt...","authRealm":"runaid..."}%                     

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

# {"access_token":"eyJhbG....","scope":"","expires_in":86400,"token_type":"Bearer"}%

# Create a cluster
curl -X POST 'https://app.run.ai/v1/k8s/clusters' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer '$BEARER'' \
--data '{ "name": "'$CLUSTER_NAME'"}' > /tmp/cluster-data

CLUSTER_UUID=$(eval cat /tmp/cluster-data | jq -r '.uuid')

# {"tenantId":3,"name":"ddd","createdAt":"2020-10-21T20:15:29.856Z","uuid":"f89405d5-8af7-4d29-9152-4d64..."

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

echo -e "${GREEN} A Run:AI is being installed."
echo -e "Please allow for a couple of minutes while the cluster comes up. Then review the cluster under https://app.run.ai. Use the Run:AI Quickstart Guides (https://bit.ly/2Hmby08) to start running workloads. ${NC}"






