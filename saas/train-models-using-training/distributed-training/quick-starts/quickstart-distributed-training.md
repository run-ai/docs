# Run your first distributed training

This article provides a step-by-step walkthrough for running a PyTorch distributed training workload.

Distributed training is the ability to split the training of a model among multiple processors. Each processor is called a worker. Worker nodes work in parallel to speed up model training. There is also a master which coordinates the workers.

## Prerequisites

Before you start, make sure:

* You have created a [project](../../manage-ai-initiatives/managing-your-organization/projects.md) or have one created for you.
* The project has an assigned quota of at least 1 GPU.

## Step 1: Logging in

## Step 2: Submitting a standard training workload

{% tabs %}
{% tab title="UI" %}
1. Go to the Workload manager → Workloads
2. Click **+NEW WORKLOAD** and select **Training**
3. Select under which **cluster** to create the workload
4. Select the **project** in which your workload will run
5. Under **Workload architecture,** select **Distributed** and choose **PyTorch.** Set the distributed training configuration to **Worker & master**
6. Select a preconfigured [template](../../../workloads-in-runai/workload-templates/) or select the **Start from scratch** to launch a new workload quickly
7. Enter a **name** for the standard training workload (if the name already exists in the project, you will be requested to submit a different name)
8. Click **CONTINUE**
9. Click **+NEW ENVIRONMENT**
   * Enter **pytorch-dt** as the name
   * Enter `kubeflow/pytorch-dist-mnist:latest` as the **Image URL**
   * Click **CREATE ENVIRONMENT**
10. When the previous screen comes up, select the **‘small-fraction’** compute resource for your workload (GPU devices: 1)
    * If the ‘small-fraction’ is not displayed in the gallery, follow the step-by-step guide:
      * Click **+NEW COMPUTE RESOURCE**
      * Enter a **name** for the compute resource. The name must be unique.
      * Set **GPU devices per pod** - 1
      * Set **GPU memory per device**
        * Select **% (of device) -** Fraction of a GPU device’s memory
      * Optional: set the **CPU compute per pod** - 0.1 cores (default)
      * Optional: set the **CPU memory per pod** - 100 MB (default)
      * Click **CREATE COMPUTE RESOURCE**
    * The newly created small-fraction compute resource will be selected automatically
11. Select **CREATE TRAINING**

    After the training workload is created, it is added to the [workloads ](../../../workloads-in-runai/workloads.md)table
{% endtab %}

{% tab title="CLI v1" %}
Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

```sh
// runai config project "project-name"  
runai submit-dist pytorch pytorch-dt --workers=2 -g 0.1 \
    -i kubeflow/pytorch-dist-mnist:latest
```

This would start a distributed training workload based on `kubeflow/pytorch-dist-mnist:latest` with one master and two workers.
{% endtab %}

{% tab title="CLI v2" %}
Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

```sh
// runai project set "project-name"
runai distributed submit pytorch-dt --framework PyTorch \
    -i kubeflow/pytorch-dist-mnist:latest --workers 2 
    --gpu-request-type portion --gpu-portion-request 0.1 --gpu-devices-request 1 --cpu-memory-request 100M
```

This would start a distributed training workload based on `kubeflow/pytorch-dist-mnist:latest` with one master and two workers.
{% endtab %}

{% tab title="API" %}
Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Distributed API](https://api-docs.run.ai/latest/tag/Distributed):

```shell
bash curl -L 'https://<COMPANY-URL>/api/v1/workloads/distributed' \ #<COMPANY-URL> is the link to the Run:ai user interface. 
-H 'Content-Type: application/json' \ 
-H 'Authorization: Bearer <TOKEN>' \ #<TOKEN> is the API access token obtained in Step 1.  
-d '{  
    "name": "workload-name",  
    "projectId": "<PROJECT-ID>", '\ #The ID of the Project the workspace is running on. You can get the Project ID via the Get Projects API.  
    "clusterId": "<CLUSTER-UUID>", \ #<CLUSTER-UUID> is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view.  
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

This would start a distributed training workload based on `kubeflow/pytorch-dist-mnist:latest` with one master and two workers.

{% hint style="info" %}
The above API snippet runs with Run:ai clusters of 2.18 and above only. For older clusters, use the now deprecated [Cluster API.](https://docs.run.ai/v2.20/developer/cluster-api/workload-overview-dev/)
{% endhint %}
{% endtab %}
{% endtabs %}

## Next Steps

* Manage and monitor your newly created workload using the [workloads table](../../workloads-in-runai/workloads.md).
* After validating your training performance and results, deploy your model using [inference](../../inference/custom-inference.md).
