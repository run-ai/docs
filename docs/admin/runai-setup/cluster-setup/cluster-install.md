Below are instructions on how to install a Run:ai cluster. Before installing, please review the installation prerequisites here: [Run:ai GPU Cluster Prerequisites](cluster-prerequisites.md). 


!!! Important
    * We strongly recommend running the Run:ai [pre-install script](cluster-prerequisites.md#pre-install-script) to verify that all prerequisites are met. 
    * Starting version 2.9 you must pre-install  [NGINX ingress controller](cluster-prerequisites.md#ingress-controller)
    * Starting version 2.9 you must pre-install the [Prometheus stack](cluster-prerequisites.md#prometheus).

## Install Run:ai

Log in to Run:ai user interface at `<company-name>.run.ai`. Use credentials provided by Run:ai Customer Support:

*   If no clusters are currently configured, you will see a Cluster installation wizard
*   If a cluster has already been configured, use the menu on the top left and select "Clusters". On the top right, click "Add New Cluster". 

Using the Wizard:

1. Choose a target Kubernetes platform (see table above)
2. (SaaS and remote self-hosted cluster only) Provide a domain name for your cluster as described [here](cluster-prerequisites.md#cluster-url).
3. (SaaS and remote self-hosted cluster only) Install a trusted certificate to the domain within Kubernetes. 
4. Download a _Helm_ values YAML file ``runai-<cluster-name>.yaml``
5. (Optional) customize the values file. See [Customize Cluster Installation](customize-cluster-install.md)
6. Install [Helm](https://helm.sh/docs/intro/install/)
7. Run the `helm` commands as provided in the wizard. 

!!! Info
    To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-cluster`.

## Verify your Installation

* Go to `<company-name>.run.ai/dashboards/now`.
* Verify that the number of GPUs on the top right reflects your GPU resources on your cluster and the list of machines with GPU resources appears on the bottom line.


:octicons-versions-24: Version 2.9 and up 

Run: `kubectl get cm runai-public -n runai -o jsonpath='{.data}' | yq -P`

(assumes the [yq](https://mikefarah.gitbook.io/yq/v/v3.x/){target=_blank} is instaled)

Example output:

``` YAML
cluster-version: 2.9.0
runai-public: 
  version: 2.9.0
  runaiConfigStatus: # (1)
    conditions:
    - type: DependenciesFulfilled
      status: "True"
      reason: dependencies_fulfilled
      message: Dependencies are fulfilled
    - type: Deployed
      status: "True"
      reason: deployed
      message: Resources Deployed
    - type: Available
      status: "True"
      reason: available
      message: System Available
    - type: Reconciled
      status: "True"
      reason: reconciled
      message: Reconciliation completed successfully
  optional:  # (2)
    knative:    # (3)  
      components:
        hpa:
          available: true
        knative:
          available: true
        kourier:
          available: true
    mpi:        # (4) 
      available: true
```

1. Verifies that all mandatory dependencies are met: NVIDIA GPU Operator, Prometheus and NGINX controller. 
2. Checks whether optional product dependencies have been met.
3. See [Inference prerequisites](cluster-prerequisites.md#inference).
4. See [distributed training prerequisites](cluster-prerequisites.md#distributed-training).




For a more extensive verification of cluster health, see [Determining the health of a cluster](../../troubleshooting/cluster-health-check.md).

## Researcher Authentication

You must now set up [Researcher Access Control](../authentication/researcher-authentication.md). 

## (Optional) Set Node Roles

When installing a production cluster you may want to:

* Set one or more Run:ai system nodes. These are nodes dedicated to Run:ai software. 
* Machine learning frequently requires jobs that require CPU but __not GPU__. You may want to direct these jobs to dedicated nodes that do not have GPUs, so as not to overload these machines. 
* Limit Run:ai to specific nodes in the cluster. 

To perform these tasks. See [Set Node Roles](../config/node-roles.md).

## Next Steps

* Set up Run:ai Users [Working with Users](../../admin-ui-setup/admin-ui-users.md).
* Set up Projects for Researchers [Working with Projects](../../admin-ui-setup/project-setup.md).
* Set up Researchers to work with the Run:ai Command-line interface (CLI). See  [Installing the Run:ai Command-line Interface](../../researcher-setup/cli-install.md) on how to install the CLI for users.
* Review [advanced setup and maintenance](../config/overview.md) scenarios.
