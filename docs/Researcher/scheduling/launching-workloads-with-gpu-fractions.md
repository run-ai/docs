# Launching workloads with GPU fractions

This article provides a step-by-step walkthrough for running a Jupyter Notebook workspace using [GPU fractions](fractions.md).

Run:ai’s GPU fractions provides an agile and easy-to-use method to share a GPU or multiple GPUs across workloads. With GPU fractions, you can divide the GPU/s memory into smaller chunks and share the GPU/s compute resources between different workloads and users, resulting in higher GPU utilization and more efficient resource allocation.

## Prerequisites

Before you start, make sure:

* You have created a [project](../../platform-admin/aiinitiatives/org/projects.md) or have one created for you.
* The project has an assigned quota of at least 0.5 GPU.

## Step 1: Logging in

=== "UI"

    Browse to the provided Run:ai user interface and log in with your credentials.

=== "CLI v2"

    Run the below --help command to obtain the login options and log in according to your setup:
    
    ``` bash
    runai login --help  
    ```
=== "CLI v1 (Deprecated)"

    Log in using the following command. You will be prompted to enter your username and password:
     
    ``` bash
    runai login
    ```

=== "API"
    To use the API, you will need to obtain a token. Please follow the [API authentication](../../developer/rest-auth.md) article.

## Step 2: Submitting a workspace

=== "UI"

    1. Go to the Workload manager → Workloads
    2. Click **+NEW WORKLOAD** and select **Workspace**

        Within the New workspace form:
    3. Select under which **cluster** to create the workspace
    4. Select the **project** in which your workspace will run
    5. Select a preconfigured [**template**](../../platform-admin/workloads/assets/templates.md) or select the **Start from scratch** to launch a new workspace quickly
    6. Enter a **name** for the workspace (if the name already exists in the project, you will be requested to submit a different name)
    7.  Click **CONTINUE**

        In the next step:
    
    8. Select the __‘jupyter-lab’__ environment for your workspace (Image URL: jupyter/scipy-notebook)
        
        * If the ‘jupyter-lab’ is not displayed in the gallery, follow the step-by-step guide: 

        ??? "Create a jupyter-lab environment"

             1. Click __+NEW ENVIRONMENT__
             2. Enter a __name__ for the environment. The name must be unique.
             3. Enter the jupyter-lab __Image URL__ - jupyter/scipy-notebook
             4. Tools - Set the connection for your tool 

                 * Click __+TOOL__
                 * Select __Jupyter__ tool from the list
             5. Set the runtime settings for the environment 

                 * Click __+COMMAND__ 
                 * Enter __command__ - start-notebook.sh
                 * Enter __arguments__ - `--NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''`
               
                !!! Note
                    If host-based routing is enabled on the cluster, enter the argument `--NotebookApp.token=''` only.

             6. Click __CREATE ENVIRONMENT__
            
        * The newly created jupyter-lab will be selected automatically
    9. Select the **‘small-fraction’** compute resource for your workspace (GPU % of devices: 10)
       
        * If ‘small-fraction’ is not displayed in the gallery, follow the step-by-step guide:

        ??? "Create a small-fraction compute resource"

            1. Click **+NEW COMPUTE RESOURCE**
            2. Enter a **name** for the compute resource. The name must be unique.
            3. Set **GPU devices per pod** - 1
            4. Set **GPU memory per device**
                * Select **% (of device)** - Fraction of a GPU device’s memory
                * Set the memory **Request** - 10 (The workload will allocate 10% of the GPU memory)
            5. Optional: set the **CPU compute per pod** - 0.1 cores (default)
            6. Optional: set the **CPU memory per pod** - 100 MB (default)
            7. Click **CREATE COMPUTE RESOURCE**
        * The newly created small-fraction compute resource will be selected automatically

    10. Click **CREATE WORKSPACE**

        After the workspace is created, it is added to the [workloads](../../platform-admin/workloads/overviews/managing-workloads.md) table


=== "CLI v2"

    Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

    ```sh
    runai project set "project-name"
    runai workspace submit "workload-name" --image jupyter/scipy-notebook 
    --gpu-devices-request 0.1 --command --external-url container=8888 
    --name-prefix jupyter --command -- start-notebook.sh 
    --NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} 
    --NotebookApp.token=
    ```

    This would start a workspace with a pre-configured Jupyter image with 10% of the GPU memory allocated.

=== "CLI v1 (Deprecated)"

    Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

    ```sh
    runai config project "project-name"
    runai submit "workload-name" --jupyter -g 0.1
    ```

    This would start a workspace with a pre-configured Jupyter image with 10% of the GPU memory allocated.

=== "API"

    Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Workspaces API](https://api-docs.run.ai/latest/tag/Workspaces):

    ```sh
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
            "image": "jupyter/base-notebook",
            "exposedUrls": [
              {
                "container": 8888,
                "toolType": "jupyter-notebook",
                "toolName": "Jupyter"
              }
            ],
            "compute": {
              "gpuDevicesRequest": 1,
              "gpuRequestType": "portion",
              "gpuPortionRequest": 0.1

            }
        }
    }'
    ```

    This would start a workspace with a pre-configured Jupyter image with 10% of the GPU memory allocated.

    !!! Note
        The above API snippet runs with Run:ai clusters of 2.18 and above only. For older clusters, use the now deprecated [Cluster API](https://docs.run.ai/v2.20/developer/cluster-api/workload-overview-dev/).


## Step 3: Connecting to the Jupyter Notebook

=== "UI"

    1. Select the newly created workspace with the Jupyter application that you want to connect to
    2. Click **CONNECT**
    3. Select the Jupyter tool
    4. The selected tool is opened in a new tab on your browser


=== "CLI v2"
    To connect to the Jupyter Notebook, browse directly to `https://<COMPANY-URL>/<PROJECT-NAME>/<WORKLOAD_NAME>`


=== "CLI v1 (Deprecated)"
    To connect to the Jupyter Notebook, browse directly to `https://<COMPANY-URL>/<PROJECT-NAME>/<WORKLOAD_NAME>`

=== "API"
    To connect to the Jupyter Notebook, browse directly to `https://<COMPANY-URL>/<PROJECT-NAME>/<WORKLOAD_NAME>`
    
## Next Steps

Manage and monitor your newly created workspace using the [workloads](../../platform-admin/workloads/overviews/managing-workloads.md) table.