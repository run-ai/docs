# Quickstart: Launch WorkSpace with a Jupyter Notebook

## Introduction

The purpose of this article is to provide a quick ramp-up to running a Jupyter Notebook Workspace. Workspaces are containers that live forever until deleted by the user. 


There are various ways to submit a Workspace:

* Run:ai __command-line interface (CLI)__
* Run:ai __user interface__
* Run:ai __API__

## Prerequisites 

To complete this Quickstart, the [Platform Administrator](../../platform-admin/overview.md) will need to provide you with:

* _Researcher_ access to _Project_ in Run:ai named "team-a"
* The project should be assigned a quota of at least 1 GPU. 
* A URL of the Run:ai Console. E.g. [https://acme.run.ai](https://acme.run.ai).

To complete this Quickstart __via the CLI__, you will need to have the Run:ai CLI installed on your machine. There are two available CLI variants:

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


### Run Workload


=== "CLI V1"
    Open a terminal and run:

    ``` bash
    runai config project team-a   
    runai submit jup1 --jupyter -g 1
    ```

    !!! Note
        For more information on the workload submit command, see [cli documentation](../cli-reference/runai-submit.md).

=== "CLI V2"
    Open a terminal and run:

    ``` bash
    runai project set team-a
    runai workspace submit jup1  --image jupyter/scipy-notebook --gpu-devices-request 1 \
        --external-url container=8888  --command start-notebook.sh  \
        -- --NotebookApp.base_url=/\${RUNAI_PROJECT}/\${RUNAI_JOB_NAME} --NotebookApp.token=''
    ```

    !!! Note
        For more information on the workspace submit command, see [cli documentation](../cli-reference/new-cli/runai_workspace_submit.md).

=== "User Interface"
    * In the Run:ai UI select __Workloads__
    * Select __New Workload__ and then __Workspace__
    * You should already have `Cluster`, `Project` and a `start from scratch` `Template` selected. Enter `jup1` as the name and press __CONTINUE__.
    * Under `Environment`,  select `jupyter-lab`.
    * Under `Compute Resource`, select `one-gpu`. 
    * Select __CREATE WORKSPACE__.
    
    !!! Note
        For more information on submitting Workloads and creating Assets via the user interface, see [Workload documentation](../user-interface/workspaces/overview.md).

=== "API"
    ``` bash
    curl -L 'https://<COMPANY-URL>/api/v1/workloads/workspaces' \ # (1)
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer <TOKEN>' \ # (2)
    -d '{ 
        "name": "jup1", 
        "projectId": "<PROJECT-ID>", '\ # (3)
        "clusterId": "<CLUSTER-UUID>", \ # (4)
        "spec": {
            "command" : "start-notebook.sh",
            "args" : "--NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''",
            "image": "jupyter/scipy-notebook",
            "compute": {
                "gpuDevicesRequest": 1
            },
            "exposedUrls" : [
                { 
                    "container" : 8888,
                    "toolType": "jupyter-notebook", \ # (5)
                    "toolName": "Jupyter" \ # (6)
                }
            ]
        }
    }'
    ``` 

    1. `<COMPANY-URL>` is the link to the Run:ai user interface. For example `acme.run.ai`
    2. `<TOKEN>` is an API access token. see above on how to obtain a valid token.
    3. `<PROJECT-ID>` is the the ID of the `team-a` Project. You can get the Project ID via the [Get Projects API](https://app.run.ai/api/docs#tag/Projects/operation/get_projects){target=_blank}
    4. `<CLUSTER-UUID>` is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view. 
    5. `toolType` will show the Jupyter icon when connecting to the Jupyter tool via the user interface. 
    6. `toolName` text will show when connecting to the Jupyter tool via the user interface.

    !!! Note
        * The above API snippet will only work with Run:ai clusters of 2.18 and above. For older clusters, use, the now deprecated [Cluster API](../../developer/cluster-api/submit-rest.md).
        * For more information on the Training Submit API see [API Documentation](https://app.run.ai/api/docs#tag/Trainings/operation/create_training1) 

This would start a Workspace with a pre-configured Jupyter image with an allocation of a single GPU. 


### Accessing the Jupyter Notebook

Via the Run:ai user interface, go to `Workloads`, select the `jup1` Workspace and press `Connect`.

Alternatively, browse directly to `https://<COMPANY-URL>/team-a/jup1`.