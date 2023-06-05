# Run:ai Version 2.8

## Version 2.8.21

### Release date

May 2022

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-9832 | Fixed an issue where the node pool controller removes unschedulable jobs from nodes. |

## Version 2.8.20

### Release date

May 2022

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-9485 | Fixed an issue where jobs that have failed appear as if they are running. |

## Version 2.8.19

### Release date

May 2022

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-9354 | Fixed issue where the `RUNAI_GPU_MEMORY_LIMIT` environment variable is set and not applied. |

## Version 2.8.18

### Release date

May 2022

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-9113 | Fixed an issue in the Scheduler where pods were schedules to nodes without enough CPU resources. |

## Version 2.8.17

### Release date

May 2022

<!-- RUN-6345 -->
Added the `Node Pool` column to the `Jobs`, `Inference`, and `Workspaces` tables in the *UI*. This feature is only available when using Control Plane 2.9 or later.

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-8709 | Fixed an issue to make S3 storage work in an airgapped environments. |
| RUN-8276 | Increased the timeout when creating a workload to fix a 503 error. |

## Version 2.8.16

### Release date


## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-8246 | Fixed an issue with large files uploading via Jupyter notebooks. |
| RUN-8366 | Fixed an issue where the scheduler is slow when many podgroups are configured. |

## Version 2.8.15

### Release date

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-7686 | Fixed issues with syncing node pools from the cluster in OpenShift environments. |

## Version 2.8.14

### Release date

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-7776 | Fixed a *UI* issue not displaying more than 100 users. |
| RUN-7726 | Increased the number of allowed API requests to the API server from the researcher service to prevent performance throttling. |
| RUN-7106 | Fixed the *UI* not showing workloads in the cluster when its stopped due to marking the `podgroup` as `not in cluster`. |
| RUN-6995 | Fixed an issue where Group Mapping from an SSO Group to the Researcher Manager Role was not working. |

## Version 2.8.13

### Release date

<!-- RUN-6732 -->
Added support for the scheduling of Kubeflow PyTorch jobs.

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-7240 | Fixed inability to submit fractional jobs on non-default node pools. |
| RUN-7205 | Fixed an issue where `configmaps` are continuously stored for deployments even after the relevant pods are removed. |
| RUN-6832 | Fixed prometheus deployment not discovering the `servicemonitors` within projects. |
| RUN-6800 | Fixed incorrect Prometheus permissions for querying job metrics. |
| RUN-6766 | Fixed an issue mounting s3 file systems. |
| RUN-6538 | Fixed an issue in the Scheduler where the pod was restarted due to an `out of memory` error. |
| RUN-6109 | Fixed an issue in the *UI* that prevents the creation of sequential jobs. |
| RUN-5527 | Fixed an issue where idle allocated GPU metrics are not displayed for MIG workloads in OpenShift. |
| RUN-5489 | Fixed issue when installing Run:ai cluster components that require root access. |
| RUN-5488 | Fixed an issue where Keycloak `initContainer` runs as root. |

## Version 2.8.12

### Release date

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-6216 | Fixed an issue with the multi cluster overview so that the allocated GPU in the table of each cluster is correct. |

## Version 2.8.11

### Release date

<!--RUN-6392 -->
Changed the option to generate Jupyter arguments from using `startNotebook` to any command.

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-6718 | Fixed an issue where graphs are showing the wrong date. |
| RUN-6667 | Fixed an issue where the Run:ai scheduler was crashing in a reclaim action. |
| RUN-6604 | Fixed issue where a new MIG request is issued without the device size. |
| RUN-6536 | Fixed a crash in the *cli* related to the policy for `allow-privilege-escalation`. |
| RUN-6460 | Fixed an issue using a Jupyter notebook to mount an S3 bucket and not permitting read/write access.|
| RUN-6400 | Fixed issue on EKS (Amazon Kubernetes Server), where every *CLI* command response starts with an error. |
| RUN-6399 | Fixed an issue where `requestedGPU` is always 0 for MPI jobs displayed in the distributed workloads Job list.|
| RUN-6359 | Fixed an issue with `UnexpectedAdmissionError` on a job using a fractional GPU.  |
| RUN-6309 | Fixed an issue where the dynamic MIG Manager didn't connect to a cluster role in OpenShift environments. |
| RUN-5492 | Fixed an issue where `runai-container-toolkit` doesn't need root permissions. |
| RUN-5444 | Fixed an issue where the Dynamic MIG feature was not working with A-100 and 80GB of memory. |
| RUN-5226 | Fixed an issue where there is more than 1 NVIDIA MIG workload, the `nvidia-smi` command sent to one of the workloads will result with no devices.|

## Version 2.8.9

### Release date

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
|RUN-6519 | Fixed issue with the scheduler where it was not able to detect PV and PVCs. |

## Version 2.8.0

### Release date
 November 2022 

## Release Content
<!-- 
* Now supporting _spread_ scheduling strategy as well. For more information see [scheduling strategies](../Researcher/scheduling/strategies.md). -->

### Node Pools

Node Pools is a new method for managing GPU and CPU resources by __grouping the resources__ into distinct pools. With node pools:

* The administrator allocates Project and Department resources from these pools to be used by Workloads. 
* The administrator controls which workloads can use which resources, allowing an optimized utilization of resources according to customer's specific mode of operation. 


### User Interface Enhancements

* The _Departments_ screen has been revamped and new functionality added, including a new and clean look and feel, and improved search and filtering capabilities.
* The _Jobs_ screen has been split into 2 tabs for ease of use:
    * _Current_:  (the default tab) consists of all the jobs that currently exist in the cluster. 
    * _History_:  consists of all the jobs that have been deleted from the cluster. Deleting Jobs also deletes their Log (no change).

### Installation improvements 

The Run:ai user interface [requires a URL address](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#cluster-url) to the Kubernetes cluster. The requirement is relevant for SaaS installation only. 

In previous versions of Run:ai the administrator should [provide an IP address](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#cluster-ip) and Run:ai would automatically create a DNS entry for it and a matching trusted certificate. 

In version 2.8,  the default is for the Run:ai administrator to provide a [DNS and a trusted certificate](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#domain-name). 

The older option still exists but is being deprecated due to complexity.

### Inference 
The Deployment details page now contains the URL for the Inference service 


### Hyperparameter Optimization (HPO)

HPO Jobs are now presented as a single line in the Job List rather than a separate line per experiment. 

## Known Issues

|Internal ID| Description  | Workaround   |
|-----------|--------------|--------------|
|RUN-6236 |The Run:ai access control system prevents setting a role of researcher together with ML engineer or researcher manager at the same time. However, using the UI you can select these two roles by clicking the text near the check   |     None  |
|RUN-6218 |When installing Run:ai on OpenShift a second time, oauth client secret is incorrect/not updated. As a result, login is not possible                  | Can be performed via manual configuration. Please contact Run:ai support.|
|RUN-6216 |In the multi cluster overview, the allocated GPU in the table of each cluster is wrong. The correct number is in the overview dashboard.             | None                            |
|RUN-6190 |When deleting a cluster, there are leftover pods that are not deleted. No side effects on functionality.                                             | Delete the pods manually.                                                |
|RUN-5855 |(SaaS version only) The new control plane, versioned 2.8 does not allow the creation of a new deployment on a cluster whose version is lower than 2.8.                |Upgrade your cluster to 2.8  |
|RUN-5780 |It is possible to change runai/node-pool label of a running pod. This is a wrong usage of the system and may cause unexpected behavior.              |None.               |
|RUN-5527 |Idle allocated GPU metric is not displayed for MIG workloads in OpenShift.    | None                 |
|RUN-5519 |When selecting a Job, the GPU memory utilization metrics is not displayed on the right-hand side. This is an NVIDIA DCGM known bug (see:  https://github.com/NVIDIA/dcgm-exporter/issues/103 ) which has been fixed in a later version but was not yet included in the latest NVIDIA GPU Operator|Install the suggested version as described by NVIDIA.                    |
|RUN-5478 |Dashboard panels of GPU Allocation/project and Allocated jobs per project metrics:  In rare cases, some metrics reflect the wrong number of GPUs     |  None                  |
|RUN-5444 |Dynamic MIG feature does not work with A-100 with 80GB of memory.        |     None               |
|RUN-5424 |When a workload is selected in the job list, the GPU tab in the right panel, shows the details of the whole GPUs in the node, instead of the details of the GPUs used by the workload.                 |None              |
|RUN-5226 |In rare occasions, when there is more than 1 NVIDIA MIG workload, nvidia-smi command to one of the workloads will result with no devices.        | None                   |
| RUN-6359 | In rare cases, when using fractions and the kubelet service on the scheduled node is down (Kubernetes not running on node)the pending workload will never run, even when the IT problem is solved. | Delete the job and re-submit the workload. | 
| RUN-6399 | Requested GPUs are sometimes displayed in the Job list as 0 for distributed workloads. | None. This is a display-only issue |    
| RUN-6400 | On EKS (Amazon Kubernetes Server), when using runai CLI, every command response starts with an error. No functionality harm. | None. The CLI functions as expected. | 



## Fixed Issues

|Internal ID | Description   |
|------------|---------------|
|RUN-5676 |When Interactive Jupyter notebook workloads that contain passwords are cloned, the password is exposed in the displayed CLI command.       |
|RUN-5457 |When using the Home environment variable in conjunction with the ran-as-user option in the CLI, the Home environment variable is overwritten with the user's home directory.   |
|RUN-5370 |It is possible to submit two jobs with the same node-port.       |
|RUN-5314 |When you apply an inference deployment via a file, the allocated GPUs are displayed as 0 in the deployments list.           |
|RUN-5284 |When workloads are deleted while the cluster synchronization is down, there might be a non-existent Job shown in the user interface. The Job cannot be deleted.   |
|RUN-5160 |In some situations, when a Job is deleted, there may be leftover Kubernetes configMaps in the system         |
|RUN-5154 |In some cases, an error "failed to load data" can be seen in the graphs showing on the Job sidebar.             |
|RUN-5145 |The default Kubernetes "priority Class" for deployments is the same as the priority class for interactive jobs.      |
|RUN-5039 |In some scenarios, Dashboards may show "found duplicate series for the match group" error    |
|RUN-4941 |The scheduler is wrongly trying to schedule jobs on a node, where there are allocated GPU jobs at an "ImagePullBackoff" state. This causes an error of "UnexpectedAdmissionError"|
|RUN-4574 |The role "Researcher Manager" is not displayed in the access control list of projects.  |
|RUN-4554 |Users are trying to login with single-sign-on get a "review profile" page.      |
|RUN-4464 |Single HPO (hyperparameter optimization) workload is displayed in the Job list user interfgace as multiple jobs (one for every pod).                                             |



