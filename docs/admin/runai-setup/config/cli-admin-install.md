# Install the Run:AI Administrator Command-line Interface

The Run:AI Administrator Command-line Interface (Administrator CLI) allows performing administrative tasks on the Run:AI Cluster.  

The instructions below will guide you through the process of installing the Administrator CLI.

## Prerequisites

*   Run:AI Administrator CLI runs on Mac and Linux.   
*   Kubectl (Kubernetes command-line interface) installed and configured to access your cluster. Please refer to [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/){target=_blank}
*   A Kubernetes configuration file obtained from a computer previously connected to the Kubernetes cluster


## Kubernetes Configuration

The Run:AI Administrator CLI requires a Kubernetes profile with cluster administrative rights. 


## Installation

*   Download the latest release from the Run:AI [releases page](https://github.com/run-ai/runai-admin-cli/releases){target=_blank}
*   Unarchive the downloaded file
*   Install by running:

        sudo ./install-runai.sh

* To verify the installation run:

        runai-adm version



## Updating the Run:AI Administrator CLI

To update the CLI to the latest version run:

    sudo runai-adm update