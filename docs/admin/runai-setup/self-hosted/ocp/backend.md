# Install the Run:ai Control Plane

## Install the Control Plane

Run the helm command below:

=== "Connected"
    ``` bash
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane \ 
        --set global.domain=runai.apps.<OPENSHIFT-CLUSTER-DOMAIN> \ # (1)
        --set global.config.kubernetesDistribution=openshift \
        --set backend.config.openshiftIdpFirstAdmin=<FIRST_ADMIN_USER_OF_RUNAI>  # (2)
    ```

    1. The subdomain configured for the OpenShift cluster.
    2. Name of the administrator user in the company directory.

    !!! Info
        To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-backend`.

=== "Airgapped"
    ``` bash
    helm upgrade -i runai-backend  ./runai-backend-<version>.tgz -n runai-backend \ 
        --set global.domain=runai.apps.<OPENSHIFT-CLUSTER-DOMAIN> \ # (1)
        --set global.config.kubernetesDistribution=openshift \
        --set backend.config.openshiftIdpFirstAdmin=<FIRST_ADMIN_USER_OF_RUNAI>  # (2)
    ```

    1. The domain configured for the OpenShift cluster. To find out the OpenShift cluster domain, run `oc get routes -A`
    2. Name of the administrator user in the company directory.

    (replace `<version>` with the control plane version)


!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. 


## (Optional) Additional Configurations

There may be cases where you need to set additional properties as follows:

|  Key     | Change   | Description |
|----------|----------|-------------| 
| `keycloakx.adminUser` | User name of the internal identity provider administrator | This user is the administrator of Keycloak | 
| `keycloakx.adminPassword` | Password of the internal identity provider administrator | This password is for the administrator of Keycloak | 
| `global.postgresql.auth.username`  | PostgreSQL username | Override the Run:ai default user name for the Run:ai database  |
| `global.postgresql.auth.password`  | PostgreSQL password | Override the Run:ai default password for the Run:ai database  |
| `grafana.adminUser`  | Grafana username  |   Override the Run:ai default user name for accessing Grafana |
| `grafana.adminPassword`  | Grafana password  |   Override the Run:ai default password for accessing Grafana |
| `global.imagePullSecrets:` <br> &ensp; `- name: <secret-name>`  | Docker secret | Provide credentials for accessing the organization's docker registry. This is required for air-gapped environments  |
| `<component>` <br> &ensp;`resources:` <br> &emsp; `limits:` <br> &emsp; &ensp; `cpu: 500m` <br> &emsp; &ensp; `memory: 512Mi` <br> &emsp; `requests:` <br> &emsp; &ensp; `cpu: 250m` <br> &emsp; &ensp; `memory: 256Mi`  | Pod request and limits  |  `<component>` may be anyone of the following: `backend`, `frontend`, `assetsService`, `identityManager`, `tenantsManager`, `keycloakx`, `grafana`, `authorization`, `orgUnitService`,`policyService`  |   
|<div style="width:200px"></div>| | |Use the `--set` syntax in the helm command above.  

## Connect to Run:ai User Interface

* Run: `oc get routes -n runai-backend` to find the Run:ai Administration User Interface URL. 
* Log in using the default credentials: User: `test@run.ai`, Password: `Abcd!234`. 
* Go to the Users area and change the password. 

## Next Steps

Continue with installing a [Run:ai Cluster](cluster.md).
