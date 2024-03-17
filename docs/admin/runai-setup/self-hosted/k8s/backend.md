
# Install the Run:ai Control Plane 


## Domain certificate

You must provide the [domain's](prerequisites.md#domain-name) private key and crt as a Kubernetes secret in the `runai-backend` namespace. Run: 

```
kubectl create secret tls runai-backend-tls -n runai-backend \
    --cert /path/to/fullchain.pem --key /path/to/private.pem
```
## Install the Control Plane

Run the helm command below:


=== "Connected"
    ``` bash
    helm repo add runai-backend https://runai.jfrog.io/artifactory/cp-charts-prod
    helm repo update
    helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane \
        --set global.domain=<DOMAIN>  # (1)
    ```
    
    1. Domain name described [here](prerequisites.md#domain-name). 

    !!! Info
        To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-backend`.

=== "Airgapped"
    ``` bash
    helm upgrade -i runai-backend control-plane-<VERSION>.tgz  \ # (1)
        --set global.domain=<DOMAIN>  # (2)
        -n runai-backend -f custom-env.yaml  # (3)
    ```
       
    1. Replace `<VERSION>` with the Run:ai control plane version.
    2. Domain name described [here](prerequisites.md#domain-name). 
    3. `custom-env.yaml` should have been created by the _prepare installation_ script in the previous section. 

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. 

## (Air-gapped only) Local Certificate Authority

Perform the instructions for [local certificate authority](../../config/org-cert.md). 


## (Optional) Additional Configurations
### Helm values
There may be cases where you need to set additional properties as follows:

|  Key     | Change   | Description |
|----------|----------|-------------| 
| `keycloakx.adminUser` | User name of the internal identity provider administrator | This user is the administrator of Keycloak | 
| `keycloakx.adminPassword` | Password of the internal identity provider administrator | This password is for the administrator of Keycloak | 
| `global.ingress.ingressClass` |  Ingress class  |  Run:ai default is using NGINX. If your cluster has a different ingress controller, you can configure the ingress class to be created by Run:ai |
| `global.ingress.tlsSecretName`  | TLS secret name  | Run:ai requires the creation of a secret with domain certificate. See [above](#domain-certificate). If the `runai-backend` namespace already had such a secret, you can set the secret name here  |
| `global.postgresql.auth.username`  | PostgreSQL username | Override the Run:ai default user name for the Run:ai database  |
| `global.postgresql.auth.password`  | PostgreSQL password | Override the Run:ai default password for the Run:ai database  |
| `global.postgresql.auth.port`  | PostgreSQL port | Override the default PostgreSQL port for the Run:ai database  |
| `grafana.adminUser`  | Grafana username  |   Override the Run:ai default user name for accessing Grafana |
| `grafana.adminPassword`  | Grafana password  |   Override the Run:ai default password for accessing Grafana |
| `thanos.receive.persistence.storageClass` and `postgresql.primary.persistence.storageClass` | Storage class | The installation to work with a specific storage class rather than the default one |
| `<component>` <br> &ensp;`resources:` <br> &emsp; `limits:` <br> &emsp; &ensp; `cpu: 500m` <br> &emsp; &ensp; `memory: 512Mi` <br> &emsp; `requests:` <br> &emsp; &ensp; `cpu: 250m` <br> &emsp; &ensp; `memory: 256Mi`  | Pod request and limits  |  `<component>` may be anyone of the following: `backend`, `frontend`, `assetsService`, `identityManager`, `tenantsManager`, `keycloakx`, `grafana`, `authorization`, `orgUnitService`,`policyService`  |   
|<div style="width:200px"></div>| | |

Use the `--set` syntax in the helm command above.  

#### Custom docker registry credentials 
To access the organization's docker registry it is required to set the registry's credentials (imagePullSecret).

Create the secret named `runai-reg-creds` based on your existing credentials. For more information, see [Create a Secret based on existing credentials](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#registry-secret-existing-credentials){target=_blank}.

### Connect to Run:ai User Interface

Go to: `runai.<company-name>`. Log in using the default credentials: User: `test@run.ai`, Password: `Abcd!234`. Go to the Users area and change the password. 


## (Optional) Enable "Forgot password"

To support the “Forgot password” functionality, follow the steps below.

* Go to `runai.<company-name>/auth` and Log in. 
* Under `Realm settings`, select the `Login` tab and enable the `Forgot password` feature.
* Under the `Email` tab, define an SMTP server, as explained [here](https://www.keycloak.org/docs/latest/server_admin/#_email){target=_blank}

## Next Steps

Continue with installing a [Run:ai Cluster](cluster.md).

