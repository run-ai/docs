# Launching workloads with GPU memory swap

This guide provides a step-by-step walkthrough for running multiple LLMs (inference workload) on a single GPU using [GPU memory swap](gpu-memory-swap.md).

GPU memory swap expands the GPU physical memory to the CPU memory, allowing Run:ai to place and run more workloads on the same GPU physical hardware. This provides a smooth workload context switching between GPU memory and CPU memory, eliminating the need to kill workloads when the memory requirement is larger than what the GPU physical memory can provide.

## Prerequisites

Before you start, make sure:

* You have created a [project](../../platform-admin/aiinitiatives/org/projects.md) or have one created for you.
* The project has an assigned quota of at least 1 GPU.
* [Dynamic GPU fractions](dynamic-gpu-fractions.md) is enabled. 
* GPU memory swap is enabled on at least one free node as detailed [here](gpu-memory-swap.md#enabling-and-configuring-gpu-memory-swap).
* [Host-based routing](../../admin/config/allow-external-access-to-containers.md) is configured.

!!! Note
    Dynamic GPU fractions is disabled by default in the Run:ai UI. To use dynamic GPU fractions, it must be enabled by your Administrator, under **General Settings** → Resources → GPU resource optimization.

## Step 1: Logging in

=== "UI"
    Browse to the provided Run:ai user interface and log in with your credentials.

=== "API"
    To use the API, you will need to obtain a token. Please follow the [API authentication](../../developer/rest-auth.md) article.

## Step 2: Submitting the first inference workload

=== "UI"

    1. Go to the Workload manager → Workloads
    2. Click **+NEW WORKLOAD** and select **Inference**

        Within the new inference form:
    3. Select under which **cluster** to create the workload
    4. Select the **project** in which your workload will run
    6. Enter a **name** for the workload (if the name already exists in the project, you will be requested to submit a different name)
    7.  Click **CONTINUE**

        In the next step:
    8.  Create an environment for your workload

        1. Click **+NEW ENVIRONMENT**
        2. Enter a **name** for the environment. The name must be unique.
        3. Enter the Run:ai vLLM **Image URL** - `runai.jfrog.io/core-llm/runai-vllm:v0.6.4-0.10.0`
        4. Set the runtime settings for the environment
            * Click **+ENVIRONMENT VARIABLE** and add the following
                * **Name:** RUNAI\_MODEL **Source:** Custom **Value:** `meta-llama/Llama-3.2-1B-Instruct` (you can choose any vLLM supporting model from Hugging Face)
                * **Name:** RUNAI\_MODEL\_NAME **Source:** Custom **Value:** `Llama-3.2-1B-Instruct`
                * **Name:** HF\_TOKEN **Source:** Custom **Value:** Your Hugging Face token (only needed for gated models)
                * **Name:** VLLM\_RPC\_TIMEOUT **Source:** Custom **Value:** 60000
        5. Click **CREATE ENVIRONMENT**

        The newly created environment will be selected automatically
    9.  Create a new “**request-limit**” compute resource

        1. Click **+NEW COMPUTE RESOURCE**
        2. Enter a **name** for the compute resource. The name must be unique.
        3. Set **GPU devices per pod** - 1
        4. Set **GPU memory per device**
            * Select % (of device) - fraction of a GPU device’s memory
            * Set the memory **Request** to **50%** (The workload will allocate 50% of the GPU memory)
            * Toggle **Limit** and set to **100%**
        5. Optional: set the **CPU compute per pod** - 0.1 cores (default)
        6. Optional: set the **CPU memory per pod** - 100 MB (default)
        7. Select **More settings** and toggle **Increase shared memory size**
        8. Click **CREATE COMPUTE RESOURCE**

        The newly created request-limit compute resource will be selected automatically
    10. Click **CREATE INFERENCE**

        After the inference workload is created, it is added to the [workloads](../../platform-admin/workloads/overviews/managing-workloads.md) table

=== "API"

    Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Inferences API](https://api-docs.run.ai/latest/tag/Inferences#operation/create_inference1):

    ```sh
    curl -L 'https://<COMPANY-URL>/api/v1/workloads/inferences' \ #<COMPANY-URL> is the link to the Run:ai user interface.
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer <TOKEN>' \ #<TOKEN> is the API access token obtained in Step 1. 
    -d '{ 
        "name": "workload-name", 
        "useGivenNameAsPrefix": true,
        "projectId": "<PROJECT-ID>", '\ #The ID of the Project the workspace is running on. You can get the Project ID via the Get Projects API. 
        "clusterId": "<CLUSTER-UUID>", \ #<CLUSTER-UUID> is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view. 
        "spec": {
            "image": "runai.jfrog.io/core-llm/runai-vllm:v0.6.4-0.10.0",
            "imagePullPolicy":"IfNotPresent",
            "environmentVariables": [
            {
              "name": "RUNAI_MODEL",
              "value": "meta-lama/Llama-3.2-1B-Instruct"
            },
            {
              "name": "VLLM_RPC_TIMEOUT",
              "value": "60000"
            },
            {
              "name": "HF_TOKEN",
              "value":"<INSERT HUGGINGFACE TOKEN>"
            }
            ],
            "compute": {
                "gpuDevicesRequest": 1,
                "gpuRequestType": "portion",
                "gpuPortionRequest": 0.1,
                "gpuPortionLimit": 1,
                "cpuCoreRequest":0.2,
                "cpuMemoryRequest": "200M",
                "largeShmRequest": false

            },
            "servingPort": {
                "container": 8000,
                "protocol": "http",
                "authorizationType": "public"
        }
    }'       
    ```

    !!! Note
        The above API snippet runs with Run:ai clusters of 2.18 and above only. 


## Step 3: Submitting the second inference workload

=== "UI"

    1. Go to the Workload manager → Workloads
    2. Click **+NEW WORKLOAD** and select **Inference**

        Within the new inference form:
    3. Select the **cluster** where the previous inference workload was created
    4. Select the **project** where the previous inference workload was created
    5. Enter a **name** for the workload (if the name already exists in the project, you will be requested to submit a different name)
    6. Select the environment created in the previous step
    7. Select the compute resource created in the previous step
    8.  Click **CREATE INFERENCE**

        After the inference workload is created, it is added to the [workloads](../../platform-admin/workloads/overviews/managing-workloads.md) table

=== "API"

    Copy the following command to your terminal. Make sure to update the below parameters according to the comments. For more details, see [Inferences API](https://api-docs.run.ai/latest/tag/Inferences#operation/create_inference1):

    ```sh
    curl -L 'https://<COMPANY-URL>/api/v1/workloads/inferences' \ #<COMPANY-URL> is the link to the Run:ai user interface.
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer <TOKEN>' \ #<TOKEN> is the API access token obtained in Step 1. 
    -d '{ 
        "name": "workload-name", 
        "useGivenNameAsPrefix": true,
        "projectId": "<PROJECT-ID>", '\ #The ID of the Project the workspace is running on. You can get the Project ID via the Get Projects API. 
        "clusterId": "<CLUSTER-UUID>", \ #<CLUSTER-UUID> is the unique identifier of the Cluster. You can get the Cluster UUID by adding the "Cluster ID" column to the Clusters view. 
        "spec": {
            "image": "runai.jfrog.io/core-llm/runai-vllm:v0.6.4-0.10.0",
            "imagePullPolicy":"IfNotPresent",
            "environmentVariables": [
            {
              "name": "RUNAI_MODEL",
              "value": "meta-lama/Llama-3.2-1B-Instruct"
            },
            {
              "name": "VLLM_RPC_TIMEOUT",
              "value": "60000"
            },
            {
              "name": "HF_TOKEN",
              "value":"<INSERT HUGGINGFACE TOKEN>"
            }
            ],
            "compute": {
                "gpuDevicesRequest": 1,
                "gpuRequestType": "portion",
                "gpuPortionRequest": 0.1,
                "gpuPortionLimit": 1,
                "cpuCoreRequest":0.2,
                "cpuMemoryRequest": "200M",
                "largeShmRequest": false

            },
            "servingPort": {
                "container": 8000,
                "protocol": "http",
                "authorizationType": "public"
        }
    }'       
    ```


    !!! Note
        The above API snippet runs with Run:ai clusters of 2.18 and above only. 


## Step 4: Submitting the first workspace

=== "UI"

    1. Go to the Workload manager → Workloads
    2. Click COLUMNS and select **Connections**
    3. Select the link under the Connections column for the first inference workload created in[ Step 2](launching-workloads-with-gpu-memory-swap.md#step-2-submitting-the-first-inference-workload)
    4. In the **Connections Associated with Workload form,** copy the URL under the **Address** column
    5.  Click **+NEW WORKLOAD** and select **Workspace**

        Within the new workspace form:
    6. Select the **cluster** where the previous inference workloads were created
    7. Select the **project** where the previous inference workloads were created
    8. Enter a **name** for the workspace (if the name already exists in the project, you will be requested to submit a different name)
    9. Select the **‘chatbot-ui’** environment for your workspace (Image URL: runai.jfrog.io/core-llm/llm-app)

        * Set the runtime settings for the environment with the following **environment variables**:
            * **Name:** RUNAI\_MODEL\_NAME **Source:** Custom **Value:** `meta-llama/Llama-3.2-1B-Instruct`
            * **Name:** RUNAI\_MODEL\_BASE\_URL **Source:** Custom **Value:** Add the address link from Step 4
            * Delete the **PATH\_PREFIX** environment variable if you are using host-based routing.

        * If the ‘chatbot-ui’ is not displayed in the gallery, follow the step-by-step guide:

        ??? "Create a chatbot-ui environment"

            1. Click **+NEW ENVIRONMENT**
            2. Enter a **name** for the environment. The name must be unique.
            3. Enter the chatbot-ui **Image URL** - `runai.jfrog.io/core-llm/llm-app`
            4. Tools - Set the connection for your tool
                * Click **+TOOL**
                * Select **Chatbot UI** tool from the list
            5. Set the runtime settings for the environment
                * Click **+ENVIRONMENT VARIABLE**
                * **Name:** RUNAI\_MODEL\_NAME **Source:** Custom **Value:** `meta-llama/Llama-3.2-1B-Instruct`
                * **Name:** RUNAI\_MODEL\_BASE\_URL **Source:** Custom **Value:** Add the address link from Step 4
                * **Name:** RUNAI\_MODEL\_TOKEN\_LIMIT **Source:** Custom **Value:** 8192
                * **Name:** RUNAI\_MODEL\_MAX\_LENGTH **Source:** Custom **Value:** 16384
            6. Click **CREATE ENVIRONMENT**
      
        * The newly created chatbot-ui will be selected automatically

    10. Select the **‘cpu-only’** compute resource for your workspace

        * If ‘cpu-only’ is not displayed in the gallery, follow the step-by-step guide:

        ??? "Create a cpu-only compute resource"

            1. Click **+NEW COMPUTE RESOURCE**
            2. Enter a **name** for the compute resource. The name must be unique.
            3. Set **GPU devices per pod** - 0
            4. Set **CPU compute per pod** - 0.1 cores
            5. Set the **CPU memory per pod** - 100 MB (default)
            6. Click **CREATE COMPUTE RESOURCE**
        * The newly created cpu-only compute resource will be selected automatically

    11. Click **CREATE WORKSPACE**

        After the workspace is created, it is added to the [workloads ](../../platform-admin/workloads/overviews/managing-workloads.md) table

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
            "image": "runai.jfrog.io/core-llm/llm-app",
            "environmentVariables": [
            {
              "name": "RUNAI_MODEL_NAME",
              "value": "meta-llama/Llama-3.2-1B-Instruct"
            },
            {
              "name": "RUNAI_MODEL_BASE_URL",
              "value": "<URL>" #The URL for connecting an external service related to the workload. You can get the URL via the List workloads API.
            }
            ],
            "compute": {
                "cpuCoreRequest":0.1,
                "cpuMemoryRequest": "100M",
        }
    }'
    ```

    !!! Note
        The above API snippet runs with Run:ai clusters of 2.18 and above only.
  

## Step 5: Submitting the second workspace

=== "UI"

    1. Go to the Workload manager → Workloads
    2. Click COLUMNS and select **Connections**
    3. Select the link under the Connections column for the second inference workload created in [Step 3](launching-workloads-with-gpu-memory-swap.md#step-3-submitting-the-second-inference-workload)
    4. In the **Connections Associated with Workload form,** copy the URL under the **Address** column
    5.  Click **+NEW WORKLOAD** and select **Workspace**

        Within the new workspace form:
    6. Select the **cluster** where the previous inference workloads were created
    7. Select the **project** where the previous inference workloads were created
    8. Enter a **name** for the workspace (if the name already exists in the project, you will be requested to submit a different name)
    9. Select the **‘chatbot-ui’** environment
        * Set the runtime settings for the environment with the following **environment variables**:
                
            * **Name:** RUNAI\_MODEL\_NAME **Source:** Custom **Value:** `meta-llama/Llama-3.2-1B-Instruct`
            * **Name:** RUNAI\_MODEL\_BASE\_URL **Source:** Custom **Value:** Add the address link from Step 4
            * Delete the **PATH\_PREFIX** environment variable if you are using host-based routing.

    10. Select the **‘cpu-only’** compute resource
    11. Click **CREATE WORKSPACE**

        After the workspace is created, it is added to the [workloads](../../platform-admin/workloads/overviews/managing-workloads.md) table

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
            "image": "runai.jfrog.io/core-llm/llm-app",
            "environmentVariables": [
            {
              "name": "RUNAI_MODEL_NAME",
              "value": "meta-llama/Llama-3.2-1B-Instruct"
            },
            {
              "name": "RUNAI_MODEL_BASE_URL",
              "value": "<URL>" #The URL for connecting an external service related to the workload. You can get the URL via the List workloads API.
            }
            ],
            "compute": {
                "cpuCoreRequest":0.1,
                "cpuMemoryRequest": "100M",
        }
    }'
    ```

    !!! Note
        The above API snippet runs with Run:ai clusters of 2.18 and above only. 


## Step 6: Connecting to Chatbot-UI

=== "UI"

    1. Select the newly created workspace that you want to connect to
    2. Click **CONNECT**
    3. Select the ChatbotUI tool
    4. The selected tool is opened in a new tab on your browser
    5. Query both workspaces simultaneously and see them both responding. The one on CPU RAM at the time will take longer as it switches back to the GPU and vice versa.

=== "API"

    1. To connect to the ChatbotUI tool, browse directly to `https://<COMPANY-URL>/<PROJECT-NAME>/<WORKLOAD_NAME>` 
    2. Query both workspaces simultaneously and see them both responding. The one on CPU RAM at the time will take longer as it switches back to the GPU and vice versa.

## Next Steps

Manage and monitor your newly created workspace using the [workloads](../../platform-admin/workloads/overviews/managing-workloads.md) table.