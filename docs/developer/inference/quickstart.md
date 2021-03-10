# Quickstart: Launch Inference Jobs

## Introduction



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
runai submit --name inference1 --service-type nodeport --port 8888  --inference \
    -i gcr.io/run-ai-demo/quickstart-inference-marian  -g 1
```

This would start an inference Job for team-a with an allocation of a single GPU. The inference Job is based on a [sample](https://github.com/run-ai/models/tree/main/models/marian/server){target=_blank} docker image ``gcr.io/run-ai-demo/quickstart-inference-marian``. The inference engine is using [Marian](https://marian-nmt.github.io/){target=_blank}

*   Follow up on the Job's progress by running:

        runai list jobs

The result:

__XXX MISSING PICTURE XXX __

<!-- ![mceclip00.png](img/mceclip00.png) -->


### Query the Inference Server

The specific `marian` server is accepting queries over the _WebSockets_ protocol. You can use the sample client provided in XXXX..

....



### View Logs

Run the following:

    runai logs train1

You should see a log of a running deep learning session:

<!-- ![mceclip1.png](img/mceclip1.png) -->

### View status on the Run:AI User Interface

*   Go to [https://app.run.ai/jobs](https://app.run.ai/jobs){target=_blank}
* Under "Jobs" you can view the new Workload:

<!-- ![mceclip2.png](img/mceclip2.png) -->

The image we used for training includes the Run:AI Training library. Among other features, this library allows the reporting of metrics from within the deep learning Job. Metrics such as progress, accuracy, loss, and epoch and step numbers.  

*   Progress can be seen in the status column above. 
*   To see other metrics, press the settings wheel on the top right 
<!-- 
![mceclip4.png](img/mceclip4.png)  -->

and select additional deep learning metrics from the list


Under Nodes you can see node utilization:

<!-- ![mceclip5.png](img/mceclip5.png) -->

### Stop Workload

Run the following:

    runai delete train1

This would stop the training workload. You can verify this by running ``runai list jobs`` again.

## Next Steps

<!-- *   Follow the Quickstart document: [Launch Interactive Workloads](walkthrough-build.md) -->
*   Use your container to run an unattended training workload