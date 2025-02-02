# Run your First Distributed Training

This article provides a step-by-step walkthrough for running a PyTorch distributed training workload.

Distributed training is the ability to split the training of a model among multiple processors. Each processor is called a worker. Worker nodes work in parallel to speed up model training. There is also a master which coordinates the workers.

## Prerequisites 

Before you start, make sure:

- You have created a [project](../../manage-ai-initiatives/managing-your-organization/projects.md) or have one created for you.
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
    To use the API, you will need to obtain a token. Please follow the [API authentication](../../../../developer/rest-auth.md) article.


## Step 2: Submitting a distributed training workload

=== "User Interface"
    1. Go to the Workload manager → Workloads
    2. Click __+NEW WORKLOAD__ and select __Training__   
    3. Select under which __cluster__ to create the workload
    4. Select the __project__ in which your workload will run
    5. Under __Workload architecture__, select __Distributed__ and choose __PyTorch__. Set the distributed training configuration to __Worker & master__
    6. Select a preconfigured template or select the __Start from scratch__ to launch a new workload quickly
    7. Enter a __name__ for the distributed training workload (if the name already exists in the project, you will be requested to submit a different name)
    8. Click __CONTINUE__
    9. Click __+NEW ENVIRONMENT__
       
        a. Enter __pytorch-dt__ as the name
        
        b. Enter __kubeflow/pytorch-dist-mnist:latest__ as the __Image URL__
        
        c. Click __CREATE ENVIRONMENT__
     
    10. When the previous screen comes up, enter 2 workers and select ‘small-fraction’ as the compute resource for your workload
        * If the ‘small-fraction’ is not displayed in the gallery, follow the step-by-step guide: 
        
        ??? "Create a small-fraction compute resource"

            1. Click __+NEW COMPUTE RESOURCE__
            2. Select under which cluster to create the compute resource
            3. Select a scope
            4. Enter a __name__ for the compute resource. The name must be unique.
            5. Set __GPU devices per pod - 1__
            6. Set __GPU memory per device__ 

                - Select __% (of device)__ - Fraction of a GPU device’s memory

            7. Optional: set the __CPU compute per pod__ - 0.1 cores (default)
            8. Optional: set the __CPU memory per pod__ - 100 MB (default)
            9. Click __CREATE COMPUTE RESOURCE__

        * The newly created small-fraction compute resource will be selected automatically

    11. Click __CONTINUE__
    12. Click __CREATE TRAINING__
        
        After the distributed training workload is created, it is added to the [workloads table](../../../../platform-admin/workloads/overviews/managing-workloads.md).


=== "CLI V1"
    Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:
    
    ``` bash
    runai config project "project-name"  
    runai submit-dist pytorch "workload-name" --workers=2 -g 0.1 \
       -i kubeflow/pytorch-dist-mnist:latest
    ```

    This would start a distributed training workload based on kubeflow/pytorch-dist-mnist:latest with one master and two workers.

=== "CLI V2"
    Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

    ``` bash
    runai project set "project-name"
    runai distributed submit "workload-name" --framework PyTorch \
       -i kubeflow/pytorch-dist-mnist:latest --workers 2 
       --gpu-request-type portion --gpu-portion-request 0.1 --gpu-devices-request 1 --cpu-memory-request 100M
    ```

    This would start a distributed training workload based on kubeflow/pytorch-dist-mnist:latest with one master and two workers.

=== "API"
    Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Distributed API reference](https://api-docs.run.ai/latest/tag/Distributed):

    ``` bash
    curl -L 'https://<COMPANY-URL>/api/v1/workloads/distributed' \ # (1)
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer <TOKEN>' \ # (2)
    -d '{ 
        "name": "workload-name", 
        "projectId": "<PROJECT-ID>", '\ # (3)
        "clusterId": "<CLUSTER-UUID>", \ # (4)
        "spec": {  
            "compute": { 
                "cpuCoreRequest": 0.1,
                "gpuRequestType": "portion",
                "cpuMemoryRequest": "100M",
                "gpuDevicesRequest": 1,
                "gpuPortionRequest": 0.1 
            },      
            "image": "kubeflow/pytorch-dist-mnist:latest",  
            "numWorkers": 2,  \ 
            "distributedFramework": "PyTorch" \
        } 
    }'
    ``` 

    1. `<COMPANY-URL>` is the link to the Run:ai user interface.
    2. `<TOKEN>` is the API access token obtained in Step 1. 
    3. `<PROJECT-ID>` is #The ID of the Project the workload is running on. You can get the Project ID via the Get Projects API [Get Projects API](https://app.run.ai/api/docs#tag/Projects/operation/get_projects).
    4. `<CLUSTER-UUID>` is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view. 

    This would start a distributed training workload based on kubeflow/pytorch-dist-mnist:latest with one master and two workers.

    !!! Note
        The above API snippet will only work with Run:ai clusters of 2.18 and above. For older clusters, use, the now deprecated [Cluster API](../../../../developer/cluster-api/submit-rest.md).



## Next Steps

* Manage and monitor your newly created workload using the [workloads table](../../workloads-in-runai/workloads.md).
* After validating your training performance and results, deploy your model using [inference](../../inference/inference-overview.md).