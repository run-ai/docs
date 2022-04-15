# User Interface Overview

Run:ai provides a single user interface that, depending on your role, serves both as a control-plane management tool and a researcher workbench. 


The control-plane part of the tool allows the administrator to:

* Analyze cluster status using [dashboards](dashboard-analysis.md).
* Manage Run:ai metadata such as [users](admin-ui-users.md), [departments](department-setup.md), and [projects](project-setup.md). 
* View Job details to be able to help researchers solve Job related issues.

The researcher workbench part of the tool allows Researchers to submit, delete and pause [Jobs](jobs.md), view Job logs etc.

## Setup

:octicons-versions-24: [Version 2.3](../../home/whats-new-2022.md#march-2022-runai-version-23)

While the control-plane part is immediately accessible, the researcher workbench part requires a cluster of version 2.3 or later. 

The cluster installation process requires [configuring a new cluster](../runai-setup/cluster-setup/cluster-install.md) and downloading a YAML file. 
On SaaS-based installations, the cluster creation wizard requires the cluster's IP as shown here:

![cluster-wizard.png](img/cluster-wizard.png)

If your Run:ai tenant has been created before April 2022, Go to `General | Settings` and enable the `Unified UI` flag. 

## Architecture

* Run:ai saves metadata such as users, projects, departments, clusters, and tenant settings, in the control plane residing on the Run:ai cloud.
* Workload information resides on (sometimes multiple) GPU clusters. 
* The Run:ai user interface needs to work with both sources of information. 

As such, the chosen architecture of the user interface is:

![ui-architecture.png](img/ui-architecture.png)

* The user interface is served from the management backend.
* The user interface connects directly to multiple GPU clusters using _cross origin access_. This works using [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS){targe=_blank}: Cross-origin resource sharing. This allows submitting workloads and getting extended logging information directly from the GPU clusters. 
* Meta-data, such as Projects, Settings, and Job information is synced into the management backend via a cluster-sync service. Cluster-sync creates an outbound-only channel with no incoming HTTPS connections.  

!!! Important note
    One corollary of this architecture is that for SaaS-based tenants, the user interface will only be able to access the cluster when the browser is inside the corporate firewall. When working outside the firewall. Workload related functionality such as Submitting a Job, viewing Job lots etc, is disabled. 

