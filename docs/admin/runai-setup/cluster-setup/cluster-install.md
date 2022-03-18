Below are instructions on how to install Run:AI cluster. Before installing, please review the installation prerequisites here: [Run AI GPU Cluster Prerequisites](cluster-prerequisites.md). 


!!! Important
    We strongly recommend running the Run:AI [pre-install script](cluster-prerequisites.md) to verify that all prerequisites are met. 


## Step 1: Kubernetes

See [prerequisites](cluster-prerequisites.md).


## Step 2: NVIDIA

See [prerequisites](cluster-prerequisites.md).



## Step 3: Install Run:AI

Log in to Run:AI user interface at `<company-name>.run.ai`. Use credentials provided by Run:AI Customer Support:

*   If no clusters are currently configured, you will see a Cluster installation wizard
*   If a cluster has already been configured, use the menu on the top left and select "Clusters". On the top right, click "Add New Cluster". 

Using the Wizard:

1. Choose a target Kubernetes platform (see table above)
2. Download a _Helm_ values YAML file ``runai-<cluster-name>.yaml``
3. (Optional) customize the values file. See [Customize Cluster Installation](customize-cluster-install.md)
4. Install [Helm](https://helm.sh/docs/intro/install/)
5. For RKE only, perform the steps [here](../cluster-troubleshooting/#symptom-cluster-installation-failed-on-rancher-based-kubernetes-rke)
6. Run the `helm` commands as provided in the wizard. 


!!! Info
    To install a specific version, add `--version <version>` to the install command.

## Step 4: Verify your Installation

*   Go to `<company-name>.run.ai/dashboards/now`.
*   Verify that the number of GPUs on the top right reflects your GPU resources on your cluster and the list of machines with GPU resources appears on the bottom line.

For a more extensive verification of cluster health, see [Determining the health of a cluster](../cluster-troubleshooting/#determining-the-health-of-a-runai-cluster).

## Step 5: (Optional) Set Node Roles

When installing a production cluster you may want to:

* Set one or more Run:AI system nodes. These are nodes dedicated to Run:AI software. 
* Machine learning frequently requires jobs that require CPU but __not GPU__. You may want to direct these jobs to dedicated nodes that do not have GPUs, so as not to overload these machines. 
* Limit Run:AI to specific nodes in the cluster. 

To perform these tasks. See [Set Node Roles](../config/node-roles.md).



## Next Steps

* Set up Admin UI Users [Working with Admin UI Users](../../admin-ui-setup/admin-ui-users.md).
* Set up Projects for Researchers [Working with Projects](../../admin-ui-setup/project-setup.md).
* Set up Researchers to work with the Run:AI Command-line interface (CLI). See  [Installing the Run AI Command-line Interface](../../researcher-setup/cli-install.md) on how to install the CLI for users.
* Set up [Project-based Researcher Access Control](../config/researcher-authentication.md).
* Review [advanced setup and maintenace](../config/overview.md) scenarios.
