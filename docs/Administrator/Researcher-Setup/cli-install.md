# Install the Run:AI Command-line Interface

The Run:AI Command-line Interface (CLI) is __one__ of the ways for a Researcher to send deep learning workloads, acquire GPU-based containers, list jobs, etc.

The instructions below will guide you through the process of installing the CLI.

## Prerequisites

*   Run:AI CLI runs on Mac and Linux. 
*   When installing the command-line interface, its worth considering future upgrades:
     * Install the CLI on a dedicated _Jumpbox_ machine. Researches will connect to the Jumpbox from which they can submit Run:AI commands
     * Install the CLI on a shared directory that is mounted on Researchers' machines.  

*   __Kubectl__ (Kubernetes command-line interface) installed and configured to access your cluster. Please refer to [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/){target=_blank}.
*   __Helm__. See [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank} on how to install Helm. Run:AI works with Helm version 3 only (not helm 2).
*   A __Kubernetes configuration file__ obtained from the Kubernetes cluster installation.

## Researcher Authentication

When enabled, Researcher authentication requires additional setup when installing the CLI. To configure authentication see [Setup Project-based Researcher Access Control](../Cluster-Setup/researcher-authentication.md). Use the modified Kubernetes configuration file described in the article.

## Setup

### Kubernetes Configuration

*   On the Researcher's root folder, create a directory _.kube_. Copy the Kubernetes configuration file into the directory. Each Researcher should have a __separate copy__ of the configuration file. The Researcher should have write access to the configuration file as it stores user defaults. 
*   If you choose to locate the file at a different location than `~/.kube/config` , you must create a shell variable to point to the configuration file as follows:

```
export KUBECONFIG=<Kubernetes-config-file>
```

*   Test the connection by running:

```
kubectl get nodes
```

### Run:AI CLI Installation

*   Download the latest release from the Run:AI [releases page](https://github.com/run-ai/runai-cli/releases){target=_blank}
*   Unarchive the downloaded file
*   Install by running:

```
sudo ./install-runai.sh
```

* To verify the installation run:

```
runai list jobs
```

## Troubleshooting the CLI Installation

See [Troubleshooting a CLI installation](cli-troubleshooting.md)

## Updating the Run:AI CLI

To update the CLI to the latest version run:

```
sudo runai update
```