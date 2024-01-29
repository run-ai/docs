Below are instructions on how to install a Run:ai cluster.

## Prerequisites
Before installing, please review the installation prerequisites here: [Run:ai GPU Cluster Prerequisites](cluster-prerequisites.md).


!!! Important
    We strongly recommend running the Run:ai [pre-install script](cluster-prerequisites.md#pre-install-script) to verify that all prerequisites are met.

## Install Run:ai

Log in to Run:ai user interface at `<company-name>.run.ai`. Use credentials provided by Run:ai Customer Support:

*   If no clusters are currently configured, you will see a Cluster installation wizard.
*   If a cluster has already been configured, use the menu on the top left and select `Clusters`. On the top left, click `New Cluster`.

Using the cluster wizard:

* Choose a name for your cluster.
* Choose the Run:ai version for the cluster.
* Choose a target Kubernetes distribution (see [table](cluster-prerequisites.md#kubernetes) for supported distributions).
* (SaaS and remote self-hosted cluster only) Enter a URL for the Kubernetes cluster. The URL need only be accessible within the organization's network. For more information, see [Cluster prerequisites](cluster-prerequisites.md#cluster-url).
* Press `Continue`.

On the next page:

* (SaaS and remote self-hosted cluster only) Install a trusted certificate to the domain entered above.
*  Run the [Helm](https://helm.sh/docs/intro/install/) command provided in the wizard.


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
  runaiConfigStatus:
    conditions:
    - type: DependenciesFulfilled   # (1)
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
    - type: Reconciled              # (2)
      status: "True"
      reason: reconciled
      message: Reconciliation completed successfully
  optional:  # (3)
    knative:    # (4)  
      components:
        hpa:
          available: true
        knative:
          available: true
        kourier:
          available: true
    mpi:        # (5) 
      available: true
```

1. Verifies that all mandatory dependencies are met: NVIDIA GPU Operator, Prometheus and NGINX controller.
2. Verifies that all of Run:ai managed resources have been successfully deployed.
3. Checks whether optional product dependencies have been met.
4. See [Inference prerequisites](cluster-prerequisites.md#inference).
5. See [distributed training prerequisites](cluster-prerequisites.md#distributed-training).

For a more extensive verification of cluster health, see [Determining the health of a cluster](../../troubleshooting/cluster-health-check.md).

### Troubleshooting
#### Dependencies are not fulfilled
1. Make sure to install the missing dependencies.
2. If dependencies are installed, make sure that the CRDs of said dependency are installed, and that the version is supported
3. Make sure there are no necessary adjustments for specific flavors as noted here https://docs.run.ai/v2.15/admin/runai-setup/cluster-setup/cluster-prerequisites

#### Resources not deployed / System Unavailable / Reconciliation Failed
1. Run Preinstall diagnostic script https://docs.run.ai/v2.15/admin/runai-setup/cluster-setup/cluster-prerequisites/#pre-install-script and check for issues
2. Run
```
   kubectl get pods -n runai
   kubectl get pods -n monitoring
```
and obtain logs from any failing pod `kubectl logs <pod_name>`

#### Common Issues
1. Run:ai was previously installed in the cluster and was deleted unsuccessfully, resulting in remaining CRDs
    2. Diagnosis: This can be detected by running `kubectl get crds` in the relevant namespaces (or adding `-A` and checking for Run:ai CRDs)
    3. Solution: Force delete said CRDs and reinstall
3. One or more of the pods have issues around valid certificates
    4. Diagnosis: The logs contains a message similar to the following `failed to verify certificate: x509: certificate signed by unknown authority`
    4. Solution:
        5. This is usually due to an expired or invalid certificate in the cluster, and if so - renew the certificate
        6. If Certificate is valid, but is Signed by a local CA, make sure to have followed the steps here https://docs.run.ai/v2.15/admin/runai-setup/config/org-cert/

## Researcher Authentication

If you will be using the Run:ai [command-line interface](../../researcher-setup/cli-install.md) or sending [YAMLs directly](../../../developer/cluster-api/submit-yaml.md) to Kubernetes, you must now set up [Researcher Access Control](../authentication/researcher-authentication.md).

## Customize your installation

To customize specific aspects of the cluster installation see [customize cluster installation](customize-cluster-install.md).

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