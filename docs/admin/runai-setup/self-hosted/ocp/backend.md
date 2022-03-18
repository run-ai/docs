# Install the Run:AI Control Plane (Backend) 

## Create a Control Plane Configuration

Customize the Run:AI backend configuration file.

=== "Connected"
    Generate a values file by running:
    ```
    runai-adm generate-values --openshift
    ```

=== "Airgapped"
    Generate a values file by running the following under the `deploy` folder:
    ```
    runai-adm generate-values --openshift --airgapped
    ```
## Edit Configuration File

__Optional__: Change the following properties in the values file:


|  Replace |   With   | Description | 
|----------|----------|-------------| 
| `backend.initTenant.admin` | Change password for [admin@run.ai](mailto:admin.run.ai) | This user is the master Backend administrator | 
| `backend.initTenant.users` | Change password for [test@run.ai](mailto:test@run.ai) | This user is the first cluster user | 
|<img width=500/>|| 
 
<!-- | `tls.secretName` | name of Kubernetes secret under the runai-backend namespace | Secret contains certificate for `auth.runai.<company-name>` | -->


## Install the Control Plane (Backend)

Run the helm command below:

=== "Connected"
    ```
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm install runai-backend -n runai-backend runai-backend/runai-backend \
        -f runai-backend-values.yaml 
    ```

    !!! Info
        To install a specific version, add `--version <version>` to the install command.

=== "Airgapped"
    ```
    helm install runai-backend runai-backend/runai-backend-<version>.tgz -n \
        runai-backend -f runai-backend-values.yaml 
    ```
    (replace `<version>` with the control plane version)


!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. 


## Connect to Run:AI User Interface


Run: `oc get routes -n runai-backend` to find the Run:AI Administration User Interface URL. Log in using the default credentials: User: `test@run.ai`, Password: `password`

## Next Steps

Continue with installing a [Run:AI Cluster](cluster.md).
