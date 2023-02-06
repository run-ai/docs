

# Getting familiar with workspaces 

Workspace is a simplified tool for researchers to conduct their experiments, build AI models, access standard MLOps tools, and collaborate with their peers.

Run:ai workspaces abstract complex concepts related to running containerized workloads in a Kubernetes environment. Aspects, such as networking, storage, and secrets, are built from predefined abstracted setups, that ease and streamline the researcher's AI model development.

<!-- A workspace is a work environment with a specific setup. This setup is set to facilitate the research needs and yet to ensure infrastructure owners keep control and efficiency when supporting the various needs. -->

A workspace consists of all the setup and configuration needed for the research, Including container images, data sets, resource requests, as well as all required tools for the research, in a single place. 
This setup is set to facilitate the research needs and yet to ensure infrastructure owners keep control and efficiency when supporting the various needs.

A workspace is associated with a specific Run:ai project (internally: a Kubernetes namespace). A researcher can create multiple workspaces under a specific project.

Researchers can view and use only workspaces that are created under projects they are assigned to.

![](img/grid.png)

Workspaces can be created with just a few clicks of a button. See [Workspace creation](#xxx).  

Workspaces can be stopped and started to save expensive resources without losing complex environment configurations.

Only when a workspace is in status active (see also [Workspace Statuses](./statuses.md)) does is consume resources. 

When the workspace is active it exposes the connections to the tools (for example, A Jupyter notebook) within the workspace (See also [Connect to a tool](#xxx)).


![](img/activews.png)


An active workspace is an [interactive workload](../../../admin/workloads/workload-overview-admin.md). The interactive workload starts when the workspace is started and stopped when the workspace is stopped. 

Workspaces can be viewed in the Jobs grid. In that sense, a workspace can be referred to many interactive workloads in the job screen but only 1 can of them could be in status running.

Workspaces can be used via the user interface or programmatically via the Run:ai [Admin API](../../../developer/admin-rest-api/overview.md). Workspaces are not supported via the command line interface. You can still run an interactive workload via the command line. 
