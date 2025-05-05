# Install the Run:ai Control Plane

## Prerequisites and preparations

Make sure you have followed the Control Plane [prerequisites](./prerequisites.md) and [preparations](./preparations.md).

## Helm Install

Run the helm command below:

=== "Connected"
    ``` bash
    helm repo add runai-backend https://runai.jfrog.io/artifactory/cp-charts-prod
    helm repo update
    helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane --version "~2.19.0" \
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
| `<component>` <br> &ensp;`resources:` <br> &emsp; `limits:` <br> &emsp; &ensp; `cpu: 500m` <br> &emsp; &ensp; `memory: 512Mi` <br> &emsp; `requests:` <br> &emsp; &ensp; `cpu: 250m` <br> &emsp; &ensp; `memory: 256Mi`  | Pod request and limits  |  Set Run:ai and 3rd party services' resources  |\
| `disableIstioSidecarInjection.enabled` | Disable Istio sidecar injection | Disable the automatic injection of Istio sidecars across the entire Run:ai Control Plane services. | 
|<div style="width:200px"></div>| | |

## Additional Third-Party Configurations

The Run:ai control plane chart includes multiple sub-charts of third-party components:

* Data store  - [PostgreSQL](https://artifacthub.io/packages/helm/bitnami/postgresql) (`postgresql`)
* Identity & Access Management  - [Keycloakx](https://artifacthub.io/packages/helm/codecentric/keycloakx) (`keycloakx`)
* Analytics Dashboard  - [Grafana](https://artifacthub.io/packages/helm/grafana/grafana) (`grafana`)
* Caching  - [KeyDB](https://artifacthub.io/packages/helm/bitnami/keydb) (`redisCache`)
* Queue  - [KeyDB](https://artifacthub.io/packages/helm/bitnami/keydb) (`redisQueue`)

!!! Tip
    Click on any component to view its chart values and  configurations.

### PostgreSQL

If you have opted to connect to an [external PostgreSQL database](./prerequisites.md#external-postgresql-database-optional), refer to the additional configurations table below. Adjust the following parameters based on your connection details:

1. Disable PostgreSQL deployment - `postgresql.enabled`
2. Run:ai connection details - `global.postgresql.auth`
3. Grafana connection details - `grafana.dbUser`, `grafana.dbPassword`

| Key                                           | Change                            | Description                                                                                                                                                                                   |
| --------------------------------------------- | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `postgresql.enabled`                          | PostgreSQL installation           | If set to `false`, PostgreSQL will not be installed.                                                                                                                                          |
| `global.postgresql.auth.host`                 | PostgreSQL host                   | Hostname or IP address of the PostgreSQL server.                                                                                                                                              |
| `global.postgresql.auth.port`                 | PostgreSQL port                   | Port number on which PostgreSQL is running.                                                                                                                                                   |
| `global.postgresql.auth.username`             | PostgreSQL username               | Username for connecting to PostgreSQL.                                                                                                                                                        |
| `global.postgresql.auth.password`             | PostgreSQL password               | Password for the PostgreSQL user specified by `global.postgresql.auth.username`.                                                                                                              |
| `global.postgresql.auth.postgresPassword`     | PostgreSQL default admin password | Password for the built-in PostgreSQL superuser (`postgres`).                                                                                                                                  |
| `global.postgresql.auth.existingSecret`       | Postgres Credentials (secret)     | Existing secret name with authentication credentials.                                                                                                                                         |
| `global.postgresql.auth.dbSslMode`            | Postgres connection SSL mode      | Set the SSL mode. See the full list in [Protection Provided in Different Modes](https://www.postgresql.org/docs/current/libpq-ssl.html#LIBPQ-SSL-PROTECTION). `Prefer` mode is not supported. |
| `postgresql.primary.initdb.password`          | PostgreSQL default admin password | Set the same password as in `global.postgresql.auth.postgresPassword` (if changed).                                                                                                           |
| `postgresql.primary.persistence.storageClass` | Storage class                     | The installation is configured to work with a specific storage class instead of the default one.                                                                                              |

### Keycloakx

The `keycloakx.adminUser` can only be set during the initial installation. The admin password can be changed later through the Keycloak UI, but you must also update the `keycloakx.adminPassword` value in the Helm chart using helm upgrade. Failing to update the Helm values after changing the password can lead to control plane services encountering errors.

| Key                        | Change                                                        | Description                                                                                           |
| -------------------------- | ------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `keycloakx.adminUser`      | User name of the internal identity provider administrator     | This user is the administrator of Keycloak.                                                           |
| `keycloakx.adminPassword`  | Password of the internal identity provider administrator      | This password is for the administrator of Keycloak.                                                   |
| `keycloakx.existingSecret` | Keycloakx Credentials (secret)                                | Existing secret name with authentication credentials.                                                 |
| `global.keycloakx.host`    | KeyCloak (Run:ai internal identity provider) host path | Override the DNS for Keycloak. This can be used to access access Keycloack externally to the cluster. |

### Grafana

| Key                            | Change                                           | Description                                                         |
| ------------------------------ | ------------------------------------------------ | ------------------------------------------------------------------- |
| `grafana.db.existingSecret`    | Grafana database connection credentials (secret) | Existing secret name with authentication credentials.               |
| `grafana.dbUser`               | Grafana database username                        | Username for accessing the Grafana database.                        |
| `grafana.dbPassword`           | Grafana database password                        | Password for the Grafana database user.                             |
| `grafana.admin.existingSecret` | Grafana admin default credentials (secret)       | Existing secret name with authentication credentials.               |
| `grafana.adminUser`            | Grafana username                                 | Override the Run:ai default user name for accessing Grafana. |
| `grafana.adminPassword`        | Grafana password                                 | Override the Run:ai default password for accessing Grafana.  |

### KeyDB (Redis)

!!! Note
    redisCache is disabled by default.

| Key                              | Change                                                             | Description                                           |
| -------------------------------- | ------------------------------------------------------------------ | ----------------------------------------------------- |
| `redisCache.auth.password`       | Redis (Run:ai internal cache mechanism) applicative password | Override the default password.                        |
| `redisCache.auth.existingSecret` | Redis credentials (secret)                                         | Existing secret name with authentication credentials. |

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
