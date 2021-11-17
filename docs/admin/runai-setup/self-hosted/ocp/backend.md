# Install the Run:AI Backend 

### Set Backend Configuration

Customize the Run:AI backend configuration file.

=== "Airgapped"
    Edit `runai-backend/runai-backend-helm-release.yaml`

=== "Connected"
    Generate a values file by running:
    ```
    runai-adm generate-values --openshift
    ```

## Edit Backend Configuration File

__Optional__: Change the following properties in the values file:


|  Replace |   With   | Description | 
|----------|----------|-------------| 
| `backend.initTenant.admin` | Change password for [admin@run.ai](mailto:admin.run.ai) | This user is the master Backend administrator | 
| `backend.initTenant.users` | Change password for [test@run.ai](mailto:test@run.ai) | This user is the first cluster user | 
|<img width=500/>|| 
 
<!-- | `tls.secretName` | name of Kubernetes secret under the runai-backend namespace | Secret contains certificate for `auth.runai.<company-name>` | -->


## Install Backend

Run the helm command below:


=== "Airgapped"
    ```
    helm install runai-backend runai-backend/runai-backend-<version>.tgz -n \
        runai-backend -f runai-backend/runai-backend-helm-release.yaml 
    ```
    (replace `<version>` with the backend version)

=== "Connected"
    ```
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm install runai-backend -n runai-backend runai-backend/runai-backend \
        -f runai-backend-values.yaml 
    ```

    !!! Info
        To install a specific version, add `--version <version>` to the install command.

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. 


## Connect to Administrator User Interface


Run: `oc get routes -n runai-backend` to find the Run:AI Administration User Interface URL. Log in using the default credentials: User: `test@run.ai`, Password: `password`

## Next Steps

Continue with installing a [Run:AI Cluster](cluster.md).
