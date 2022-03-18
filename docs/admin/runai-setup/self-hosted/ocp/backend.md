# Install the Run:AI Control Plane (Backend) 

## Create a Control Plane Configuration

Create a configuration file to install the Run:AI control plane:

=== "Connected"
    Generate a values file by running:
    ```
    runai-adm generate-values --openshift
    ```

=== "Airgapped"
    Generate a values file by running the following __under the `deploy` folder__:
    ```
    runai-adm generate-values --openshift --airgapped
    ```

A file called `runai-backend-values.yaml` will be created.

## Edit Configuration File

If you are using OpenShift as your identity provider, you must edit the above file to configure Run:AI to use it:

* Change `backend.openshiftIdp.enabled` to true
* Under `backend.openshiftIdpfirstAdmin`, provide the first administrator user of Run:AI. 


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
