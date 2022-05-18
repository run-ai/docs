# Install the Run:ai Command-line Interface

The Run:ai Command-line Interface (CLI) is __one__ of the ways for a Researcher to send deep learning workloads, acquire GPU-based containers, list jobs, etc.

The instructions below will guide you through the process of installing the CLI. The Run:ai CLI runs on Mac and Linux. You can run the CLI on Windows by using Docker for Windows. See the end of this document.


## Researcher Authentication

When enabled, Researcher authentication requires additional setup when installing the CLI. To configure authentication see [Setup Project-based Researcher Access Control](../runai-setup/authentication/researcher-authentication.md). Use the modified Kubernetes configuration file described in the article.

## Prerequisites

*   When installing the command-line interface, it is worth considering future upgrades:
     * Install the CLI on a dedicated _Jumpbox_ machine. Researchers will connect to the Jumpbox from which they can submit Run:ai commands
     * Install the CLI on a shared directory that is mounted on Researchers' machines.  
*   A __Kubernetes configuration file__ obtained from the Kubernetes cluster installation.

??? "Run:ai version 2.4 or earlier"
     * __Kubectl__ (Kubernetes command-line interface) installed and configured to access your cluster. Please refer to [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/){target=_blank}.
     * __Helm__. See [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank} on how to install Helm. Run:ai works with Helm version 3 only (not helm 2).


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

### Install Run:ai CLI 

=== "Run:ai version 2.5"
     * Go to the Run:ai user interface. On the top right select `Researcher Command Line Interface`.
     * Select Mac or Linux.
     * Download directly using the button or copy the command and run on a remote machine
     * Run:

     ``` bash 
     chmod +x runai
     sudo mv runai /usr/local/bin
     ```
  
=== "Run:ai version 2.4 or earlier"
     *   Download the latest release from the Run:ai [releases page](https://github.com/run-ai/runai-cli/releases){target=_blank}. For MacOS, download the `darwin-amd64` release.For Linux, download the `linux-amd64` release.

     *   Unarchive the downloaded file
     *   Install by running:

     ```
     sudo ./install-runai.sh
     ```

     The command will install Run:ai CLI into `/usr/local`. Alternatively, you can provide a directory of your choosing: 

     ```
     sudo ./install-runai.sh <INSTALLATION-DIRECTORY>
     ```

     You can omit `sudo` if you have _write_ access to the directory. The directory must be added to the users' `PATH`.


To verify the installation run:

```
runai list jobs
```

## Install Command Auto-Completion 

It is possible to configure your Linux/Mac shell to complete Run:ai CLI commands. This feature works on _bash_ and _zsh_ shells only.

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

## Update the Run:ai CLI

To update the CLI to the latest version perform the same install process again.

## Delete the Run:ai CLI

If you have installed using the default path, run:

```
sudo rm /usr/local/bin/runai
```

## Use Run:ai on Windows

Install [Docker for Windows](https://docs.docker.com/docker-for-windows/install/){target=_blank}.

Get the following folder from GitHub: [https://github.com/run-ai/docs/tree/master/cli/windows](https://github.com/run-ai/docs/tree/master/cli/windows){target=_blank}.

Replace `config` with your Kubernetes Configuration file.

Run: `build.sh` to create a docker image named `runai-cli`.

Test the image by running:

``` bash
docker run -it runai-cli bash
```

Try and connect to your cluster from inside the docker by running a Run:ai CLI command. E.g. `runai list projects`.

Distribute the image to Windows users.
