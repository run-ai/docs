Node affinity with cloud node pools
===========

Run:Ai allows for [node affinity](../../admin-ui-setup/project-setup.md#other-project-properties). In order to use this feature, the run-ai/node-type label needs to be configured correcly on the target nodes. Most cloud clusters allow to configure node labels for the node pools in the cluster. This guide show how to apply this configuration for different cloud providers.

## GKE

Each node pool has a seperate Kubernetes labels configurations. The labels can be set either at cluster creation time, node pool creation time or on an existing node pool.

### Setting node labels while creating a new cluster:

1- At the first creation screen, you will see a manual on the left side with the section "node-pools" in it. in this section, look for the node pool you want.

2- Expand the node pool.

3- Click on "metadata"

4- Near the buttom, you will find the Kubernetes label section. There you can add or edit labels.

5- After the cluster and the nodes has been created, you will be able to see the labels you configured on the nodes.

### Setting node labels for a new node pool:

1- At the node pool creation screen, go the the "metadata" section.

2- Near the buttom, you will find the Kubernetes label section. There you can add or edit labels.

3- After nodes of the node pools has been created, you will be able to see the labels you configured on the nodes.

### Editing nodes labels for an exising node pool:

1- Go to the Google Kubernetes Engine page in the Google Cloud console.

2- Go to Google Kubernetes Engine

3- In the cluster list, click the name of the cluster you want to modify.

4- Click the Nodes tab.

5- Under Node Pools, click the name of the node pool you want to modify, then click edit Edit.

6- Near the buttom, you will find the Kubernetes label section. There you can add or edit labels.

7- Click save. Upon saving, GKE will update all the nodes in the node pool with the changes. It can take a few minutes. 