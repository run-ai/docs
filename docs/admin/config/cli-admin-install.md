# Administrator CLI

The Run:ai Administrator (`runai-adm`) is a lightweight tool designed to support infrastructure administrators by simplifying two key tasks:

* [Collecting logs](../troubleshooting/logs-collection.md) for troubleshooting and sharing with Run:ai support.
* Configuring [node roles](../config/node-roles.md) in the cluster for optimal performance and reliability.

This article outlines the installation and usage of the Run:ai Administrator CLI to help you get started quickly.

## Prerequisites

Before installing the CLI, review the following:

* __Operating system:__ The CLI is supported on Mac and Linux.
* __Kubectl:__ The Kubernetes command-line interface must be installed and configured to access your cluster. Follow the [official guide](https://kubernetes.io/docs/tasks/tools/){target=_blank}.
* __Cluster administrative permissions:__ The CLI requires a Kubernetes profile with administrative privileges.


## Installation

To install the Run:ai Administrator CLI, ensure that the CLI version matches the version of your Run:ai cluster. You can either install the latest version or a specific version from the [list](https://runai.jfrog.io/ui/native/cli/runai-admin-cli/){target=_blank}.

### Installing the latest version

Use the following commands to download and install the latest version of the CLI:
 
=== "Mac"
    ``` bash
    wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/darwin # (1) 
    chmod +x runai-adm  
    sudo mv runai-adm /usr/local/bin/runai-adm
    ```
    
     1. In self-hosted environment, use the control-plane URL instead of `app.run.ai` 

=== "Linux"
    ``` bash
    wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/linux # (1) 
    chmod +x runai-adm  
    sudo mv runai-adm /usr/local/bin/runai-adm
    ```

    1. In self-hosted environment, use the control-plane URL instead of `app.run.ai` 



### Installing a specific version

To install a specific version of the Administrator CLI that matches your Run:ai cluster version, append the version number to the download URL. Refer to the list of available versions linked above for the correct version number.

=== "Mac"
    ``` bash
    wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/<version>/darwin # Replace <version> with the desired version in the format vX.X.X (e.g., v2.19.5) 
    chmod +x runai-adm  
    sudo mv runai-adm /usr/local/bin/runai-adm
    ```

=== "Linux"
    ``` bash
    wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/<version>/linux # Replace <version> with the desired version in the format vX.X.X (e.g., v2.19.5)
    chmod +x runai-adm  
    sudo mv runai-adm /usr/local/bin/runai-adm
    ```

### Verifying installation

Verify your installation completed successfully by running the following command:

``` bash
runai-adm version
```

## Reference

### Node roles

To set or remove node rules using the `runai-adm` tool, run the following:

``` bash
runai-adm set node-role [--runai-system-worker | --gpu-worker | --cpu-worker] <node-name>
```

``` bash
runai-adm remove node-role [--runai-system-worker | --gpu-worker | --cpu-worker] <node-name>
```

!!! Note
    Use the `--all` flag to set or remove a role to all nodes.

### Collect logs

To collect logs using the `runai-adm` tool:

1. Run the following command:

    ``` bash
    runai-adm collect-logs
    ```

2. Locate the generated compressed log file.


