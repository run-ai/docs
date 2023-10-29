# Viewing and Submitting Deployments

The Run:ai User interface Deployment area allows the viewing and submitting of Deployments for serving inference workloads. Submitting inference workloads can only be done if your user has `ML Engineer` access.

## Deployment list

The main view shows a list of Deployments:

![job-list](img/deployment-list.png)


## Submit a Deployment
On the top right, you can choose to Submit a new Deployment. 
!!! Note
    If [knative is not installed in your cluster](../runai-setup/cluster-setup/cluster-prerequisites.md#inference) the button will be grayed out.

A Deployment form will open: 

![submit-job](img/submit-deployment.png)

!!! Note
    If the _Deploy_ button is disabled or does not exist, then your cluster is not installed or configured to connect to the cluster see [here](overview.md) for more information.

## Deployment Properties

When selecting a single Deployment, a right-pane appears:

![job-properties](img/deployment-properties.png)

This multi-tab view provides information about Deployment details, related Pods, Deployment status history, and various utilization graphs. 

