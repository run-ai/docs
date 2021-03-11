# Quickstart: Launch an Inference Workload

## Introduction

Machine learning (ML) inference is the process of running live data points into a machine-learning algorithm to calculate an output. 

With Inference, you are taking a trained _Model_ and deploying it into a production environment. The deployment must align with the organization's production standards such as average and 95% response time as well as up-time. 

For further information on Inference at Run:AI, see [Inference overview](../../developer/inference/overview.md).

## Prerequisites 

To complete this Quickstart you must have:

*   Run:AI software installed on your Kubernetes cluster. See: [Installing Run:AI on an on-premise Kubernetes Cluster](../../Administrator/Cluster-Setup/cluster-install.md)
*   Run:AI CLI installed on your machine. See: [Installing the Run:AI Command-Line Interface](../../Administrator/Researcher-Setup/cli-install.md)

## Step by Step Walkthrough

### Setup

*  Login to the Projects area of the Run:AI Administration user interface at [https://app.run.ai/projects](https://app.run.ai/projects){target=_blank}
*  Add a Project named "team-a".
*  Allocate 2 GPUs to the Project.

### Run an Inference Workload

*   At the command-line run:

```
runai config project team-a
runai submit --name inference1 --service-type nodeport --port 32717  --inference \
    -i gcr.io/run-ai-demo/quickstart-inference-marian  -g 1
```

This would start an inference workload for team-a with an allocation of a single GPU. The inference workload is based on a [sample](https://github.com/run-ai/models/tree/main/models/marian/server){target=_blank} docker image ``gcr.io/run-ai-demo/quickstart-inference-marian``. The inference engine used in this quickstart is [Marian](https://marian-nmt.github.io/){target=_blank}

*   Follow up on the Job's progress by running:

        runai list jobs

The result:

![inference-list.png](img/inference-list.png)

The output shows the service URL with which to connect to the service.

### Query the Inference Server

The specific `Marian` server is accepting queries over the _WebSockets_ protocol. You can use the Run:AI Marian [sample client](https://github.com/run-ai/models/tree/main/models/marian/client){target=_blank}.

In the following command, replace  `<HOSTNAME>` with the service URL displayed in the previous `list` command:

```
runai submit inference-client -i gcr.io/run-ai-demo/quickstart-inference-marian-client \
    -- --hostname <HOSTNAME> --port 32717  --processes 1 
```

To see the result, run the following:

```
runai logs inference-client -f
```

You should see a log of the inference call:

![inference-client-output.png](img/inference-client-output.png)

### View status on the Run:AI User Interface

*   Go to [https://app.run.ai/jobs](https://app.run.ai/jobs){target=_blank}
* Under "Jobs" you can view the new Workload:

![inference-job-list.png](img/inference-job-list.png) 



### Stop Workload

Run the following:

    runai delete inference1

This would stop the inference workload. You can verify this by running ``runai list jobs`` again.

