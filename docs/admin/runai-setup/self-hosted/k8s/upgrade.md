
# Upgrade Run:AI 

## Preparations

=== "Airgapped" 
    * Ask for a tar file `runai-air-gapped-<new-version>.tar` from Run:AI customer support. The file contains the new version you want to upgrade to. `new-version` is the updated version of the Run:AI backend.
    * Prepare the installation artifact as described [here](../preparations/#prepare-installation-artifacts) (untar the file and run the script to upload it to the local container registry). 

=== "Connected"
    No additional work


## Upgrade Backend 

Run the helm command below. The purpose of the `--reuse-values` flag is to use the same values as the original installation:

=== "Airgapped"
    ```
    helm install runai-backend runai-backend/runai-backend-<version>.tgz -n \
        runai-backend  --reuse-values
    ```
    (replace `<version>` with the backend version)

=== "Connected"
    ```
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm install runai-backend -n runai-backend runai-backend/runai-backend  \
        --reuse-values
    ```


## Upgrade Cluster 

To upgrade the cluster follow the instructions [here](../../cluster-setup/cluster-upgrade.md).


=== "Airgapped"
    ```
    helm upgrade runai-cluster -n runai runai-cluster-<version>.tgz --reuse-values
    ```
    (replace `<version>` with the cluster version)

=== "Connected"
    ```
    kubectl apply -f https://raw.githubusercontent.com/run-ai/docs/master/updated_crds.yaml
    helm repo update
    helm upgrade runai-cluster runai/runai-cluster -n runai --reuse-values
    ```