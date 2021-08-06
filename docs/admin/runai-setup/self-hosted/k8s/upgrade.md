
# Upgrade Run:AI 

## Prerequisites 

A compressed tar file `runai-air-gapped<new-version>.tar` provided by Run:AI customer support containing the new version you want to upgrade to. `new-version` is the updated version of the Run:AI backend.


## Preparations

Perform the preparation part [here](preparations.md). Specifically, unzip the tar file and use the `prepare_installation.sh` script to re-tag and load the images.


## Upgrade Backend 

Run:

```
helm upgrade runai-backend runai-backend/runai-backend-<new-version>.tgz -n \
    runai-backend --reuse-values
```

The `--reuse-values` flag uses the same values as the original installation.

## Upgrade Cluster 

To upgrade the cluster follow the instructions [here](../../runai-setup/cluster-setup/cluster-upgrade/).