# Install the Run:ai Administrator Command-line Interface

The Run:ai Administrator Command-line Interface (Administrator CLI) allows performing administrative tasks on the Run:ai Cluster.  

The instructions below will guide you through the process of installing the Administrator CLI.

## Prerequisites

*   Run:ai Administrator CLI runs on Mac and Linux.   
*   Kubectl (Kubernetes command-line interface) is installed and configured to access your cluster. Please refer to [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/){target=_blank}
*   A Kubernetes configuration file obtained from a computer previously connected to the Kubernetes cluster


## Kubernetes Configuration

The Run:ai Administrator CLI requires a Kubernetes profile with cluster administrative rights. 


## Installation

Download the Run:ai Administrator Command-line Interface by running:
 
=== "Mac"
    ``` bash
    wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/darwin
    chmod +x runai-adm
    sudo mv runai-adm /usr/local/bin/runai-adm
    ```

=== "Linux"
    ``` bash
    wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/linux
    chmod +x runai-adm
    sudo mv runai-adm /usr/local/bin/runai-adm
    ```

To verify the installation run:

```
runai-adm version
```

### Download a specific version

To download a specific version of `runai-adm` add the version number to URL. For example:

```
wget --content-disposition https://app.run.ai/v1/k8s/admin-cli/v2.7.22/darwin
```
## Updating the Run:ai Administrator CLI

To update the CLI to the latest version perform the same install process again. The command `runai-adm update` is no longer supported.
