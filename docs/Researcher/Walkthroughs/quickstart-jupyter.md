# Running Jupyter Notebook using workspaces


This guide provides a step-by-step walkthrough for running a Jupyter Notebook using workspaces.

A workspace contains the setup and configuration needed for building your model, including the container, images, data sets, and resource requests, as well as the required tools for the research, all in one place. See [Running workspaces](../workloads/workspaces/workspace-v2.md). for more information.



## Prerequisites 

Before you start, make sure:

- You have created a project or have one created for you.
- The project has an assigned quota of at least 1 GPU.


## Step 1: Logging in

=== "User Interface"
    Browse to the provided Run:ai user interface and log in with your credentials.

=== "CLI V1"
    Log in using the following command. You will be prompted to enter your username and password:
     
    ``` bash
    runai login
    ```

=== "CLI V2"
    Run the below --help command to obtain the login options and log in according to your setup:
    
    ``` bash
    runai login --help  
    ```

=== "API"
    To use the API, you will need to obtain a token. Please follow the [API authentication](../../developer/rest-auth.md) article.


## Step 2: Submitting a workspace

=== "User Interface"
    1. Go to the Workload manager → Workloads
    2. Select __+NEW WORKLOAD__ and then __Workspace__
       Within the New workspace form:
    3. Select under which __cluster__ to create the workload
    4. Select the __project__ in which your workspace will run
    5. Select a preconfigured template or select the __Start from scratch__ to launch a new workspace quickly
    6. Enter a __name__ for the workspace (If the name already exists in the project, you will be    requested to submit a different name)
    7. Click __CONTINUE__
    8. Select the __‘jupyter-lab’__ environment for your workspace (Image URL: jupyter/scipy-notebook)
        
        * If the ‘jupyter-lab’ is not displayed in the gallery, follow the step-by-step guide: 

        ??? "Create a jupyter-lab environment"

             1. Click __+NEW ENVIRONMENT__
             2. Select under which cluster to create the environment
             3. Select a [scope](../workloads/assets/overview.md). 
             4. Enter a __name__ for the environment. The name must be unique.
             5. Enter the jupyter-lab __Image URL__ - jupyter/scipy-notebook
             6. Tools - Set the connection for your tool 

                 * Click __+TOOL__
                 * Select __Jupyter__ tool from the list
             7. Set the runtime settings for the environment 

                 * Click __+COMMAND__ 
                 * Enter __command__ - start-notebook.sh
                 * Enter __arguments__ - `--NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''`
               
                 !!! Note
                     If host-based routing is enabled on the cluster, enter the argument `--NotebookApp.token=''` only.
             8. Click __CREATE ENVIRONMENT__
            
        * The newly created jupyter-lab will be selected automatically
    9. Select the __‘one-gpu’__ compute resource for your workspace (GPU devices: 1) 
        * If the ‘one-gpu’ is not displayed in the gallery, follow the step-by-step guide: 
        
        ??? "Create a one-gpu compute resource"

            1. Click __+NEW COMPUTE RESOURCE__
            2. Select under which cluster to create the compute resource
            3. Select a scope
            4. Enter a __name__ for the compute resource. The name must be unique.
            5. Set __GPU devices per pod - 1__
            6. Set __GPU memory per device__ 

                - Select __% (of device)__ - Fraction of a GPU device’s memory
                - Set the memory __Request__ - 100 (The workload will allocate 100% of the GPU memory)

            7. Optional: set the __CPU compute per pod__ - 0.1 cores (default)
            8. Optional: set the __CPU memory per pod__ - 100 MB (default)
            9. Click __CREATE COMPUTE RESOURCE__

        * The newly created one-gpu compute resource will be selected automatically

    10. Click __CREATE WORKSPACE__
        
        After the workspace is created, it is added to the [workloads table](../workloads/overviews/managing-workloads.md).


=== "CLI V1"
    Copy the following command to your terminal. Make sure to update the below with the name of your project:
    
    ``` bash
    runai config project "project-name"  
    runai submit jup1 --jupyter -g 1
    ```

    This would start a workspace with a pre-configured Jupyter image with one GPU allocated.

    !!! Note
        For more information on the workload submit command, see [cli documentation](../cli-reference/runai-submit.md).

=== "CLI V2"
    Copy the following command to your terminal. Make sure to update the below with the name of your project:

    ``` bash
    runai project set "project-name"
    runai workspace submit jup1  --image jupyter/scipy-notebook --gpu-devices-request 1 \
        --external-url container=8888  --command start-notebook.sh  \
        -- --NotebookApp.base_url=/\${RUNAI_PROJECT}/\${RUNAI_JOB_NAME} --NotebookApp.token=''
    ```

    !!! Note
        For more information on submitting Workloads and creating Assets via the user interface, see [Workload documentation](../workloads/workspaces/overview.md).

=== "API"
    Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Workspaces API reference](https://api-docs.run.ai/latest/tag/Workspaces):

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

    1. `<COMPANY-URL>` is the link to the Run:ai user interface.
    2. `<TOKEN>` is the API access token obtained in Step 1. 
    3. `<PROJECT-ID>` is #The ID of the Project the workspace is running on. You can get the Project ID via the Get Projects API [Get Projects API](https://app.run.ai/api/docs#tag/Projects/operation/get_projects){target=_blank}.
    4. `<CLUSTER-UUID>` is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view. 
    5. `toolType` will show the Jupyter icon when connecting to the Jupyter tool via the user interface. 
    6. `toolName` text will show when connecting to the Jupyter tool via the user interface.

    !!! Note
        The above API snippet will only work with Run:ai clusters of 2.18 and above. For older clusters, use, the now deprecated [Cluster API](../../developer/cluster-api/submit-rest.md).



## Step 3: Connecting to the Jupyter Notebook

=== "User Interface"
    1. Select the newly created workspace with the Jupyter application that you want to connect to
    2. Click __CONNECT__
    3. Select the __Jupyter__ tool 
    4. The selected tool is opened in a new tab on your browser

=== "CLI V1"
    To connect to the Jupyter Notebook, browse directly to `https://<COMPANY-URL>/<PROJECT-NAME>/jup1`.


=== "CLI V1"
    To connect to the Jupyter Notebook, browse directly to `https://<COMPANY-URL>/<PROJECT-NAME>/jup1`.

=== "API"
    To connect to the Jupyter Notebook, browse directly to `https://<COMPANY-URL>/<PROJECT-NAME>/jup1`.


## Next Steps

Manage and monitor your newly created workspace using the [workloads table](../workloads/overviews/managing-workloads.md).