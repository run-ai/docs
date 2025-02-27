# Advanced control plane configurations

## Additional Run:ai configurations (optional)

There may be cases where you need to set additional properties, To apply the changes run `helm upgrade` and use `--set` to set specific configurations, and restart the relevant Run:ai pods so they can fetch the new configurations.

<table><thead><tr><th width="155">Key</th><th>Change</th><th>Description</th><th>Applicable for</th></tr></thead><tbody><tr><td><code>global.ingress.ingressClass</code></td><td>Ingress class</td><td>Run:ai default is using NGINX. If your cluster has a different ingress controller, you can configure the ingress class to be created by Run:ai</td><td>Kubernetes</td></tr><tr><td><code>global.ingress.tlsSecretName</code></td><td>TLS secret name</td><td>Run:ai requires the creation of a secret with <a href="../installation/preparations.md#domain-certificate">domain certificate</a>. If the <code>runai-backend</code> namespace already had such a secret, you can set the secret name here</td><td>Kubernetes</td></tr><tr><td><code>&#x3C;component></code><br> <code>resources:</code><br>  <code>limits:</code><br>    <code>cpu: 500m</code><br>    <code>memory: 512Mi</code><br>  <code>requests:</code><br>    <code>cpu: 250m</code><br>    <code>memory: 256Mi</code></td><td>Pod request and limits</td><td>Set Run:ai and 3rd party services' resources</td><td>Kubernetes and OpenShift</td></tr><tr><td><code>disableIstioSidecarInjection.enabled</code></td><td>Disable Istio sidecar injection</td><td>Disable the automatic injection of Istio sidecars across the entire Run:ai Control Plane services.</td><td>OpenShift and Kubernetes</td></tr><tr><td><code>global.affinity</code></td><td>System nodes</td><td>Sets the system nodes where the Run:ai control plane services are scheduled.</td><td>Kubernetes</td></tr></tbody></table>

## Additional 3rd party configurations (optional)

The Run:ai Control Plane chart, includes multiple sub-charts of 3rd party components:

* [PostgreSQL](https://artifacthub.io/packages/helm/bitnami/postgresql) - Data store
* [Thanos](https://artifacthub.io/packages/helm/bitnami/thanos) - Metrics Store
* [Keycloakx](https://artifacthub.io/packages/helm/codecentric/keycloakx) - Identity & Access Management
* [Grafana](https://artifacthub.io/packages/helm/grafana/grafana) - Analytics Dashboard
* [Redis](https://artifacthub.io/packages/helm/bitnami/redis) - Caching (Disabled, by default)

{% hint style="info" %}
Click on any component, to view it's chart values and configurations.
{% endhint %}

If you have opted to connect to an [external PostgreSQL database](../installation/preparations.md#external-postgres-database-optional), refer to the additional configurations table below. Adjust the following parameters based on your connection details:

1. Disable PostgreSQL deployment - `postgresql.enabled`
2. Run:ai connection details - `global.postgresql.auth`
3. Grafana connection details - `grafana.dbUser`, `grafana.dbPassword`

### PostgreSQL

<table><thead><tr><th width="184">Key</th><th>Change</th><th>Description</th></tr></thead><tbody><tr><td><code>postgresql.enabled</code></td><td>PostgreSQL installation</td><td>If set to <code>false</code> the PostgreSQL will not be installed</td></tr><tr><td><code>global.postgresql.auth.host</code></td><td>PostgreSQL host</td><td>Hostname or IP address of the PostgreSQL server</td></tr><tr><td><code>global.postgresql.auth.port</code></td><td>PostgreSQL port</td><td>Port number on which PostgreSQL is running</td></tr><tr><td><code>global.postgresql.auth.username</code></td><td>PostgreSQL username</td><td>Username for connecting to PostgreSQL</td></tr><tr><td><code>global.postgresql.auth.password</code></td><td>PostgreSQL password</td><td>Password for the PostgreSQL user specified by <code>global.postgresql.auth.username</code></td></tr><tr><td><code>global.postgresql.auth.postgresPassword</code></td><td>PostgreSQL default admin password</td><td>Password for the built-in PostgreSQL superuser (<code>postgres</code>)</td></tr><tr><td><code>global.postgresql.auth.existingSecret</code></td><td>Postgres Credentials (secret)</td><td>Existing secret name with authentication credentials</td></tr><tr><td><code>global.postgresql.auth.dbSslMode</code></td><td>Postgres connection SSL mode</td><td>Set the SSL mode, see list in <a href="https://www.postgresql.org/docs/current/libpq-ssl.html#LIBPQ-SSL-PROTECTION">Protection Provided in Different Modes</a>, <code>prefer</code> mode is not supported</td></tr><tr><td><code>postgresql.primary.initdb.password</code></td><td>PostgreSQL default admin password</td><td>Set the same password as in <code>global.postgresql.auth.postgresPassword</code> (if changed)</td></tr><tr><td><code>postgresql.primary.persistence.storageClass</code></td><td>Storage class</td><td>The installation to work with a specific storage class rather than the default one</td></tr></tbody></table>

### Thanos

{% hint style="info" %}
This applies for Kubernetes only.
{% endhint %}

| Key                                       | Change        | Description                                                                        |
| ----------------------------------------- | ------------- | ---------------------------------------------------------------------------------- |
| `thanos.receive.persistence.storageClass` | Storage class | The installation to work with a specific storage class rather than the default one |

### Keycloakx

| Key                        | Change                                                    | Description                                                                                                                  |
| -------------------------- | --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `keycloakx.adminUser`      | User name of the internal identity provider administrator | This user is the administrator of Keycloak                                                                                   |
| `keycloakx.adminPassword`  | Password of the internal identity provider administrator  | This password is for the administrator of Keycloak                                                                           |
| `keycloakx.existingSecret` | Keycloakx Credentials (secret)                            | Existing secret name with authentication credentials                                                                         |
| `global.keycloakx.host`    | KeyCloak (Run:ai internal identity provider) host path    | Override the DNS for Keycloak. This can be used to access Keycloak from outside the Run:ai Control Plane cluster via ingress |

The `keycloakx.adminUser` can only be set during the initial installation. The admin password, however, can also be changed later through the Keycloak UI, but you must also update the `keycloakx.adminPassword` value in the Helm chart using helm upgrade. Failing to update the Helm values after changing the password can lead to control plane services encountering errors.

### Grafana

| Key                            | Change                                           | Description                                                 |
| ------------------------------ | ------------------------------------------------ | ----------------------------------------------------------- |
| `grafana.db.existingSecret`    | Grafana database connection credentials (secret) | Existing secret name with authentication credentials        |
| `grafana.dbUser`               | Grafana database username                        | Username for accessing the Grafana database                 |
| `grafana.dbPassword`           | Grafana database password                        | Password for the Grafana database user                      |
| `grafana.admin.existingSecret` | Grafana admin default credentials (secret)       | Existing secret name with authentication credentials        |
| `grafana.adminUser`            | Grafana username                                 | Override the Run:ai default user name for accessing Grafana |
| `grafana.adminPassword`        | Grafana password                                 | Override the Run:ai default password for accessing Grafana  |

### Redis

| Key                              | Change                                                      | Description                                          |
| -------------------------------- | ----------------------------------------------------------- | ---------------------------------------------------- |
| `redisCache.auth.password`       | Redis (Runai internal cache mechanism) applicative password | Override the default password                        |
| `redisCache.auth.existingSecret` | Redis credentials (secret)                                  | Existing secret name with authentication credentials |
