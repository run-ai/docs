# Run your First Standard Training

This article provides a step-by-step walkthrough for running a standard training workload.

A training workload contains the setup and configuration needed for building your model, including the container, images, data sets, and resource requests, as well as the required tools for the research, all in a single place. 


## Prerequisites 

Before you start, make sure:

- You have created a [project](../../../../platform-admin/aiinitiatives/org/projects.md) or have one created for you.
- The project has an assigned quota of at least 1 GPU.


## Step 1: Logging in

=== "User Interface"
    Browse to the provided Run:ai user interface and log in with your credentials.

=== "CLI V2"
    Run the below --help command to obtain the login options and log in according to your setup:
    
    ``` bash
    runai login --help  
    ```

=== "CLI V1 [Deprecated]"
    Log in using the following command. You will be prompted to enter your username and password:

    ``` bash
    runai login
    ```

=== "API"
    To use the API, you will need to obtain a token. Please follow the [API authentication](../../../../developer/rest-auth.md) article.


## Step 2: Submitting a standard training workload

=== "User Interface"
    1. Go to the Workload manager → Workloads
    2. Click __+NEW WORKLOAD__ and select __Training__   
    3. Select under which __cluster__ to create the workload
    4. Select the __project__ in which your workload will run
    5. Under __Workload architecture__, select __Standard__ 
    6. Select a preconfigured template or select the __Start from scratch__ to launch a new workload quickly
    7. Enter a __name__ for the standard training workload (if the name already exists in the project, you will be requested to submit a different name)
    8. Click __CONTINUE__
    9. Click __+NEW ENVIRONMENT__
        
        a. Enter __quickstart__ as the name
        
        b. Enter __runai.jfrog.io/demo/quickstart__ as the __Image URL__
        
        c. Click __CREATE ENVIRONMENT__
     
    10. Select the __‘one-gpu’__ compute resource for your workload (GPU devices: 1) 
        * If the ‘one-gpu’ is not displayed in the gallery, follow the step-by-step guide: 
        
        ??? "Create a one-gpu compute resource"

            1. Click __+NEW COMPUTE RESOURCE__
            2. Enter a __name__ for the compute resource. The name must be unique.
            3. Set __GPU devices per pod - 1__
            4. Set __GPU memory per device__ 

                - Select __% (of device)__ - Fraction of a GPU device’s memory
                - Set the memory __Request__ - 100 (The workload will allocate 100% of the GPU memory)

            5. Optional: set the __CPU compute per pod__ - 0.1 cores (default)
            6. Optional: set the __CPU memory per pod__ - 100 MB (default)
            7. Click __CREATE COMPUTE RESOURCE__

        * The newly created one-gpu compute resource will be selected automatically

    11. Click __CONTINUE__
    12. Click __CREATE TRAINING__
        
        After the standard training workload is created, it is added to the [workloads table](../../../../platform-admin/workloads/overviews/managing-workloads.md).

=== "CLI V2"
    Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

    ``` bash
    runai project set "project-name"
    runai training submit "workload-name" -i runai.jfrog.io/demo/quickstart -g 1
    ```

    This would start a standard training workload based on a sample docker image, runai.jfrog.io/demo/quickstart, with one GPU allocated.

=== "CLI V1 [Deprecated]"
    Copy the following command to your terminal. Make sure to update the below with the name of your project:

    ``` bash
    runai config project "project-name"  
    runai submit "workload-name" -i runai.jfrog.io/demo/quickstart -g 1
    ```

    This would start a standard training workload based on a sample docker image, runai.jfrog.io/demo/quickstart, with one GPU allocated.

=== "API"
    Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Trainings API reference](https://api-docs.run.ai/latest/tag/Trainings):

    ``` bash
    curl -L 'https://<COMPANY-URL>/api/v1/workloads/trainings' \ 
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer <TOKEN>' \
    -d '{ 
        "name": "workload-name", 
        "projectId": "<PROJECT-ID>",
        "clusterId": "<CLUSTER-UUID>",
        "spec": {  
           "image": "runai.jfrog.io/demo/quickstart", 
           "compute": { 
           "gpuDevicesRequest": 1
           } 
        } 
    }
    ``` 

    1. `<COMPANY-URL>` is the link to the Run:ai user interface.
    2. `<TOKEN>` is the API access token obtained in Step 1. 
    3. `<PROJECT-ID>` is #The ID of the Project the workload is running on. You can get the Project ID via the Get Projects API [Get Projects API](https://app.run.ai/api/docs#tag/Projects/operation/get_projects){target=_blank}.
    4. `<CLUSTER-UUID>` is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view. 

    This would start a standard training workload based on a sample docker image, runai.jfrog.io/demo/quickstart, with one GPU allocated.
    
    !!! Note
        The above API snippet will only work with Run:ai clusters of 2.18 and above.



## Next Steps

* Manage and monitor your newly created workload using the [workloads table](../../../../platform-admin/workloads/overviews/managing-workloads.md).
* After validating your training performance and results, deploy your model using [inference](../../inference/custom-inference.md).