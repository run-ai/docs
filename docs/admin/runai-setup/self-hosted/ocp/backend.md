# Install the Run:ai Control Plane (Backend) 

## Create a Control Plane Configuration


!!! Note
    The control-plane installation on Openshift assumes that an identity provider has been configured in OpenShift.

Run: `oc login`. Then create a configuration file to install the Run:ai control plane:

=== "Connected"
    Generate a values file by running:
    ``` bash
    runai-adm generate-values --openshift \
        --first-admin <FIRST_ADMIN_USER_OF_RUNAI> # (1)
    ```

    1. Name of the administrator user in the company directory

=== "Airgapped 2.7"
    Generate a values file by running the following __under the `deploy` folder__:
    ``` bash
    runai-adm generate-values --openshift  \
        --first-admin <FIRST_ADMIN_USER_OF_RUNAI> \ # (1)
        --airgapped
    ```

    1. Name of the administrator user in the company directory

=== "Airgapped 2.8 and above"
    Generate a values file by running the following __under the `deploy` folder__:
    ``` bash
    runai-adm generate-values --openshift  \
        --first-admin <FIRST_ADMIN_USER_OF_RUNAI> \ # (1)
        --registry <docker-registry-address> # (2)
    ```
    
    1. Name of the administrator user in the company directory
    2. Docker Registry address in the form of `NAME:PORT` (do not add `https`):

   
A file called `runai-backend-values.yaml` will be created.


## Upload images (Airgapped only)

Upload images to a local Docker Registry. Set the Docker Registry address in the form of `NAME:PORT` (do not add `https`):

```
export REGISTRY_URL=<Docker Registry address>
```

Run the following script (you must have at least 20GB of free disk space to run): 

```  
sudo -E ./prepare_installation.sh
```

(If docker is configured to [run as non-root](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user){target=_blank} then `sudo` is not required).

## Install the Control Plane

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


## Connect to Run:ai User Interface


Run: `oc get routes -n runai-backend` to find the Run:ai Administration User Interface URL. Log in using the default credentials: User: `test@run.ai`, Password: `Abcd!234`

## Next Steps

Continue with installing a [Run:ai Cluster](cluster.md).
