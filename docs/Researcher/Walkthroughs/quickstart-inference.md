# Quickstart: Launch an Inference Workload

## Introduction

Machine learning (ML) inference is the process of running live data points into a machine-learning algorithm to calculate an output. 

With Inference, you are taking a trained _Model_ and deploying it into a production environment. The deployment must align with the organization's production standards such as average and 95% response time as well as up-time. 

## Prerequisites 

To complete this Quickstart you must have:

* Run:ai software installed on your Kubernetes cluster. See: [Installing Run:ai on a Kubernetes Cluster](../../admin/runai-setup/installation-types.md). There are additional prerequisites for running inference. See [cluster installation prerequisites](../../admin/runai-setup/cluster-setup/cluster-prerequisites.md#inference) for more information. 
* Run:ai CLI installed on your machine. See: [Installing the Run:ai Command-Line Interface](../../admin/researcher-setup/cli-install.md)
* You must have _ML Engineer_ access rights. See [Adding, Updating and Deleting Users](../../admin/admin-ui-setup/admin-ui-users.md) for more information. 

## Step by Step Walkthrough

### Setup

*  Login to the Projects area of the Run:ai user interface.
*  Add a Project named "team-a".
*  Allocate 2 GPUs to the Project.

### Run an Inference Workload 

*   In the Run:ai user interface go to `Deployments`. If you do not see the `Deployments` section you may not have the required access control, or the inference module is disabled. 
* Select `New Deployment` on the top right.
* Select `team-a` as a project and add an arbitrary name. Use the image `gcr.io/run-ai-demo/example-triton-server`.
* Under `Resources` add 0.5 GPUs.
* Under `Auto Scaling` select a minimum of 1, a maximum of 2. Use the `concurrency` autoscaling threshold method. Add a threshold of 3.
* Add a `Container port` of `8000`.


This would start an inference workload for team-a with an allocation of a single GPU. Follow up on the Job's progress using the [Deployment list](../../admin/admin-ui-setup/deployments.md) in the user interface or by running `runai list jobs`

### Query the Inference Server

The specific inference server we just created is accepting queries over port 8000. You can use the Run:ai Triton demo client to send requests to the server:

* Find an IP address by running `kubectl get svc -n runai-team-a`. Use the `inference1-00001-private` Cluster IP.
* Replace `<IP>` below and run: 

```
 runai submit inference-client  -i gcr.io/run-ai-demo/example-triton-client \
    -- perf_analyzer -m inception_graphdef  -p 3600000 -u  <IP>
```

* To see the result, run the following:

```
runai logs inference-client
```


### View status on the Run:ai User Interface

* Open the Run:ai user interface.
* Under _Deployments_ you can view the new Workload. When clicking the workload, note the utilization graphs go up. 

### Stop Workload

Use the user interface to delete the workload.

## See also

* You can also create Inference deployments via API. For more information see [Submitting Workloads via YAML](../../developer/cluster-api/submit-yaml.md).
* See [Deployment](../../admin/admin-ui-setup/deployments.md) user interface.

