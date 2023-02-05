

# Getting familiar with workspaces 

 
Workspace is a simplified efficient tool for data scientists to conduct their experiments, build AI models, access standard MLOps tools, and collaborate with their peers.

Run:ai workspaces abstract complex concepts related to running containerized workloads in a Kubernetes environment, such as networking, storage, and secrets, and are built from predefined abstracted setups, that ease and streamline the data scientists AI models development.

A workspace is a work environment with a specific setup. This setup is set to facilitate the research needs and yet to ensure infrastructure owners keep control and efficiency when supporting the various needs. 
 
A workspace consists of all the setup and configuration needed for the research, Including container images, data sets, resource requests, as well as all required tools for the research, in a single place.

A workspace is associated with a single project (Reminder- a project is a namespace). So a data scientist can create multiple workspaces under a project. 

Data scientists can view & use only workspaces that are created under projects they are assigned to.


![](img/grid.png)

Workspaces can be easily created with just a few clicks of a button. See [Workspace creation](#xxx).  
 
As workspaces hold the setup of the data scientists’ work environment, workspaces can be stopped & started to save costly resources and without the data scientists losing the complex configuration of their environments.

Only when a workspace is in status active (see also [Workspace Statuses](#xxxx)) it is consuming resources and exposing the connections to the tools (e.g. connecting to Jupyter notebook) within the workspace (See also [Connect to a tool](#xxx)).



![](img/activews.png)



When a workspace is active, it creates in its background an interactive workload that can be viewed in the jobs grid. In that sense, a workspace can be referred to many interactive workloads in the job screen but only 1 can of them could be in status running. 

When a workspace is running there is also an interactive session running under the same name has the workspace’s. When the workspace’s is stopped so is the interactive session.

A workspace in its essence is to improve and simplify the user experience of both data science teams & administrators. It is only supported via UI & API, but not via CLI. 
Running an interactive session via CLI is still supported.
