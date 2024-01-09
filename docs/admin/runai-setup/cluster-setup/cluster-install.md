Below are instructions on how to install a Run:ai cluster.

## Prerequisites
Before installing, please review the installation prerequisites here: [Run:ai GPU Cluster Prerequisites](cluster-prerequisites.md).

!!! Important
    It is strongly recommend that you run the Run:ai [pre-install script](cluster-prerequisites.md#pre-install-script) to verify that all prerequisites are met.

## Install Run:ai

Log in to Run:ai user interface at `<company-name>.run.ai`. Use credentials provided by Run:ai Customer Support:

* If no clusters are currently configured, you will see a Cluster installation wizard.
* If a cluster has already been configured, use the menu on the top left and select `Clusters`. On the top left, click `New Cluster`.

Using the cluster wizard:

* Choose a name for your cluster.
* Choose the Run:ai version for the cluster.
* Choose a target Kubernetes distribution (see [table](cluster-prerequisites.md#kubernetes) for supported distributions).
* (SaaS and remote self-hosted cluster only) Enter the URL of a Kubernetes cluster. The URL need only be accessible within the organization's network. For more informtaion see [here](cluster-prerequisites.md#cluster-url).
* Press `Continue`.

On the next page:

* (SaaS and remote self-hosted cluster only) Install a trusted certificate to the domain entered above.
* Run the [Helm](https://helm.sh/docs/intro/install/) command provided in the wizard.

## Verify your Installation

* Go to `<company-name>.run.ai/dashboards/now`.
* Verify that the number of GPUs on the top right reflects your GPU resources on your cluster and the list of machines with GPU resources appears on the bottom line.
* Run: `kubectl get cm runai-public -n runai -o jsonpath='{.data}' | yq -P`

(assumes that [yq](https://mikefarah.gitbook.io/yq/v/v3.x/){target=_blank} is instaled)

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

## Cluster Table

After you have installed your cluster on the platform, you will see it appear in the *Cluster Table*. The *Cluster Table* provides a quick and easy way to see the status of your cluster.

In the left menu, press *Clusters* to view the cluster table. Use *Add filter* to add one or more filter results based on the columns that are in the table. In the *Contains* pane, you can use partial or complete text. Filtered text is ***not*** case sensitive. To remove the filter, press *X* next to the filter.

The table provides the following columns:

* **Cluster**&mdash;the name of the cluster.
* **Status**&mdash;the status of the cluster. For more information see [Cluster status](#cluster-status). Hover over the information icon to see a short description and links to troubleshooting.
* **Creation time**&mdash;the timestamp the cluster was created.
* **URL**&mdash;the URL that was given to the cluster at the time of creation.
* **Run:ai cluster version**&mdash;the Run:ai version installed on the cluster.
* **Run:ai cluster UUI**&mdash;the unique ID of the cluster.

### Cluster Status

The following table describes the different statuses that a cluster could be in.

| Status | Description |
| -- | -- |
| Waiting to connect | The cluster has never been connected. |
| Disconnected | There is no communication from the cluster to the Control Plane. This may be due to a network issue. |
| Missing prerequisites | At least one of the [Mandatory Prerequisites](cluster-prerequisites.md#prerequisites-in-a-nutshell) has not been met. |
| Service issues | At least one of the *Services* is not working properly. You can view the list of nonfunctioning services for more information |
| Connected | All services are connected and up and running. |

See the [Troubleshooting guide](../../troubleshooting/cluster-health-check.md#verifying-cluster-health) to help troubleshoot issues in the cluster.

## Researcher Authentication

If you will be using the Run:ai [command-line interface](../../researcher-setup/cli-install.md) or sending [YAMLs directly](../../../developer/cluster-api/submit-yaml.md) to Kubernetes, you must now set up [Researcher Access Control](../authentication/researcher-authentication.md).

## Customize your installation

To customize specific aspects of the cluster installation see [customize cluster installation](customize-cluster-install.md).

## (Optional) Set Node Roles

When installing a production cluster you may want to:

* Set one or more Run:ai system nodes. These are nodes dedicated to Run:ai software.
* Machine learning frequently requires jobs that require CPU but **not GPU**. You may want to direct these jobs to dedicated nodes that do not have GPUs, so as not to overload these machines.
* Limit Run:ai to specific nodes in the cluster.

To perform these tasks. See [Set Node Roles](../config/node-roles.md).

## Next Steps

* Set up Run:ai Users [Working with Users](../../admin-ui-setup/admin-ui-users.md).
* Set up Projects for Researchers [Working with Projects](../../admin-ui-setup/project-setup.md).
* Set up Researchers to work with the Run:ai Command-line interface (CLI). See  [Installing the Run:ai Command-line Interface](../../researcher-setup/cli-install.md) on how to install the CLI for users.
* Review [advanced setup and maintenance](../config/overview.md) scenarios.
