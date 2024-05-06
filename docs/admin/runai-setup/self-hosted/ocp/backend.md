# Install the Run:ai Control Plane

## Install the Control Plane

Run the helm command below:

=== "Connected"
    ``` bash
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane --version "~2.17.0" \
        --set global.domain=runai.apps.<OPENSHIFT-CLUSTER-DOMAIN> \ # (1)
        --set global.config.kubernetesDistribution=openshift
    ```

    1. The subdomain configured for the OpenShift cluster.

    !!! Info
        To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-backend`.

=== "Airgapped"
    ``` bash
    helm upgrade -i runai-backend  ./control-plane-<version>.tgz -n runai-backend \
        --set global.domain=runai.apps.<OPENSHIFT-CLUSTER-DOMAIN> \ # (1)
        --set global.config.kubernetesDistribution=openshift \
        -f custom-env.yaml  # (2)
    ```

    1. The domain configured for the OpenShift cluster. To find out the OpenShift cluster domain, run `oc get routes -A`
    2. `custom-env.yaml` should have been created by the _prepare installation_ script in the previous section. 

    (replace `<version>` with the control plane version)

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation.


## (Optional) Additional Configurations

There may be cases where you need to set additional properties as follows:

|  Key     | Change   | Description |
|----------|----------|-------------|
| `keycloakx.adminUser` | KeyCloak (Run:ai internal identity provider) administrator username | Override the default user name of the Keycloak administrator user |
| `keycloakx.adminPassword` | KeyCloak (Run:ai internal identity provider) administrator password | Override the default password of the Keycloak administrator user |
| `global.keycloakx.host` |  KeyCloak (Run:ai internal identity provider) host path | Override the DNS for Keycloak. This can be used to access Keycloak from outside the Run:ai Control Plane cluster via ingress | 
| `global.postgresql.auth.port`  | PostgreSQL port | Override the default PostgreSQL port for the Run:ai database  |
| `global.postgresql.auth.username`  | PostgreSQL username | Override the Run:ai default user name for accessing the Run:ai database  |
| `global.postgresql.auth.password`  | PostgreSQL password | Override the Run:ai default password for accessing the Run:ai database  |
| `global.postgresql.auth.postgresPassword`  | PostgreSQL default admin password | Set the password of the admin user created by default by PostgreSQL |
| `postgresql.primary.initdb.password`  | PostgreSQL default admin password | Set the same password as in `global.postgresql.auth.postgresPassword` (if changed) |
| `grafana.adminUser`  | Grafana username  |   Override the Run:ai default user name for accessing Grafana |
| `grafana.adminPassword`  | Grafana password  |   Override the Run:ai default password for accessing Grafana |
| `grafana.dbUser`  | Grafana's username for PostgreSQL  |   Override the Run:ai default user name for Grafana to access Run:ai database (PostgreSQL) |
| `grafana.dbPassword`  | Grafana's password for PostgreSQL |   Override the Run:ai default password for Grafana to access Run:ai database (PostgreSQL) |
| `grafana.grafana.ini.database.user`  | Reference to Grafana's username for PostgreSQL  |  Don't override this value |
| `grafana.grafana.ini.database.password`  | Reference to Grafana's password for PostgreSQL |   Don't override this value |
| `tenantsManager.config.adminUsername`  | Run:ai first admin username |   Override the default user name of the first admin user created with Run:ai |
| `tenantsManager.config.adminPassword`  | Run:ai first admin user's password |   Override the default password of the first admin user created with Run:ai |
| `thanos.receive.persistence.storageClass` and `postgresql.primary.persistence.storageClass` | Storage class | The installation to work with a specific storage class rather than the default one |
| `<component>` <br> &ensp;`resources:` <br> &emsp; `limits:` <br> &emsp; &ensp; `cpu: 500m` <br> &emsp; &ensp; `memory: 512Mi` <br> &emsp; `requests:` <br> &emsp; &ensp; `cpu: 250m` <br> &emsp; &ensp; `memory: 256Mi`  | Pod request and limits  |  `<component>` may be anyone of the following: `backend`, `frontend`, `assetsService`, `identityManager`, `tenantsManager`, `keycloakx`, `grafana`, `authorization`, `orgUnitService`,`policyService`  |
|<div style="width:200px"></div>| | |

Use the `--set` syntax in the helm command above.

!!! Note
    If you modify one of the usernames or passwords (KeyCloak, PostgreSQL, Grafana) after Run:ai is already installed, perform the following steps to apply the change:

    1. Modify the username/password within the relevant component as well (KeyCloak, PostgreSQL, Grafana).
    2. Run `helm upgrade` for Run:ai with the right values, and restart the relevant Run:ai pods so they can fetch the new username/password.

## Next steps

### Connect to Run:ai user interface

* Run: `oc get routes -n runai-backend` to find the Run:ai Administration User Interface URL.
* Log in using the default credentials: User: `test@run.ai`, Password: `Abcd!234`.
* Go to the Users area and change the password.

### Enable Forgot Password (optional)

To support the *Forgot password* functionality, follow the steps below.

* Go to `runai.<openshift-cluster-domain>/auth` and Log in.
* Under `Realm settings`, select the `Login` tab and enable the `Forgot password` feature.
* Under the `Email` tab, define an SMTP server, as explained [here](https://www.keycloak.org/docs/latest/server_admin/#_email){target=_blank}

### Install Run:ai Cluster

Continue with installing a [Run:ai Cluster](cluster.md).
