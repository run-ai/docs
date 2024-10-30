---
title: Run:ai V2 Command-line Interface
summary: This article is the summary article for the CLI V2.
---

The Run:ai Command-line Interface (CLI) tool for a Researcher to send deep learning workloads, acquire GPU-based containers, list jobs, and access other features in the Run:ai platform.

## The new V2 Command-line interface
    
This command-line interface is a complete revamp of the command-line interface. Few highlights:

* The CLI internally uses the [Control-plane API](../../../developer/admin-rest-api/overview.md). This provides a single point of view on Workloads removing dissimilarities between the user interface, programming interface and the command-line interface. 
* As such, it also removes the need to configure the [Kubernetes API server](../../../admin/authentication/researcher-authentication.md) for authentication. 
* **The CLI is only available for Run:ai cluster version 2.18 and up.**
* **Windows OS is not supported yet, will be added soon.**
* The new V2 CLI is backward compatible with the older V1 CLI.


## Installing the Improved Command Line Interface

See installation instructions [here](../../../admin/researcher-setup/new-cli-install.md).


## Reference

List of all commands can be found [here](./runai.md)
