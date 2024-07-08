---
title: Run:ai Enhanced Command-line Interface
summary: This article is the summary article for the CLI V2.
authors:
    -  Jason Novich 
date: 2024-Jun-18
---

## Summary

The Run:ai Command-line Interface (CLI) tool for a Researcher to send deep learning workloads, acquire GPU-based containers, list jobs, and access other features in the Run:ai platform.

```
runai [flags]
```

## Installing the Improved Command Line Interface

!!! Note

    * Make sure the flag for the Improved command line interface is enabled.
    * Only clusters that are version 2.18 or later are supported.
    * Only Linux and Mac OS are currently supported

To enable the Improved Command Line Interface:

1. Press the *Tools and Settings* icon, then *General*.
2. Press *Workloads*, then enable the *Improved Command Line Interface* toggle.

To install the Improved Command Line Interface:

1. Press the *Help* icon, then select *Researcher Command Line Interface*.
2. From the dropdown, select a cluster.
3. Select your operating system.
4. Copy the installer command to your clipboard, then paste it into a terminal window and run the command.
5. Follow the instruction prompts during the installation process. Press `Enter` to use the default values (recommended).

### Authenticating your CLI

You will need to login to authenticate the CLI.
In your terminal widow run:

`runai login`

You will be redirected to your platform's login page.
Enter your user name and password and login.

You can then return to the terminal window to use the CLI.

### Set the default cluster

When you only have one cluster connected to the tenant, it will be set as default cluster when you first login.

When there are multiple clusters, you can select the cluster you want to set as default by running the following:

`runai cluster set --name <CLUSTER NAME>`

To find the desired cluster name run:

`runai cluster list`

### Set a default project

!!! Recommendation
    Setting a default working project to, allows you to easily submit workloads without mentioning the project name in every command.

`runai project set --name=<project_name>`

If successful the following message will return:

`project <project name> configured successfully`

To see the current configuration run:

`runai config generate --json`


### Install Command Auto-Completion

Auto-completion is installed automatically.

To install auto-completion manually:

* For *ZSH*, edit the file `~/.zshrc` and add the following lines:

```zsh
autoload -U compinit; compinit -i
source <(runai completion zsh)
```

* For *bash*, install the bash-completion package. Choose your operating system:
  
  * Mac: `brew install bash-completion`
  * Ubuntu/Debian: `sudo apt-get install bash-completion`
  * Fedora/Centos: `sudo yum install bash-completion`
  
Then, edit the file `~/.bashrc` and add the following lines:

```bash
[[ -r “/usr/local/etc/profile.d/bash_completion.sh” ]] && . “/usr/local/etc/profile.d/bash_completion.sh”

source <(runai completion bash)
```


### Options

You can use the following configuration options with your CLI to customize your CLI.

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH (default "~/.runai/")
  -d, --debug                enable debug mode
  -h, --help                 help for runai
  -v, --verbose              enable verbose mode
```

### See Also

* [runai cluster](runai_cluster.md)&mdash;cluster management
* [runai config](runai_config.md)&mdash;configuration management
* [runai list](runai_list.md)&mdash;(Deprecated) display resource list. By default displays the job list
* [runai login](runai_login.md)&mdash;login to the control plane
* [runai logout](runai_logout.md)&mdash;logout from control plane
* [runai node](runai_node.md)&mdash;node management
* [runai nodepool](runai_nodepool.md)&mdash;node pool management
* [runai project](runai_project.md)&mdash;project management
* [runai report](runai_report.md)&mdash;report management
* [runai training](runai_training.md)&mdash;training management
* [runai upgrade](runai_upgrade.md)&mdash;upgrades the CLI to the latest version
* [runai version](runai_version.md)&mdash;print version information
* [runai workload](runai_workload.md)&mdash;workload management
* [runai workspace](runai_workspace.md)&mdash;workspace management
