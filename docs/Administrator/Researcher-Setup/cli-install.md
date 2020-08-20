The Run:AI Command-line Interface (CLI) is __one__ of the ways for a researcher to send deep learning workloads, acquire GPU-based containers, list jobs, etc.

The instructions below will guide you through the process of installing the CLI.

## Prerequisites

*   Kubectl (Kubernetes command-line interface) installed and configured to access your cluster. Please refer to <a href="https://kubernetes.io/docs/tasks/tools/install-kubectl/" target="_self">https://kubernetes.io/docs/tasks/tools/install-kubectl/</a>
*   Helm. See <https://helm.sh/docs/intro/install/> on how to install Helm. Run:AI works with Helm version 3 only (not helm 2).
*   A Kubernetes configuration file obtained from a computer previously connected to the Kubernetes cluster

## Installation

### Kubernetes Configuration

The Run:AI CLI needs to be connected to the Kubernetes Cluster containing the GPU nodes:

*   Create a directory _.kube_. Copy the Kubernetes configuration file into the directory
*   Create a shell variable to point to the above configuration file. Example:

        export KUBECONFIG=~/.kube/config

*   Test the connection by running:

        kubectl get nodes

### Run:AI CLI Installation

*   Download the latest release from the Run:AI releases page <https://github.com/run-ai/runai-cli/releases>
*   Unarchive the downloaded file
*   Install by running:

        sudo ./install-runai.sh

* To verify the installation run:

        runai list


## Troubleshooting the CLI Installation

See [Troubleshooting a CLI installation](Troubleshooting-a-CLI-installation.md)

## Updating the Run:AI CLI

To update the CLI to the latest version run:

    sudo runai update