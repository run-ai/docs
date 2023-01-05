Node affinity with cloud node pools
===========

Run:Ai allows for [node affinity](../../admin-ui-setup/project-setup.md#other-project-properties). In order to use this feature, the "run.ai/node-type" label needs to be configured correcly on the target nodes. Most cloud clusters allow to configure node labels for the node pools in the cluster. This guide show how to apply this configuration for different cloud providers.

In order to make the node affinity work with cloud providers node pools we need to make sure the node pools are configured with the appropriate Kubernetes label (run.ai/type=TYPE_VALUE)

## GKE

### Setting node labels while creating a new cluster

1- At the first creation screen, you will see a manual on the left side with the section "node-pools" in it. in this section, look for the node pool you want

2- Expand the node pool

3- Click on "Metadata"

4- Near the buttom, you will find the Kubernetes label section. There you can add or edit labels

5- Add the key "run.ai/type"

6- Add the value TYPE_VALUE

### Setting node labels for a new node pool

1- At the node pool creation screen, go the the "metadata" section

2- Near the buttom, you will find the Kubernetes label section. There you can add or edit labels

3- Add the key "run.ai/type"

4- Add the value TYPE_VALUE

### Editing node labels for an exising node pool

1- Go to the Google Kubernetes Engine page in the Google Cloud console

2- Go to Google Kubernetes Engine

3- In the cluster list, click the name of the cluster you want to modify

4- Click the Nodes tab

5- Under Node Pools, click the name of the node pool you want to modify, then click edit Edit

6- Near the buttom, you will find the Kubernetes label section. There you can add or edit labels

7- Add the key "run.ai/type"

8- Add the value TYPE_VALUE


## AKS

You can configure node-pool labels at cluster creation time

### Setting node labels while creating a new cluster

1- When creating AKS cluster at the node-pools page click on create new node-pool

2- In the form that been opened you have section of "Labels"

3- In the Key put the follwing value: run.ai/type

4- In the Value put the type 

### Setting node labels for a new node pool

1- Go to your AKS page at Azure

2- In the left menu there is a node-pools button, click on it

3- Click on Add Node Pool

4- In the new Node Pool page go to Optional settings

5- Go to the labels section

6- In the key put the following value run.ai/type

7- In the value put the type

### Editing node labels for an exising node pool

Update existing node pools label is done through azure cli:

Run the following command:

az aks nodepool update \
    --resource-group [RESOURCE GROUP] \
    --cluster-name [CLUSTER NAME] \
    --name labelnp \
    --labels run.ai/type=[TYPE] \
    --no-wait


## EKS

You can configure node-pool labels at cluster creation time

### Setting node labels while creating a new cluster

1- Create regular EKS cluster

2- Click on compute

3- Click on "Add node group"

4- In the Kubernetes labels section click on "Add label"

5- In the key type "run.ai/type"

6- In the value type the value

### Setting node labels for a new node pool

3- Go to "Add node group" form

4- In the Kubernetes labels section click on "Add label"

5- In the key type "run.ai/type"

6- In the value type the value

### Editing node labels for an exising node pool

1- Go to the node group page

2- Click on "Edit"

3- Go to "Kubernetes labels"

4- Click on "Add label"

5- In the key type "run.ai/type"

6- In the value type the value
