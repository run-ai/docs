# Quickstart: Launch an Inference Workload

## Introduction

Machine learning (ML) inference refers to the process of using a trained machine learning model to make predictions or generate outputs based on new, unseen data. After a model has been trained on a dataset, inference involves applying this model to new examples to produce results such as classifications, predictions, or other types of insights.

The quickstart below shows an inference _server_ running the model and an inference _client_.

There are various ways to submit a Workload:

* Run:ai __command-line interface (CLI)__
* Run:ai __user interface__
* Run:ai __API__

At this time, Inference services cannot be created via the CLI. The CLI __can__ be used for creating a client to query the inference service.

## Prerequisites


To complete this Quickstart, the [Infrastructure Administrator](../../admin/overview-administrator.md) will need to install some optional inference prerequisites as described [here](../../admin/runai-setup/cluster-setup/cluster-prerequisites.md#inference).

To complete this Quickstart, the [Platform Administrator](../../platform-admin/overview.md) will need to provide you with:

* _ML Engineer_ access to _Project_ in Run:ai named "team-a"
* The project should be assigned a quota of at least 1 GPU. 
* The URL of the Run:ai Console. E.g. [https://acme.run.ai](https://acme.run.ai).

As described, the inference client can be created via CLI. To perform this, you will need to have the Run:ai CLI installed on your machine. There are two available CLI variants:

* The older V1 CLI. See installation [here](../../admin/researcher-setup/cli-install.md)
* A newer V2 CLI, supported with clusters of version 2.18 and up. See installation [here](../../admin/researcher-setup/new-cli-install.md)

## Step by Step Walkthrough

### Login

=== "CLI V1"
    Run `runai login` and enter your credentials.

=== "CLI V2"
    Run `runai login` and enter your credentials.

=== "User Interface"
    Browse to the provided Run:ai user interface and log in with your credentials.

=== "API"
    To use the API, you will need to obtain a token. Please follow the [api authentication](../../developer/rest-auth.md) article.


### Create an Inference Server Environment

To complete this Quickstart __via the UI__, you will need to create a new Inference Server [Environment](../workloads/assets/environments.md) asset. 

This is a __one-time__ step for all Inference workloads using the same image.

Under `Environments` Select __NEW ENVIRONMENT__. Then select:

* A default (cluster) scope.
* Use the environment name `inference-server`.
* The image `gcr.io/run-ai-demo/example-triton-server`.
* Under `type of workload` select `inference`.
* Under `endpoint` set the container port as `8000` which is the port that the triton server is using. 



### Run an Inference Workload


=== "CLI V1"
    Not available right now.

=== "CLI V2"
    Not available right now.

=== "User Interface"
    * In the Run:ai UI select __Workloads__
    * Select __New Workload__ and then __Inference__
    * You should already have `Cluster` and `Project` selected. Enter `inference-server-1` as the name and press __CONTINUE__.
    * Under `Environment`,  select `inference-server`.
    * Under `Compute Resource`, select `half-gpu`. 
    * Under `Replica autoscaling, select a minimum of 0 and a maximum of 2. 
    * Under `conditions for a new replica` select `Concurrency` and set the value as 3.
    * Select the scale to zero option to `5 minutes`
    * Select __CREATE INFERENCE__.
    
    !!! Note
        For more information on submitting Workloads and creating Assets via the user interface, see [Workload documentation](../workloads/workspaces/overview.md).

=== "API"
    ``` bash
    curl -L 'https://<COMPANY-URL>/api/v1/workloads/inferences' \ # (1)
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer <TOKEN>' \ # (2)
    -d '{ 
        "name": "inference-server-1", 
        "projectId": "<PROJECT-ID>", '\ # (3)
        "clusterId": "<CLUSTER-UUID>", \ # (4)
        "spec": {
            "image": "gcr.io/run-ai-demo/example-triton-server",
            "servingPort": {
                "protocol": "http",
                "container": 8000
            },
            "autoscaling": {
                "minReplicas": 0,
                "maxReplicas": 2,
                "metric": "concurrency",
                "metricThreshold": 3,
                "scaleToZeroRetentionSeconds": 300
            },
            "compute": {
                "cpuCoreRequest": 0.1,
                "gpuRequestType": "portion",
                "cpuMemoryRequest": "100M",
                "gpuDevicesRequest": 1,
                "gpuPortionRequest": 0.5
            }
        }
    }'
    ``` 

    1. `<COMPANY-URL>` is the link to the Run:ai user interface. For example `acme.run.ai`
    2. `<TOKEN>` is an API access token. see above on how to obtain a valid token.
    3. `<PROJECT-ID>` is the the ID of the `team-a` Project. You can get the Project ID via the [Get Projects API](https://app.run.ai/api/docs#tag/Projects/operation/get_projects){target=_blank}
    4. `<CLUSTER-UUID>` is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view. 


    !!! Note
        * The above API snippet will only work with Run:ai clusters of 2.18 and above. For older clusters, use, the now deprecated [Cluster API](../../developer/cluster-api/submit-rest.md).
        * For more information on the Inference Submit API see [API Documentation](https://app.run.ai/api/docs#tag/Inferences) 

This would start a triton inference server with a maximum of 2 instances, each instance consumes half a GPU. 


### Query the Inference Server

You can use the Run:ai Triton demo client to send requests to the server

#### Find the Inference Server Endpoint

* Under `Workloads`, select `Columns` on the top right. Add the column `Connections.
* See the connections of the `inference-server-1` workload: 

![](img/inference-connections.png)

* Copy the inference endpoint URL.

=== "CLI V1"
    Open a terminal and run:

    ``` bash
    runai config project team-a   
    runai submit inference-client-1  -i gcr.io/run-ai-demo/example-triton-client \
    -- perf_analyzer -m inception_graphdef  -p 3600000 -u  <INFERENCE-ENDPOINT>    
    ```


=== "CLI V2"
    Open a terminal and run:

    ``` bash
    runai project set team-a
    runai training submit inference-client-1  -i gcr.io/run-ai-demo/example-triton-client \
    -- perf_analyzer -m inception_graphdef  -p 3600000 -u  <INFERENCE-ENDPOINT>    
    ```

=== "User Interface"
    * In the Run:ai UI select __Workloads__
    * Select __New Workload__ and then __Training__
    * You should already have `Cluster`, `Project` and a `start from scratch` `Template` selected. Enter `inference-client-1` as the name and press __CONTINUE__.
    * Select __NEW ENVIRONMENT__. Enter `inference-client` as the name and `gcr.io/run-ai-demo/example-triton-client` as the image. 
    Select __CREATE ENVIRONMENT__.
    * When the previous screen comes up, select `cpu-only` under the Compute resource.
    * Under `runtime settings` enter the command as `perf_analyzer` and arguments `-m inception_graphdef  -p 3600000 -u  <INFERENCE-ENDPOINT>` (replace inference endpoint with above).
    * Select __CREATE TRAINING__.
  


In the user interface, under `inference-server-1`, go to the `Metrics` tab and watch as the various GPU metrics graphs rise. 




### Stop Workload

Run the following:

=== "CLI V1"
    Not available right now

=== "CLI V2"
    Not available right now

=== "User Interface"
    Select the two workloads and press __DELETE__.


