# Launching workloads with dynamic GPU fractions

This article provides a step-by-step walkthrough for running a Jupyter Notebook with [dynamic GPU fractions](dynamic-gpu-fractions.md).

Run:ai’s dynamic GPU fractions optimizes GPU utilization by enabling workloads to dynamically adjust their resource usage. It allows users to specify a guaranteed fraction of GPU memory and compute resources with a higher limit that can be dynamically utilized when additional resources are requested.

## Prerequisites

Before you start, make sure:

* You have created a [project](../../platform-admin/aiinitiatives/org/projects.md) or have one created for you.
* The project has an assigned quota of at least 0.5 GPU.
* Dynamic GPU fractions is enabled. 

!!! Note
    Dynamic GPU fractions is disabled by default in the Run:ai UI. To use dynamic GPU fractions, it must be enabled by your Administrator, under **General Settings** → Resources → GPU resource optimization.

## Step 1: Logging in

=== "UI"
    Browse to the provided Run:ai user interface and log in with your credentials.

=== "CLI v2"
    Run the below --help command to obtain the login options and log in according to your setup:
    
    ``` bash
    runai login --help  
    ```

=== "API"
    To use the API, you will need to obtain a token. Please follow the [API authentication](../../developer/rest-auth.md) article.

## Step 2: Submitting the first workspace

=== "UI"

    1. Go to the Workload manager → Workloads
    2. Click **+NEW WORKLOAD** and select **Workspace**

        Within the New workspace form:
    3. Select under which **cluster** to create the workspace
    4. Select the **project** in which your workspace will run
    5. Select a preconfigured [**template**](../../platform-admin/workloads/assets/templates.md) or select the **Start from scratch** to launch a new workspace quickly
    6. Enter a **name** for the workspace (if the name already exists in the project, you will be requested to submit a different name)
    7. Click **CONTINUE**
        
        In the next step:

    8. Create **‘jupyter-lab-name’** environment for your workspace

        1. Click **+NEW ENVIRONMENT**
        2. Enter a **name** for the environment. The name must be unique.
        3. Enter the **Image URL** - `gcr.io/run-ai-lab/pytorch-example-jupyter`
        4. Tools - Set the connection for your tool

            * Click **+TOOL**
            * Select **Jupyter** tool from the list

        5. Set the runtime settings for the environment

            * Click **+COMMAND**
            * Enter **command** - `start-notebook.sh`
            * Enter **arguments** - `--NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''`

            Note: If host-based routing is enabled on the cluster, enter the  `--NotebookApp.token=''` only.

        6. Click **CREATE ENVIRONMENT**

        The newly created jupyter-lab-name will be selected automatically

    9. Create a new “**request-limit**” compute resource

        1. Click **+NEW COMPUTE RESOURCE**
        2. Enter a **name** for the compute resource. The name must be unique.
        3. Set **GPU devices per pod** - 1
        4. Set **GPU memory per device**
            * Select GB **-** fraction of a GPU device’s memory
            * Set the memory **Request** to **4GB** (The workload will allocate 4GB of the GPU memory)
            * Toggle **Limit** and set to **12**
        5. Optional: set the **CPU compute per pod** - 0.1 cores (default)
        6. Optional: set the **CPU memory per pod** - 100 MB (default)
        7. Select **More settings** and toggle **Increase shared memory size**
        8. Click **CREATE COMPUTE RESOURCE**

        The newly created request-limit compute resource will be selected automatically
        
    10. Click **CREATE WORKSPACE**

        After the workspace is created, it is added to the [workloads](../../platform-admin/workloads/overviews/managing-workloads.md) table

=== "CLI v2"
    Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

    ```sh
    runai project set "project-name"
    runai workspace submit "workload-name" --image gcr.io/run-ai-lab/pytorch-example-jupyter --gpu-memory-request 4G 
    --gpu-memory-limit 12G --large-shm --external-url container=8888 
    --name-prefix jupyter --command -- start-notebook.sh 
    --NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} 
    --NotebookApp.token=
    ```

=== "API"
    Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Workspaces API:](https://api-docs.run.ai/latest/tag/Workspaces)

    ```bash
    curl -L 'https://<COMPANY-URL>/api/v1/workloads/workspaces' \ #<COMPANY-URL> is the link to the Run:ai user interface.
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer <TOKEN>' \ #<TOKEN> is the API access token obtained in Step 1. 
    -d '{ 
        "name": "workload-name", 
        "projectId": "<PROJECT-ID>", '\ #The ID of the Project the workspace is running on. You can get the Project ID via the Get Projects API. 
        "clusterId": "<CLUSTER-UUID>", \ #<CLUSTER-UUID> is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view. 
        "spec": {
            "command" : "start-notebook.sh",
            "args" : "--NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''",
            "image": "gcr.io/run-ai-lab/pytorch-example-jupyter",
            "exposedUrls": [
              {
                "container": 8888,
                "toolType": "jupyter-notebook",
                "toolName": "Jupyter"
              }
            ],
            "compute": {
              "gpuDevicesRequest": 1,
              "gpuMemoryRequest": "4G",
              "gpuMemoryLimit": "12G",
              "largeShmRequest": true
            }     
        }
    }'
    ```
    !!! Note
        The above API snippet runs with Run:ai clusters of 2.18 and above only. 


## Step 3: Submitting the second workspace

=== "UI"

    1. Go to the Workload manager → Workloads
    2. Click **+NEW WORKLOAD** and select **Workspace**

        Within the New workspace form:
    3. Select the **cluster** where the previous workspace was created
    4. Select the **project** where the previous workspace was created
    5. Select a preconfigured **template** or select the **Start from scratch** to launch a new workspace quickly
    6. Enter a **name** for the workspace (if the name already exists in the project, you will be requested to submit a different name)
    7.  Click **CONTINUE**

        In the next step:
    8. Select the environment created in the previous step
    9. Select the compute resource created in the previous step
    10. Click **CREATE WORKSPACE**

    After the workspace is created, it is added to the [workloads](../../platform-admin/workloads/overviews/managing-workloads.md) table

=== "CLI v2"
    Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

    ```sh
    runai project set "project-name"
    runai workspace submit "workload-name" --image gcr.io/run-ai-lab/pytorch-example-jupyter --gpu-memory-request 4G 
    --gpu-memory-limit 12G --large-shm --external-url container=8888 
    --name-prefix jupyter --command -- start-notebook.sh 
    --NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} 
    --NotebookApp.token=
    ``` 

=== "API"
    Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Workspaces API](https://api-docs.run.ai/latest/tag/Workspaces):

    ```bash
    curl -L 'https://<COMPANY-URL>/api/v1/workloads/workspaces' \ #<COMPANY-URL> is the link to the Run:ai user interface.
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer <TOKEN>' \ #<TOKEN> is the API access token obtained in Step 1. 
    -d '{ 
        "name": "workload-name", 
        "projectId": "<PROJECT-ID>", '\ #The ID of the Project the workspace is running on. You can get the Project ID via the Get Projects API. 
        "clusterId": "<CLUSTER-UUID>", \ #<CLUSTER-UUID> is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view. 
        "spec": {
            "command" : "start-notebook.sh",
            "args" : "--NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''",
            "image": "gcr.io/run-ai-lab/pytorch-example-jupyter",
            "exposedUrls": [
              {
                "container": 8888,
                "toolType": "jupyter-notebook",
                "toolName": "Jupyter"
              }
            ],
            "compute": {
              "gpuDevicesRequest": 1,
              "gpuMemoryRequest": "4G",
              "gpuMemoryLimit": "12G",
              "largeShmRequest": true
            }
        }
    }'
    ```

    !!! Note
        The above API snippet runs with Run:ai clusters of 2.18 and above only. 


## Step 4: Connecting to the Jupyter Notebook

=== "UI"

    1. Select the newly created workspace with the Jupyter application that you want to connect to
    2. Click **CONNECT**
    3. Select the Jupyter tool
    4. The selected tool is opened in a new tab on your browser
    5. Open a terminal and use the `watch nvidia-smi` to get a constant reading of the memory consumed by the pod. Note that the number shown in the memory box is the Limit and not the Request or Guarantee.
    6. Open the file `Untitled.ipynb` and move the frame so you can see both tabs
    7. Execute both cells in `Untitled.ipynb`. This will consume about **3 GB of GPU memory** and be well below the 4GB of the **GPU Memory Request** value.
    8. In the second cell, edit the value after `--image-size` from 100 to 200 and run the cell. This will increase the GPU memory utilization to about 11.5 GB which is above the Request value.

=== "CLI v2"

    1. To connect to the Jupyter Notebook, browse directly to`https://<COMPANY-URL>/<PROJECT-NAME>/<WORKLOAD_NAME>`
    2. Open a terminal and use the `watch nvidia-smi` to get a constant reading of the memory consumed by the pod. Note that the number shown in the memory box is the Limit and not the Request or Guarantee.
    3. Open the file `Untitled.ipynb` and move the frame so you can see both tabs
    4. Execute both cells in `Untitled.ipynb`. This will consume about **3 GB of GPU memory** and be well below the 4GB of the **GPU Memory Request** value.
    5. In the second cell, edit the value after `--image-size` from 100 to 200 and run the cell. This will increase the GPU memory utilization to about 11.5 GB which is above the Request value.

=== "API"

    1. To connect to the Jupyter Notebook, browse directly to `https://<COMPANY-URL>/<PROJECT-NAME>/<WORKLOAD_NAME>`
    2. Open a terminal and use the `watch nvidia-smi` to get a constant reading of the memory consumed by the pod. Note that the number shown in the memory box is the Limit and not the Request or Guarantee.
    3. Open the file `Untitled.ipynb` and move the frame so you can see both tabs
    4. Execute both cells in `Untitled.ipynb`. This will consume about **3 GB of GPU memory** and be well below the 4GB of the **GPU Memory Request** value.
    5. In the second cell, edit the value after `--image-size` from 100 to 200 and run the cell. This will increase the GPU memory utilization to about 11.5 GB which is above the Request value.
  

## Next Steps

Manage and monitor your newly created workspace using the [workloads](../../platform-admin/workloads/overviews/managing-workloads.md) table.