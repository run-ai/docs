# Launching workloads with GPU fractions

This article provides a step-by-step walkthrough for running a Jupyter Notebook workspace using [GPU fractions](../gpu-fractions.md).

Run:ai’s GPU fractions provides an agile and easy-to-use method to share a GPU or multiple GPUs across workloads. With GPU fractions, you can divide the GPU/s memory into smaller chunks and share the GPU/s compute resources between different workloads and users, resulting in higher GPU utilization and more efficient resource allocation.

### Prerequisites

Before you start, make sure:

* You have created a [project](../../../manage-ai-initiatives/managing-your-organization/projects.md) or have one created for you.
* The project has an assigned quota of at least 0.5 GPU.

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

{% tabs %}
{% tab title="UI" %}
1. Go to the Workload manager → Workloads
2.  Click **+NEW WORKLOAD** and select **Workspace**

    Within the New workspace form:
3. Select under which **cluster** to create the workload
4. Select the **project** in which your workspace will run
5. Select a preconfigured [**template**](../../../workloads-in-runai/workload-templates/) or select the **Start from scratch** to launch a new workspace quickly
6. Enter a **name** for the workspace (if the name already exists in the project, you will be requested to submit a different name)
7.  Click **CONTINUE**

    In the next step:
8. Select the **‘jupyter-lab’** environment for your workspace (Image URL: `jupyter/scipy-notebook)`
   * If the ‘jupyter-lab’ is not displayed in the gallery:
     * Click **+NEW ENVIRONMENT**
     * Enter a **name** for the environment. The name must be unique.
     * Enter the jupyter-lab **Image URL** - `jupyter/scipy-notebook`
     * Tools - Set the connection for your tool
       * Click **+TOOL**
       * Select **Jupyter** tool from the list
     *   Set the runtime settings for the environment

         * Click **+COMMAND**
         * Enter **command** - `start-notebook.sh`
         * Enter **arguments** - `--NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''`

         Note: If -based routing is enabled on the cluster, enter the `--NotebookApp.token=''` only.
     * Click **CREATE ENVIRONMENT**
   * The newly created jupyter-lab will be selected automatically
9. Select the **‘small-fraction’** compute resource for your workspace (GPU % of devices: 10)
   * If ‘small-fraction’ is not displayed in the gallery, follow the step-by-step guide:
     * Click **+NEW COMPUTE RESOURCE**
       * Enter a **name** for the compute resource. The name must be unique.
       * Set **GPU devices per pod** - 1
       * Set **GPU memory per device**
         * Select **% (of device)** - Fraction of a GPU device’s memory
         * Set the memory **Request** - 10 (The workload will allocate 10% of the GPU memory)
       * Optional: set the **CPU compute per pod** - 0.1 cores (default)
       * Optional: set the **CPU memory per pod** - 100 MB (default)
     * Click **CREATE COMPUTE RESOURCE**
   * The newly created small-fraction compute resource will be selected automatically
10. Click **CREATE WORKSPACE**

    After the workspace is created, it is added to the [workloads ](../../../workloads-in-runai/workloads.md)table
{% endtab %}

{% tab title="CLI v1" %}
Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

```sh
runai config project "project-name"
runai submit "workload-name" --jupyter -g 0.1
```

This would start a workspace with a pre-configured Jupyter image with 10% of the GPU memory allocated.
{% endtab %}

{% tab title="CLI v2" %}
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
{% endtab %}

{% tab title="API" %}
Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Workspaces API:](https://api-docs.run.ai/latest/tag/Workspaces)

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
        "image": "jupyter/scipy-notebook",
        "compute": {
            "gpuDevicesRequest": 1
            "gpuRequestType": "portion",
            "gpuPortionRequest": 0.1

        },
        "exposedUrls" : [
            { 
                "container" : 8888,
                "toolType": "jupyter-notebook", \ #toolType will show the Jupyter icon when connecting to the Jupyter tool via the user interface. 
                "toolName": "Jupyter" \ #toolName text will show when connecting to the Jupyter tool via the user interface. 
            }
        ]
    }
}'
```

This would start a workspace with a pre-configured Jupyter image with 10% of the GPU memory allocated.

{% hint style="info" %}
The above API snippet runs with Run:ai clusters of 2.18 and above only. For older clusters, use the now deprecated [Cluster API.](https://docs.run.ai/v2.20/developer/cluster-api/workload-overview-dev/)
{% endhint %}
{% endtab %}
{% endtabs %}

### Step 3: Connecting to the Jupyter Notebook

{% tabs %}
{% tab title="UI" %}
1. Select the newly created workspace with the Jupyter application that you want to connect to
2. Click **CONNECT**
3. Select the Jupyter tool
4. The selected tool is opened in a new tab on your browser
{% endtab %}

{% tab title="CLI v1" %}
To connect to the Jupyter Notebook, browse directly to <mark style="color:blue;">https://\<COMPANY-URL>/\<PROJECT-NAME>/workload-name</mark>
{% endtab %}

{% tab title="CLI v2" %}
To connect to the Jupyter Notebook, browse directly to <mark style="color:blue;">https://\<COMPANY-URL>/\<PROJECT-NAME>/workload-name</mark>
{% endtab %}

{% tab title="API" %}
To connect to the Jupyter Notebook, browse directly to <mark style="color:blue;">https://\<COMPANY-URL>/\<PROJECT-NAME>/workload-name</mark>
{% endtab %}
{% endtabs %}

### Next Steps

Manage and monitor your newly created workspace using the [workloads](../../../workloads-in-runai/workloads.md) table.

>