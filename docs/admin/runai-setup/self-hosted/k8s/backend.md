
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
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane \
        --set global.domain=<DOMAIN>  # (1)
    ```

    1. Domain name described [here](prerequisites.md#domain-name). 

    !!! Info
        To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-backend`.

=== "Airgapped"
    ``` bash
    helm upgrade -i runai-backend runai-backend-<VERSION>.tgz -n  \ # (2)
        runai-backend --set global.domain=<DOMAIN>  # (1)
    ```


    1. Replace `<DOMAIN>` with the domain name described [here](prerequisites.md#domain-name). 
    2. Replace `<VERSION>` with the Run:ai control plane version


!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. 


## (Optional) Additional Configurations

There may be cases where you need to set additional properties as follows:

|  Key     | Change   | Description |
|----------|----------|-------------| 
| `keycloakx.adminUser` | User name of the internal identity provider administrator | This user is the administrator of Keycloak | 
| `keycloakx.adminPassword` | Password of the internal identity provider administrator | This password is for the administrator of Keycloak | 

Use the `--set` syntax in the helm command above.  

### Connect to Run:ai User Interface

Go to: `runai.<company-name>`. Log in using the default credentials: User: `test@run.ai`, Password: `Abcd!234`. Go to the Users area and change the password. 


## (Optional) Enable "Forgot password"

To support the “Forgot password” functionality, follow the steps below.

* Go to `runai.<company-name>/auth` and Log in. 
* Under `Realm settings`, select the `Login` tab and enable the `Forgot password` feature.
* Under the `Email` tab, define an SMTP server, as explained [here](https://www.keycloak.org/docs/latest/server_admin/#_email){target=_blank}

## Next Steps

Continue with installing a [Run:ai Cluster](cluster.md).

