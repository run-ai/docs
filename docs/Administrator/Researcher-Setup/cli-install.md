# Install the Run:AI Command-line Interface

The Run:AI Command-line Interface (CLI) is __one__ of the ways for a researcher to send deep learning workloads, acquire GPU-based containers, list jobs, etc.

The instructions below will guide you through the process of installing the CLI.

## Prerequisites

*   Run:AI CLI runs on Mac and Linux. 
*   When installing the command-line interface its worth considering future upgrades:
     * Install the CLI on a dedicated _Jumpbox_ machine. Researches will connect to the Jumpbox from which they can submit Run:AI commands
     * Install the CLI on a shared directory that is mounted on Researchers' machines.  

*   Kubectl (Kubernetes command-line interface) installed and configured to access your cluster. Please refer to [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/){target=_blank}
*   Helm. See [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank} on how to install Helm. Run:AI works with Helm version 3 only (not helm 2).
*   A Kubernetes configuration file obtained from a computer previously connected to the Kubernetes cluster

## Researcher Authentication

Researcher authentication requires additional setup on the cluster-side as well as on the client-side. To configure authentication see [Setup Project-based Researcher Access Control](../Cluster-Setup/researcher-authentication.md). As it related to this document, you will need to:

* Install the `kubelogin` utility.
* Use a modified Kubernetes configuration file (one generic file fits all users).

## Kubernetes Configuration

*   Create a directory _.kube_. Copy the Kubernetes configuration file into the directory. 
   *   Each Researcher should have a __separate copy__ of the configuration file (as the file stores user defaults).*   The researcher should have write access to the configuration file. 
*   You can choose to locate the file at a different location. In this case you must create a shell variable to point to the configuration file. Example:

        export KUBECONFIG=~/.kube/config

*   Test the connection by running:

        kubectl get nodes

## Run:AI CLI Installation

*   Download the latest release from the Run:AI [releases page](https://github.com/run-ai/runai-cli/releases){target=_blank}
*   Unarchive the downloaded file
*   Install by running:

        sudo ./install-runai.sh

* To verify the installation run:

        runai list jobs


## Troubleshooting the CLI Installation

See [Troubleshooting a CLI installation](cli-troubleshooting.md)

## Updating the Run:AI CLI

To update the CLI to the latest version run:

    sudo runai update