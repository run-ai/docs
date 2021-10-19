# Install the Run:AI Command-line Interface

The Run:AI Command-line Interface (CLI) is __one__ of the ways for a Researcher to send deep learning workloads, acquire GPU-based containers, list jobs, etc.

The instructions below will guide you through the process of installing the CLI.

!!! Note
     The Run:AI CLI runs on Mac and Linux. You can run the CLI on Windows by using Docker for Windows. See the end of this document.

## Prerequisites

*   When installing the command-line interface, it is worth considering future upgrades:
     * Install the CLI on a dedicated _Jumpbox_ machine. Researches will connect to the Jumpbox from which they can submit Run:AI commands
     * Install the CLI on a shared directory that is mounted on Researchers' machines.  

*   __Kubectl__ (Kubernetes command-line interface) installed and configured to access your cluster. Please refer to [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/){target=_blank}.
*   __Helm__. See [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank} on how to install Helm. Run:AI works with Helm version 3 only (not helm 2).
*   A __Kubernetes configuration file__ obtained from the Kubernetes cluster installation.

## Researcher Authentication

When enabled, Researcher authentication requires additional setup when installing the CLI. To configure authentication see [Setup Project-based Researcher Access Control](../runai-setup/advanced/researcher-authentication.md). Use the modified Kubernetes configuration file described in the article.

## Setup

### Kubernetes Configuration

*   On the Researcher's root folder, create a directory _.kube_. Copy the Kubernetes configuration file into the directory. Each Researcher should have a __separate copy__ of the configuration file. The Researcher should have write access to the configuration file as it stores user defaults. 
*   If you choose to locate the file at a different location than `~/.kube/config`, you must create a shell variable to point to the configuration file as follows:

```
export KUBECONFIG=<Kubernetes-config-file>
```

*   Test the connection by running:

```
kubectl get nodes
```

### Install Run:AI CLI 

*   Download the latest release from the Run:AI [releases page](https://github.com/run-ai/runai-cli/releases){target=_blank}. For MacOS, download the `darwin-amd64` release.For Linux, download the `linux-amd64` release.
*   Unarchive the downloaded file
*   Install by running:

```
sudo ./install-runai.sh
```

The command will install Run:AI CLI into `/usr/local`. Alternatively, you can provide a directory of your choosing: 

```
sudo ./install-runai.sh <INSTALLATION-DIRECTORY>
```

You can omit `sudo` if you have _write_ access to the directory. The directory must be added to the users' `PATH`.


* To verify the installation run:

```
runai list jobs
```

## Install Command Auto-Completion 

It is possible to configure your Linux/Mac shell to complete Run:AI CLI commands. This feature works on _bash_ and _zsh_ shells only.

### Zsh

Edit the file `~/.zshrc`. Add the lines:

```
autoload -U compinit; compinit -i
source <(runai completion zsh)
```

### Bash

Install the bash-completion package:

* Mac: `brew install bash-completion`
* Ubundu/Debian: `sudo apt-get install bash-completion`
* Fedora/Centos: `sudo yum install bash-completion`

Edit the file `~/.bashrc`. Add the lines:

``` bash
[[ -r “/usr/local/etc/profile.d/bash_completion.sh” ]] && . “/usr/local/etc/profile.d/bash_completion.sh”
source <(runai completion bash)
```


## Troubleshooting the CLI Installation

See [Troubleshooting a CLI installation](cli-troubleshooting.md)

## Update the Run:AI CLI

To update the CLI to the latest version run:

```
sudo runai update
```


## Use Run:AI on Windows

Install [Docker for Windows](https://docs.docker.com/docker-for-windows/install/){target=_blank}.

Get the following folder from GitHub: [https://github.com/run-ai/docs/tree/master/cli/windows](https://github.com/run-ai/docs/tree/master/cli/windows){target=_blank}.

Replace `config` with your Kubernetes Configuration file.

Run: `build.sh` to create a docker image named `runai-cli`.

Test the image by running:

``` bash
docker run -it runai-cli bash
```

Try and connect to your cluster from inside the docker by running a Run:AI CLI command. E.g. `runai list projects`.

Distribute the image to Windows users.
