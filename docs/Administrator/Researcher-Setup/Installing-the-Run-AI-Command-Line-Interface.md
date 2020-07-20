The Run:AI Command-line Interface (CLI) is __one__ of the ways for a researcher to send deep learning workloads, acquire GPU-based containers, list jobs, etc.

The instructions below will guide you through the process of installing the CLI

## Prerequisites

*   Kubectl (Kubernetes command-line interface) installed and configured to access your cluster. Please refer to <a href="https://kubernetes.io/docs/tasks/tools/install-kubectl/" target="_self">https://kubernetes.io/docs/tasks/tools/install-kubectl/</a>
*   Helm. See&nbsp;<https://helm.sh/docs/intro/install/>&nbsp;on how to install Helm. Run:AI works with Helm version 3 only (not helm 2).
*   A Kubernetes configuration file obtained from a computer previously connected to the Kubernetes cluster

## Installation

### Kubernetes Configuration

The Run:AI CLI needs to be connected to the Kubernetes Cluster containing the GPU nodes:

*   Create a directory _.kube_. Copy the Kubernetes configuration file into the directory
*   Create a shell variable to point to the above configuration file. Example:

<pre>export KUBECONFIG=~/.kube/config</pre>

*   Test the connection by running:&nbsp;&nbsp;

<pre>kubectl get nodes</pre>

### Run:AI CLI Installation

*   Download the latest release from the Run:AI releases page&nbsp;<https://github.com/run-ai/runai-cli/releases>
*   Unarchive the downloaded file.
*   Install by running:

    sudo ./install-runai.sh

To verify the installation run:

    runai list

&nbsp;

## Troubleshooting the CLI Installation

See:&nbsp;<a href="https://support.run.ai/hc/en-us/articles/360013119279-Troubleshooting-a-CLI-installation" target="_self">Troubleshooting-a-CLI-installation</a>

## Updating the Run:AI CLI

To update the CLI to the latest version run:

    sudo runai update