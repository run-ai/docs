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
    * Make sure the flag for the enhanced command line interface is enabled. To enable the Improved Command Line Interface Press the *Tools and Settings* icon, then *General*, then *Workloads*, then enable the *Improved Command Line Interface* toggle.
    * Only clusters that are version 2.18 or later are supported.

To install the Improved Command Line Interface:

1. Press the *Help* icon, then select *Researcher Command Line Interface*.
2. From the dropdown, select a cluster.
3. Select your operating system.
4. Copy the installer command to your clipboard, then paste it into a terminal window and run the command.
5. Follow the instruction prompts during the installation process. Press `Enter` to use the default values (recommended).

### Options

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
* [runai list](runai_list.md)&mdash;[Deprecated] display resource list. By default displays the job list
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
