# Run:ai Version 2.8

## Release date
 October 2022 

## Release Content
<!-- 
* Now supporting _spread_ scheduling strategy as well. For more information see [scheduling strategies](../Researcher/scheduling/strategies.md). -->

### Node Pools

Node Pools is a new method to manage your GPU and CPU resources by __grouping resources__ into distinct pools. With node pools:

* You will be allocating Projects and Departments resources from those pools to be used by Workloads. 
* The administrator controls which workloads can use which resources, allowing an optimized utilization of resources according to more accurate customer needs. 

__NEED NEW LINK TO DOCS__

### Audit Logs

Audit Log (named: Events History) is a log of all administrative events that occurred in the system. This allows administrators to trace back system configuration changes with full details per event.

__NEED NEW LINK TO DOCS__

### User Interface Enhancements

* The _Departments_ screen has been revamped and new functionality added, including a new and clean look and feel, and improved search and filtering capabilities.
* To ease the usage of a growing list of Jobs, the jobs under the _Jobs_ screen are now split into 2 tabs: 
    * _Current_:  (the default tab) consists of all the jobs that currently exist in the cluster. 
    * _History_:  consists of all the jobs that have been deleted from the cluster. Deleting Jobs also deletes their Log (no change).

### Installation improvements 

The Run:ai user interface [requires a URL address](../admin/runai-setup/cluster-setup/cluster-prerequisites/#network-requirements) to the Kubernetes cluster. The requirement is relevant for SaaS installation only. 

In previous versions of Run:ai the administrator should [provide an IP address](../admin/runai-setup/cluster-setup/cluster-prerequisites/#cluster-ip) and Run:ai would automatically create a DNS entry for it and a matching trusted certificate. 

In version 2.8,  the default is for the Run:ai administrator to provide its [own DNS and a trusted certificate](https://docs.run.ai/admin/runai-setup/cluster-setup/cluster-prerequisites/#domain-name). 

The older option still exists but is being deprecated due to complexity.

### Inference 
The Deployment details page now contains the URL for the Inference service 


* HPO Jobs 
metrics improvements 

__NEED DETAILS__



* Zal
 to review Zal improvement and write a customer facing item per improvement>

__NEED DETAILS__

## Known Bugs

|Internal ID|Description                                                                                                                                                                                        |Workaround                                           |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|
|RUN-5855   |In SAAS 2.8 Control plane, it is not possible to create a new deployment on a cluster which its version is lower than 2.8.                                                                         |Use 2.8 cluster.                                     |      
|RUN-5780   |It is possible to change runai/node-pool label of a running pod. This is a wrong usage of the system and may cause unexpected behavior.                                                            |None.                                                |      
|RUN-5519   |The GPU memory utilization is not displayed in the job's side-bar. This is an NVIDIA DCGM known bug (see:  https://github.com/NVIDIA/dcgm-exporter/issues/103 ) which was fixed in a later version.|Install the suggested version as described by NVIDIA.|     


## Fixed Bugs

|Internal ID | Description   |
|---------|-------|
|RUN-5676 |When Interactive Jupyter notebook workloads that contain passwords are cloned, the password is exposed in the displayed CLI command.                                             |
|RUN-5457 |When using the Home environment variable in conjunction with the ran-as-user option in the CLI, the Home environment variable is overwritten with the user‚Äôs home directory.   |
|RUN-5370 |It is possible to submit two jobs with the same node-port.                                                                                                                       |
|RUN-5314 |When you apply an inference deployment via a file, the allocated GPUs are displayed as 0 in the deployments list.                                                                |
|RUN-5284 |When workloads are deleted while the cluster synchronization is down, there might be a non-existent Job shown in the user interface. The Job cannot be deleted.                  |
|RUN-5160 |In some situations, when a Job is deleted, there may be leftover Kubernetes configMaps in the system                                                                             |
|RUN-5154 |In some cases, an error "failed to load data" can be seen in the graphs showing on the Job sidebar.                                                                              |
|RUN-5145 |The default Kubernetes "priority Class" for deployments is the same as the priority class for interactive jobs.                                                                  |
|RUN-5039 |In some scenarios, Dashboards may show "found duplicate series for the match group" error                                                                                        |
|RUN-4941 |The scheduler is wrongly trying to schedule jobs on a node, where there are allocated GPU jobs at an "ImagePullBackoff" state. This causes an error of "UnexpectedAdmissionError"|
|RUN-4574 |The role "Researcher Manager" is not displayed in the access control list of projects.                                                                                           |
|RUN-4554 |Users are trying to login with single-sign-on get a "review profile" page.                                                                                                       |
|RUN-4464 |Single HPO (hyperparameter optimization) workload is displayed in the Job list user interfgace as multiple jobs (one for every pod).                                             |



