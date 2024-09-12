# Install the Run:ai Control Plane

## Prerequisites and preparations

Make sure you have followed the Control Plane [prerequisites](./prerequisites.md) and [preparations](./preparations.md).

## Helm Install

Run the helm command below:

=== "Connected"
    ``` bash
    helm repo add runai-backend https://runai.jfrog.io/artifactory/cp-charts-prod
    helm repo update
    helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane --version "~2.18.0" \
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
        --set global.customCA.enabled=true \ # (2)
        -f custom-env.yaml  # (3)
    ```

    1. The domain configured for the OpenShift cluster. To find out the OpenShift cluster domain, run `oc get routes -A`
    2. See the Local Certificate Authority instructions below
    3. `custom-env.yaml` should have been created by the _prepare installation_ script in the previous section. 

    (replace `<version>` with the control plane version)

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation.

## Additional Run:ai configurations (optional)

There may be cases where you need to set additional properties,
To apply the changes run `helm upgrade` and use `--set` to set specific configurations, and restart the relevant Run:ai pods so they can fetch the new configurations.

|  Key     | Change   | Description |
|----------|----------|-------------|
| `<component>` <br> &ensp;`resources:` <br> &emsp; `limits:` <br> &emsp; &ensp; `cpu: 500m` <br> &emsp; &ensp; `memory: 512Mi` <br> &emsp; `requests:` <br> &emsp; &ensp; `cpu: 250m` <br> &emsp; &ensp; `memory: 256Mi`  | Pod request and limits  |  Set Run:ai and 3rd party services' resources  |
|<div style="width:200px"></div>| | |

## Additional 3rd party configurations (optional)

The Run:ai Control Plane chart, includes multiple sub-charts of 3rd party components:

* [PostgreSQL](https://artifacthub.io/packages/helm/bitnami/postgresql){target=_blank} - Data store
* [Keycloakx](https://artifacthub.io/packages/helm/codecentric/keycloakx){target=_blank} - Identity & Access Management
* [Grafana](https://artifacthub.io/packages/helm/grafana/grafana){target=_blank} - Analytics Dashboard
* [Redis](https://artifacthub.io/packages/helm/bitnami/redis){target=_blank} - Caching (Disabled, by default)

!!! Tip
    Click on any component, to view it's chart values and configurations

If you have opted to connect to an [external PostgreSQL database](preparations.md#external-postgres-database-optional), refer to the additional configurations table below. Adjust the following parameters based on your connection details:

1. Disable PostgreSQL deployment - `postgresql.enabled`
2. Run:ai connection details - `global.postgresql.auth`
3. Grafana connection details - `grafana.dbUser`, `grafana.dbPassword`

### PostgreSQL

|  Key     | Change   | Description |
|----------|----------|-------------|
| `postgresql.enabled`| PostgreSQL installation | If set to `false` the PostgreSQL will not be installed |
| `global.postgresql.auth.host`  | PostgreSQL host | Hostname or IP address of the PostgreSQL server  |
| `global.postgresql.auth.port`  | PostgreSQL port | Port number on which PostgreSQL is running  |
| `global.postgresql.auth.username`  | PostgreSQL username | Username for connecting to PostgreSQL  |
| `global.postgresql.auth.password`  | PostgreSQL password | Password for the PostgreSQL user specified by `global.postgresql.auth.username`  |
| `global.postgresql.auth.postgresPassword`  | PostgreSQL default admin password | Password for the built-in PostgreSQL superuser (`postgres`)  |
| `global.postgresql.auth.existingSecret`  | Postgres Credentials (secret) | Existing secret name with authentication credentials   |
| `postgresql.primary.initdb.password`  |  PostgreSQL default admin password    | Set the same password as in `global.postgresql.auth.postgresPassword` (if changed) |
| `postgresql.primary.persistence.storageClass` | Storage class | The installation to work with a specific storage class rather than the default one |

### Keycloakx

|  Key     | Change   | Description |
|----------|----------|-------------|
| `keycloakx.adminUser` | User name of the internal identity provider administrator | This user is the administrator of Keycloak |
| `keycloakx.adminPassword` | Password of the internal identity provider administrator | This password is for the administrator of Keycloak |
| `keycloakx.existingSecret`  | Keycloakx credentials (secret) | Existing secret name with authentication credentials   |
| `global.keycloakx.host` |  KeyCloak (Run:ai internal identity provider) host path | Override the DNS for Keycloak. This can be used to access Keycloak from outside the Run:ai Control Plane cluster via ingress |


The `keycloakx.adminUser` can only be set during the initial installation. The admin password, however, can also be changed later through the Keycloak UI, but you must also update the `keycloakx.adminPassword` value in the Helm chart using helm upgrade. Failing to update the Helm values after changing the password can lead to control plane services encountering errors.


### Grafana

|  Key     | Change   | Description |
|----------|----------|-------------|
| `grafana.db.existingSecret`  | Grafana database connection credentials (secret) | Existing secret name with authentication credentials   |
| `grafana.dbUser`  | Grafana database username  | Username for accessing the Grafana database |
| `grafana.dbPassword`  | Grafana database password | Password for the Grafana database user |
| `grafana.admin.existingSecret`  | Grafana admin default credentials (secret) | Existing secret name with authentication credentials   |
| `grafana.adminUser`  | Grafana username  |   Override the Run:ai default user name for accessing Grafana |
| `grafana.adminPassword`  | Grafana password  |   Override the Run:ai default password for accessing Grafana |

### Redis

|  Key     | Change   | Description |
|----------|----------|-------------|
| `redisCache.auth.password` | Redis (Runai internal cache mechanism) applicative password | Override the default password |
| `redisCache.auth.existingSecret`  | Redis credentials (secret) | Existing secret name with authentication credentials   |

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
