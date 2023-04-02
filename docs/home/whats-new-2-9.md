# Run:ai Version 2.9

## Release Date
February 2023

## Release Content

### Authentication

**OpenShift groups**

Ability to manage access control through IDP groups declaration - groups are managed from the OpenShift platform and integrated into Run:ai platform, as opposed to group management in vanilla k8s with SSO. OpenShift doesn’t need any additional configuration as this comes built-in with regular installation or the upgrade option.

**UID/GID for SSO users**

When running a workload through the UI the Run:ai platform now automatically injects the UID and GID into the created container. This has changed from previous versions where the user would enter data in these fields manually. This is designed for environments where UIDs and GIDs are managed in an SSO server, and Run:ai is configured with SSO.	

**SSO: block access to Run:ai**

When configuring SSO in the Run:ai platform all users are assigned a new default role. It means an SSO user will not have any access to the Run:ai platform unless a manager explicitly assigns additional roles via the user or group management areas.

**Run CPU over-quota workloads**

Added support for CPU workloads to support over-quota - CPU resources fairness was added to the Run:ai scheduler in addition to the GPU fairness that is already supported. The updated fairness algorithm takes into account all resource types (GPU, CPU compute and CPU memory) and is supported regardless of node pool configuration. 

### Run:ai Workspaces

A Run:ai workspace is a simplified, efficient tool for researchers to conduct their experiments, build AI models, access standard MLOps tools, and collaborate with their peers.

Run:ai workspaces abstract complex concepts related to running containerized workloads in a Kubernetes environment, such as networking, storage, and secrets, and are built from predefined abstracted setups, that ease and streamline the researcher AI models development. A workspace consists of container images, data sets, resource requests, and all the required tools for the research. They are quickly created with the workspace wizard. For more information see [Workspaces](../Researcher/user-interface/workspaces/overview.md).

### New supported tools for researchers

As part of the introduction of Run:ai workspaces a few new development and research tools were added. The new supported tools are: RStudio, Visual Studio Code, Matlab and Weights and Biases (see full details). This is an addition to adding already supported tools, such as JupyterNotebook and TensorBoard to Run:ai workspaces.

**Weight and Biases**

Weights and Biases is a commercial tool that provides experiment tracking, model visualization, and collaboration for machine learning projects. It helps researchers and developers keep track of their experiments, visualize their results, and compare different models to make informed decisions. This integration provides data researchers with connectivity between the running Workspace in Run:ai and the relevant project for experiment tracking. For more information, see [Weights and Biases](../admin/integration/weights-and-biases.md)

**Node pools enhancements**

Added additional support to multi-node pools. This new capability allows the researcher to specify a prioritized list of node pools for the Run:ai scheduler to use. Researchers now gain the flexibility to use multiple resource types and maximize the utilization of the system’s GPU and CPU resources. Administrators now have the option to set a default Project (namespace) level with a prioritized list of node pools that a workload will use if the researcher did not set its own priorities.

**New nodes and node pools Screens**

Run:ai has revised the nodes table, adding new information fields and graphs. It is now easier to assess how resources are allocated and utilized. Run:ai has also added a new ‘node pools’ table where Administrators can add a new node pool, update, and delete an existing node pool. In addition, the node pools table presents a large number of metrics and details about each of the node pools. A set of graphs reflect the node pools’ resource status over time according to different criteria.

**Consumption Dashboard**

Added a “Consumption” dashboard. When enabled by the “Show Consumption Dashboard” alpha flag under “Settings”, this dashboard allows the admin to review consumption patterns for GPUs, CPUs and RAM over time. You can segregate consumption by over or in-quota allocation in the project or department level. For more information, see [Consumption dashboard](../admin/admin-ui-setup/dashboard-analysis.md#consumption-dashboard).

**Event History (Audit Log UI)**

Added the option for Administrators to view the system’s Audit Log via the Run:ai user interface. Configuration changes and other administrative operations (login/logout etc) are saved in an Audit Log facility. Administrators can browse through the Admin Log (Event History), download as a JSON or CSV, filter specific date periods, set multiple criteria filters, and decide which information fields to view.

**Idle jobs timeout policy**

Added an option ‘Editor’ so that Administrators can terminate idle workloads by setting the criteria of ‘idle time’ per project so that the editor can identify and terminate idle Training and Interactive (build) workloads. This is used for maximizing and maintaining system sanitation.

### Installation Enhancements

#### Cluster Upgrade

Cluster upgrade to 2.9 requires uninstalling and then installing. No data is lost during the process. For more information see [cluster upgrade](../admin/runai-setup/cluster-setup/cluster-upgrade.md).

Using an IP address for a [cluster URL](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#cluster-ip) is no longer available in this version. You must use a [domain name](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#domain-name).

#### Cluster Prerequisites

- Prometheus is no longer installed together with Run:ai. You must install the [Prometheus stack](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#prometheus) before installing Run:ai. This is designed for organizations that already have Prometheus installed in the cluster. The Run:ai installation configures the existing Prometheus with a custom set of rules designed to extract metrics from the cluster.

- NGINX is no longer installed together with Run:ai. You must install an [Ingress controller](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#ingress-controller) before installing Run:ai. This is designed for organizations that already have an ingress controller installed. The Run:ai installation creates NGINX rules to work with the controller.

- List of Run:ai installation Prerequisites can be found [here](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#prerequisites-in-a-nutshell).

- The Run:ai installation now performs a series of checks to verify the installation's validity. When the installation is complete, [verify](../admin/runai-setup/cluster-setup/cluster-install.md#verify-your-installation) by reviewing the following in the log file:
    - Are all mandatory prerequisites met?
    - Are optional prerequisites met?
    - Does the cluster have connectivity to the Run:ai control plane?
    - Does Run:ai support the underlying Kubernetes version?

#### Control Plane Upgrade

A [special process](../admin/runai-setup/self-hosted/k8s/upgrade.md#upgrading-to-version-29) is required to upgrade the control-plane to version 2.9. 
#### Control plane Prerequisites

- Run:ai control plane installation no longer installs NGINX. You must pre-install an ingress controller.

- The default persistent storage is now a default storage class preconfigured in Kubernetes rather than the older NFS assumptions. NFS flags in `runai-adm` generate-values still exist for backward compatibility.

#### Other

Cluster Wizard has been simplified for environments with **multiple** clusters
  in a self-hosted configuration. Clusters are now easier to configure. Choose a cluster location: 

- Same as Control Plane. 
- Remote to Control Plane. 

### New Supported Software

- Run:ai now supports Kubernetes 1.25 and 1.26.
- Run:ai now supports OpenShift 4.11
- Run:ai now supports Dynamic MIG with NVIDIA H100 hardware
- The Run:ai command-line interface now supports Microsoft Windows. See [Install the Run:ai Command-line Interface](../admin/researcher-setup/cli-install.md#use-runai-cli-on-windows).

## Known Issues

|Internal ID|Description|Workaround|
|-----------|--------------|--------------|
|RUN-7874|When a project is not connected to a namespace - new job returns "malformed URL"| None |
|RUN-7617|Cannot delete Node affinity from project after it was created| Remove it using the API. |

## Fixed Issues

|Internal ID|Description|
|-----------|--------------|
| RUN-7776|	user does not exist in the UI due to pagination limitation |
| RUN-6995|	Group Mapping from SSO Group to Researcher Manager Role no working |
| RUN-6460|	S3 Fail (read/write in Jupyter notebook) |
| RUN-6445|	Project can be created with deleted node pool |
| RUN-6400|	EKS - Every command response in runai CLI starts with an error. No functionality harm |
| RUN-6399|	Requested GPU is always 0 for MPI jobs, making also other metrics wrong |
| RUN-6359|	Job gets UnexpectedAdmissionError race condition with Kubelet |
| RUN-6272|	runai pod which owner is not RunaiJob - Do not allow deletion, suspension, cloning |
| RUN-6218|	When installing Run:ai on OpenShift a second time, oauth client secret is incorrect/not updated |
| RUN-6216|	Multi cluster: allocated GPU is wrong as a result of metric not counting jobs in error |
| RUN-6029|	CLI Submit git sync severe bug |
| RUN-6027|	[Security Issue] Job submitted with github sync -- Password is displayed in the UI |
| RUN-5822|	Environment Variables in the UI do not honor the "canRemove:false" attribute in Policy |
| RUN-5676|	Security issue with "Clone Job" functionality |
| RUN-5527|	Metrics (MIG - OCP): GPU Idle Allocated GPUs show No Data |
| RUN-5478|	# of GPUs is higher than existing GPUs in the cluster |
| RUN-5444|	MIG doesn't work on A100 - 80GB |
| RUN-5424|	Deployment GPUs tab shows all the GPUs on the node instead of the ones in use by the deployment |
| RUN-5370|	Can submit job with the same node port + imagePullpolicy |
| RUN-5226|	MIG job can't see device after submitting a different mig job |
| RUN-4869| S3 jobs run forever with NotReady state |
| RUN-4244|	Run:ai Alertmanager shows false positive errors on Agent | 
