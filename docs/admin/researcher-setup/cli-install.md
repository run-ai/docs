# Install the Run:ai Command-line Interface

The Run:ai Command-line Interface (CLI) is __one__ of the ways for a Researcher to send deep learning workloads, acquire GPU-based containers, list jobs, etc.

The instructions below will guide you through the process of installing the CLI. The Run:ai CLI runs on Mac and Linux. You can run the CLI on Windows by using Docker for Windows. See the end of this document.


## Researcher Authentication

When enabled, Researcher authentication requires additional setup when installing the CLI. To configure authentication see [Setup Project-based Researcher Access Control](../runai-setup/authentication/researcher-authentication.md). Use the modified Kubernetes configuration file described in the article.

## Prerequisites

*   When installing the command-line interface, it is worth considering future upgrades:
     * Install the CLI on a dedicated _Jumpbox_ machine. Researchers will connect to the Jumpbox from which they can submit Run:ai commands
     * Install the CLI on a shared directory that is mounted on Researchers' machines.  
*   A __Kubernetes configuration file__. 


## Setup

### Kubernetes Configuration

*   On the Researcher's root folder, create a directory _.kube_. Copy the Kubernetes configuration file into the directory. Each Researcher should have a __separate copy__ of the configuration file. The Researcher should have _write_ access to the configuration file as it stores user defaults. 
*   If you choose to locate the file at a different location than `~/.kube/config`, you must create a shell variable to point to the configuration file as follows:

```
export KUBECONFIG=<Kubernetes-config-file>
```

*   Test the connection by running:

```
kubectl get nodes
```

### Install Run:ai CLI 

* Go to the Run:ai user interface. On the top right select `Researcher Command Line Interface`.
* Select `Mac`, `Linux` or `Windows`. 
* Download directly using the button or copy the file to run it on a remote machine

=== "Mac or Linux"
     Run:

     ``` bash 
     chmod +x runai
     sudo mv runai /usr/local/bin/runai
     ```

=== "Windows" 
     Rename the downloaded file to have a `.exe` extension and move the file to a folder that is a part of the `PATH`.

!!! Note
     An alternative way of downloading the CLI is provided under the [CLI Troubleshooting](../troubleshooting/troubleshooting.md#command-line-interface-issues) section.




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
* Ubuntu/Debian: `sudo apt-get install bash-completion`
* Fedora/Centos: `sudo yum install bash-completion`

Edit the file `~/.bashrc`. Add the lines:

``` bash
[[ -r “/usr/local/etc/profile.d/bash_completion.sh” ]] && . “/usr/local/etc/profile.d/bash_completion.sh”
source <(runai completion bash)
```


## Troubleshoot the CLI Installation

See [Troubleshooting a CLI installation](../troubleshooting/troubleshooting.md#command-line-interface-issues)

## Update the Run:ai CLI

To update the CLI to the latest version perform the same install process again.

## Delete the Run:ai CLI

If you have installed using the default path, run:

```
sudo rm /usr/local/bin/runai
```
