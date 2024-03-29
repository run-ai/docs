---
title: Workloads Overview
summary: This article is an overview of the Workloads feature.
authors:
    - Jason Novich
date: 2023-Dec-26
---

Run:ai *Workloads* is specifically designed and optimized for AI and data science workloads, enhancing Kubernetes management of containerized applications. Run:ai augments Kubernetes workloads with additional resources crucial for AI pipelines (for example, Compute resources, networking, and storage).

Runai is an open platform and supports three types of workloads each with a different set of features:

* Run:ai native workloads.
* Third party integrations.
* Typical Kubernetes workloads.

### Run:ai native workloads

Run:ai native workloads are workloads (trainings, workspaces, deployments) that are fully controlled by Run:ai. Run: workloads are the most comprehensive and include *Third party integrations* and *Typical Kubernetes* workload types. Specific characteristics of Run: ai native workloads include:

1. Submitting of workloads via UI/CLI.
2. Workload control (delete/stop/connect).
3. Workload policies (default rules for all policies, specific workload policies, and enforcing of those rules).
4. Scheduling rules.
5. Role based access control.

### Third party integrations

Third party integrations are tools that Run:ai supports and manages. These are tools that are typically used to build workloads for specific purposes. Third party integrations also include *Typical Kubernetes* workloads. Specific characteristics of third party tool support include:

1. Smart gang scheduling (workload aware).
2. Specific workload aware visibility so that different kinds of pods are identified as a single workload (for example, GPU Utilization, workload view, dashboards).

For more information, see [Supported integrations](#supported-integrations).

### Typical Kubernetes workloads

Typical Kubernetes workloads are any kind of workload built for Kubernetes. The Run:ai platform allows you to submit standard Kubernetes CRDs. Specific characteristics of *Typical Kubernetes* workloads that Run:ai can manage include:

1. Fairness
2. Nodepools
3. Bin packing/spread
4. Fractions
5. Overprovisioning

## Workloads View

Run:ai makes it easy to run machine learning workloads effectively on Kubernetes. Run:ai provides both a UI and API interface that introduces a simple and more efficient way to manage machine learning workloads, which will appeal to data scientists and engineers alike.

The Workloads table provides:

* Changing of the layout of the *Workloads* table by pressing *Columns* to add or remove columns from the table.
* Download the table to a CSV file by pressing *More*, then pressing *Download as CSV*.
* Search for a workload by pressing *Search* and entering the name of the workload.
* Advanced workload management.
* Added workload statuses for better tracking of workload flow.

To create new workloads, press [*New Workload*](submitting-workloads.md).

### API Documentation

Access the platform [API documentation](https://app.run.ai/api/docs){target=_blank} for more information on using the API to manage workloads.

## Managing Workloads

You can manage a workload by selecting one from the view. Once selected, you can:

* Delete a workload
* Connect
* Stop a workload
* Activate a workload
* Show details&mdash;provides in-depth information about the selected workload including:

      * Event history&mdash;workload status over time. Use the filter to search through the history for specific events.
      * Metrics&mdash;use the drop down to filter metrics per pod. Select a category from the list below:

          * GPU compute utilization
          * GPU memory usage
          * CPU usage
          * CPU memory usage
  
      * Logs&mdash;logs of the selected workload. Use the drop down to filter metrics per pod. Use the Download button to download the logs.

### Workloads Status

The *Status* column shows the current status of the workload. The following table describes the statuses presented:

| **Phase Name** | **Description** | **Entry Condition** | **Exit Condition** |
| --- | --- | --- | --- |
| **Creating** |Workload setup is initiated in the cluster. Resources and pods are now provisioning. | A workload is submitted. | A multi-pod group is created.|
| **Pending** | Workload is queued and awaiting resource allocation. | A pod group exists. | All pods are scheduled. |
| **Initializing** | Workload is retrieving images, starting containers, and preparing pods. | All pods are scheduled—handling of multi-pod groups TBD. | All pods are initialized or a failure to initialize is detected. |
| **Running** | Workload is currently in progress with all pods operational. | All pods initialized (all containers in pods are ready). | Job completion or failure. |
| **Degraded** | Pods may not align with specifications, network services might be incomplete, or persistent volumes may be detached. Check your logs for specific details. | **Pending**&mdash;All pods are running but with issues. </br> **Running**&mdash;All pods are running with no issues. | **Running**&mdash;All resources are OK.</br> **Completed**&mdash; Job finished with fewer resources.</br>**Failed**&mdash;Job failure or user-defined rules. |
| **Deleting** | Workload and its associated resources are being decommissioned from the cluster. | Deleting of the workload. | Resources are fully deleted. |
| **Stopped** | Workload is on hold and resources are intact but inactive. | Stopping the workload without deleting resources. | Transitioning back to the initializing phase or proceeded to deleting the workload. |
| **Failed** | Image retrieval failed or containers experienced a crash. Check your logs for specific details. | An error occurs preventing the successful completion of the job. | Terminal state. |
| **Completed** | Workload has successfully finished its execution. | The job has finished processing without errors. | Terminal state. |

### Successful flow

A successful flow will follow the following flow chart:

```mermaid
flowchart LR
 A(Creating) --> B(Pending)
 B-->C(Initializing)
 C-->D(Running)
 D-->E(Completed)
```

To get the full experience of Run:ai’s environment and platform use the following types of workloads.

* [Workspaces](../../Researcher/user-interface/workspaces/overview.md#getting-familiar-with-workspaces)
* [Trainings](../../Researcher/user-interface/trainings.md#trainings) (Only available when using the *Jobs* view)
* [Distributed trainings](../../Researcher/user-interface/trainings.md#trainings)
* [Deployment](../admin-ui-setup/deployments.md#viewing-and-submitting-deployments)

## Supported integrations

To assist you with other platforms, and other types of workloads use the integrations listed below.

1. [Airflow](https://runai.my.site.com/community/s/article/How-to-integrate-Run-ai-with-Apache-Airflow){target=_blank}
2. [MLflow](https://runai.my.site.com/community/s/article/How-to-integrate-Run-ai-with-MLflow){target=_blank}
3. [Kubeflow](https://runai.my.site.com/community/s/article/How-to-integrate-Run-ai-with-Kubeflow){target=_blank}
4. [Seldon Core](https://runai.my.site.com/community/s/article/How-to-integrate-Run-ai-with-Seldon-Core){target=_blank}
5. [Spark](https://runai.my.site.com/community/s/article/How-to-Run-Spark-jobs-with-Run-AI){target=_blank}
6. [Ray](https://runai.my.site.com/community/s/article/How-to-Integrate-Run-ai-with-Ray){target=_blank}
7. [KubeVirt (VM)](https://runai.my.site.com/community/s/article/{target=_blank}How-to-integrate-with-Kubevirt-Scheduling-Virtual-Machines-using-Run-ai)
