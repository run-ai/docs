# Node affinity with cloud node pools

Run:ai allows for [node affinity](../../admin-ui-setup/project-setup.md#other-project-properties). Node affinity is the ability to assign a Project to run on specific nodes.
To use the node affinity feature, You will need to label the target nodes with the label  `run.ai/node-type`. Most cloud clusters allow configuring node labels for the node pools in the cluster. This guide shows how to apply this configuration to different cloud providers.

To make the node affinity work with node pools on various cloud providers, we need to make sure the node pools are configured with the appropriate Kubernetes label (`run.ai/type=<TYPE_VALUE>`).


## Setting node labels while creating a new cluster

You can configure node-pool labels at cluster creation time

=== "GKE"
    * At the first creation screen, you will see a menu on the left side named `node-pools`.
    * Expand the node pool you want to label.
    * Click on `Metadata`.
    * Near the bottom, you will find the Kubernetes `label` section. Add the key `run.ai/type` and the value `<TYPE_VALUE>`.

=== "AKS"
    * When creating AKS cluster at the node-pools page click on create new node-pool.
    * Go to the `labels` section and add key `run.ai/type` and the value `<TYPE_VALUE>`.


=== "EKS"
    * Create a regular EKS cluster.
    * Click on `compute`.
    * Click on `Add node group`.
    * In the Kubernetes `labels` section click on `Add label`. Add the key `run.ai/type` and the value `<TYPE_VALUE>`.


## Setting node labels for a new node pool

=== "GKE"
    * At the node pool creation screen, go to the `metadata` section.
    * Near the bottom, you will find the Kubernetes `label` section. Add the key `run.ai/type` and the value `<TYPE_VALUE>`.

=== "AKS"
    * Go to your AKS page at Azure.
    * On the left menu click the `node-pools` button.
    * Click on `Add Node Pool`.
    * In the new Node Pool page go to `Optional settings`.
    * In the Kubernetes `labels` section click on `Add label`. Add the key `run.ai/type` and the value `<TYPE_VALUE>`.

=== "EKS"
    * Go to `Add node group` screen.
    * In the Kubernetes `labels` section click on `Add label`. Add the key `run.ai/type` and the value `<TYPE_VALUE>`.

## Editing node labels for an existing node pool

=== "GKE"
    * Go to the `Google Kubernetes Engine` page in the Google Cloud console.
    * Go to `Google Kubernetes Engine`.
    * In the cluster list, click the name of the cluster you want to modify.
    * Click the `Nodes` tab
    * Under `Node Pools`, click the name of the node pool you want to modify, then click `Edit`.
    * Near the bottom, you will find the Kubernetes `label` section. Add the key `run.ai/type` and the value `<TYPE_VALUE>`.


=== "AKS"

    To update an existing node pool label you must use the _azure cli_. Run the following command:

    ```
    az aks nodepool update \
        --resource-group [RESOURCE GROUP] \
        --cluster-name [CLUSTER NAME] \
        --name labelnp \
        --labels run.ai/type=[TYPE_VALUE] \
        --no-wait
    ```

=== "EKS"

    * Go to the `node group` page and click on `Edit`.
    * In the Kubernetes `labels` section click on `Add label`. Add the key `run.ai/type` and the value `<TYPE_VALUE>`.





