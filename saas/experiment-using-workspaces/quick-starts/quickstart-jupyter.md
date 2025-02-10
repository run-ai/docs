# Running Jupyter Notebook using workspaces

This guide provides a step-by-step walkthrough for running a Jupyter Notebook using workspaces.

A workspace contains the setup and configuration needed for building your model, including the container, images, data sets, and resource requests, as well as the required tools for the research, all in one place. See [Running workspaces](../running-workspace.md) for more information.

## Prerequisites

Before you start, make sure:

* You have created a [project](../../manage-ai-initiatives/managing-your-organization/projects.md) or have one created for you.
* The project has an assigned quota of at least 1 GPU.

## Step 1: Logging in

{% include "../../.gitbook/includes/step-1-logging-in.md" %}

## Step 2: Submitting a workspace

{% tabs %}
{% tab title="UI" %}
1. Go to the Workload manager → Workloads
2.  Click **+NEW WORKLOAD** and select **Workspace**

    Within the New workspace form:
3. Select under which **cluster** to create the workload
4. Select the **project** in which your workspace will run
5. Select a preconfigured template or select the **Start from scratch** to launch a new workspace quickly
6. Enter a **name** for the workspace (if the name already exists in the project, you will be requested to submit a different name)
7.  Click **CONTINUE**

    In the next step:
8. Select the **‘jupyter-lab’** environment for your workspace (Image URL: `jupyter/scipy-notebook`)
   * If the ‘jupyter-lab’ is not displayed in the gallery, follow the step-by-step guide:
     * Enter a **name** for the environment. The name must be unique.
     * Enter the jupyter-lab **Image URL** - `jupyter/scipy-notebook`
     * Tools - Set the connection for your tool
       * Click **+TOOL**
       * Select **Jupyter** tool from the list
     * Set the runtime settings for the environment
       * Click **+COMMAND**
       * Enter command - `start-notebook.sh`
       *   Enter arguments `- --NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''`

           **Note:**

           If host-based routing is enabled on the cluster, enter the argument `--NotebookApp.token=''` only.
     * Click **CREATE ENVIRONMENT**
   * The newly created jupyter-lab will be selected automatically
9. Select the **‘one-gpu’** compute resource for your workspace (GPU devices: 1)
   * If the ‘one-gpu’ is not displayed in the gallery, follow the step-by-step guide:
     * Click **+NEW COMPUTE RESOURCE**
     * Enter a **name** for the compute resource. The name must be unique.
     * Set **GPU devices per pod** - 1
     * Set **GPU memory per device**
       * Select **% (of device) -** Fraction of a GPU device’s memory
       * Set the memory **Request** - 100 (The workload will allocate 100% of the GPU memory)
     * Optional: set the **CPU compute per pod** - 0.1 cores (default)
     * Optional: set the **CPU memory per pod** - 100 MB (default)
     * Click **CREATE COMPUTE RESOURCE**
   * The newly created one-gpu compute resource will be selected automatically
10. Click **CREATE WORKSPACE**

    After the workspace is created, it is added to the [workloads ](../../workloads-in-runai/workloads.md)table
{% endtab %}

{% tab title="CLI v1" %}
Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

```shell
runai config project "project-name"
runai submit jup1 --jupyter -g 
```

\
This would start a workspace with a pre-configured Jupyter image with one GPU allocated.
{% endtab %}

{% tab title="CLI v2" %}
Copy the following command to your terminal. Make sure to update the below with the name of your project and workload:

```shell
runai project set "project-name"
runai workspace submit workload-name --image jupyter/scipy-notebook --gpu-devices-request 0 --command --external-url 
container=8888 -- start-notebook.sh --NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=
```

This would start a workspace with a pre-configured Jupyter image with one GPU allocated.
{% endtab %}

{% tab title="API" %}
Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Workspaces API:](https://api-docs.run.ai/latest/tag/Workspaces)

```shell
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

This would start a workspace with a pre-configured Jupyter image with one GPU allocated.

{% hint style="info" %}
The above API snippet runs with Run:ai clusters of 2.18 and above only. For older clusters, use the now deprecated [Cluster API](https://docs.run.ai/v2.20/developer/cluster-api/workload-overview-dev/).
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

## Next Steps

Manage and monitor your newly created workspace using the [workloads table](../workloads-in-runai/workloads.md).
