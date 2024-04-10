---
title: Metrics
summary: This article shows the available metrics supported by Run:ai.
authors:
    - Jason Novich    
date: 2024-Apr-9
---

## What are Metrics

[Metrics](https://prometheus.io/docs/introduction/overview/#what-are-metrics){target=_blank} are numeric measurements recorded __over time__ that are emitted from the Run:ai cluster. Typical metrics involve utilization, allocation, time measurements and so on. Metrics are used in Run:ai dashboards as well as in the Run:ai administration user interface.

The purpose of this document is to detail the structure and purpose of metrics emitted by Run:ai to enable customers to create custom dashboards or integrate metric data into other monitoring systems.

Run:ai uses [Prometheus](https://prometheus.io){target=_blank} for collecting and querying metrics.

!!! Note
    From cluster version 2.17 onwards, Run:ai will support metrics via the Run:ai API and direct metrics queries (metrics that are queried directly from Prometheus) will be deprecated.

## Published Run:ai Metrics

Following is the list of published Run:ai metrics, per cluster version (make sure to pick the right cluster version in the picker at the top of the page):

| Metric name | Labels | Measurement | Description |
|--|--|--|--|
| runai_active_job_cpu_requested_cores | {clusterId,  job_name, job_uuid} | CPU Cores | Workload's requested CPU cores |
| runai_active_job_memory_requested_bytes | {clusterId,  job_name, job_uuid} | Bytes | Workload's requested CPU memory |
| runai_cluster_cpu_utilization | {clusterId} | 0 to 1 | CPU utilization of the entire cluster |
| runai_cluster_memory_used_bytes | {clusterId} | Bytes | Used CPU memory of the entire cluster |
| runai_cluster_memory_utilization | {clusterId} | 0 to 1 | CPU memory utilization of the entire cluster |
| runai_allocated_gpu_count_per_gpu | {gpu, clusterId, node} | 0/1 | Is a GPU hosting a pod |
| runai_last_gpu_utilization_time_per_gpu | {gpu, clusterId, node} | Unix time | Last time GPU was not idle |
| runai_requested_gpu_memory_mb_per_workload | {clusterId, job_type, job_uuid, job_name, project, workload_id} | MegaBytes | Requested GPU memory per workload (0 if not specified by the user) |
| runai_requested_gpus_per_workload | {clusterId, workload_type, workload_id, workload_name, project} | Double | Number of requested GPUs per workload |
| runai_run_time_seconds_per_workload | {clusterId, workload_id, workload_name} | Seconds | Total run time per workload |
| runai_wait_time_seconds_per_workload | {clusterId, workload_id, workload_name} | Seconds | Total wait time per workload |
| runai_node_cpu_requested_cores | {clusterId, node} | Double | Sum of the requested CPU cores of all workloads running in a node |
| runai_node_cpu_utilization | {clusterId, node} | 0 to 1 | CPU utilization per node |
| runai_node_memory_utilization | {clusterId, node} | 0 to 1 | CPU memory utilization per node |
| runai_node_requested_memory_bytes | {clusterId, node} | Bytes | Sum of the requested CPU memory of all workloads running in a node |
| runai_node_used_memory_bytes | {clusterId, node} | Bytes | Used CPU memory per node |
| runai_project_guaranteed_gpus | {clusterId, project} | Double | Guaranteed GPU quota per project |
| runai_project_info | {memory_quota, cpu_quota, gpu_guaranteed_quota, clusterId, project, department} | N/A | Information on CPU, CPU memory, GPU quota per project |
| runai_queue_info | {memory_quota, cpu_quota, gpu_guaranteed_quota, clusterId, nodepool, queue_name, department} | N/A | Information on CPU, CPU memory, GPU quota per project/department per nodepool |
| runai_cpu_limits_per_active_workload | {clusterId, job_name , job_uuid} | CPU Cores | Workloads CPU limit (in number of cores). See [link](https://docs.run.ai/latest/Researcher/scheduling/allocation-of-cpu-and-memory) |
| runai_job_cpu_usage | {clusterId, workload_id, workload_name, project} | Double | Workloads CPU usage (in number of cores) |
| runai_memory_limits_per_active_workload | {clusterId, job_name, job_uuid} | Bytes | Workloads CPU memory limit. See [link](https://docs.run.ai/latest/Researcher/scheduling/allocation-of-cpu-and-memory) |
| runai_active_job_memory_requested_bytes | {clusterId, job_name, job_uuid} | Bytes | Workloads requested CPU memory. See [link](https://docs.run.ai/latest/Researcher/scheduling/allocation-of-cpu-and-memory) |
| runai_job_memory_used_bytes | {clusterId, workload_id, workload_name, project} | Bytes | Workloads used CPU memory |
| runai_mig_mode_gpu_count | {clusterId, node} | Double | Number of GPUs on MIG nodes |
| runai_gpu_utilization_per_gpu | {clusterId, gpu, node} | % | GPU Utilization per GPU |
| runai_gpu_utilization_per_node | {clusterId, node} | % | GPU Utilization per Node |
| runai_gpu_memory_used_mebibytes_per_gpu | {clusterId, gpu, node} | MiB | Used GPU memory per GPU |
| runai_gpu_memory_used_mebibytes_per_node | {clusterId, node} | MiB | Used GPU memory per Node |
| runai_gpu_memory_total_mebibytes_per_gpu | {clusterId, gpu, node} | MiB | Total GPU memory per GPU |
| runai_gpu_memory_total_mebibytes_per_node | {clusterId, node} | MiB | Total GPU memory per Node |
| runai_gpu_count_per_node | {clusterId, node, modelName, ready, schedulable} | Number | Number of GPUs per Node |
| runai_allocated_gpu_count_per_workload | {clusterId, workload_id, workload_name, workload_type, user} | Double | Number of allocated GPUs per Workload |
| runai_allocated_gpu_count_per_project | {clusterId, project} | Double | Number of allocated GPUs per Project |
| runai_gpu_memory_used_mebibytes_per_pod_per_gpu | {clusterId, pod_name, pod_uuid, pod_namespace, node, gpu} | MiB | Used GPU Memory per Pod, per Gpu on which the workload is running |
| runai_gpu_memory_used_mebibytes_per_workload | {clusterId, workload_id, workload_name, workload_type, user} | MiB | Used GPU Memory per Workload |
| runai_gpu_utilization_per_pod_per_gpu | {clusterId, pod_name, pod_uuid, pod_namespace, node, gpu} | % | GPU Utilization per Pod per GPU |
| runai_gpu_utilization_per_workload | {clusterId, workload_id, workload_name, workload_type, user} | % | Average GPU Utilization per Workload |
| runai_gpu_utilization_per_project | {clusterId, project} | % | Average GPU Utilization per Project |
| runai_last_gpu_utilization_time_per_workload | {clusterId, workload_id, workload_name, workload_type, user} | Seconds (Unix Timestamp) | The Last Time (Unix Timestamp) That The Workload Utilized Any Of Its Allocated GPUs |
| runai_gpu_idle_seconds_per_workload | {clusterId, workload_id, workload_name, workload_type, user} | Seconds | Seconds Passed Since The Workload Utilized Any Of Its Allocated GPUs |
| runai_allocated_gpu_count_per_pod | {clusterId, pod_name, pod_uuid, pod_namespace, node} | Double | Number Of Allocated GPUs per Pod |
| runai_allocated_gpu_count_per_node | {clusterId, node} | Double | Number Of Allocated GPUs per Node |
| runai_allocated_millicpus_per_pod | {clusterId, pod_name, pod_uuid, pod_namespace, node} | Integer | Number Of Allocated Millicpus per Pod |
| runai_allocated_memory_per_pod | {clusterId, pod_name, pod_uuid, pod_namespace, node} | Bytes | Allocated Memory per Pod |    |

Following is a list of labels appearing in Run:ai metrics:

| Label                  | Description   |
|------------------------| -------------------------------------------------------------- |
| clusterId              | Cluster Identifier                 |
| department             | Name of Run:ai Department          |
| cpu_quota              | CPU limit per project              |
| gpu                    | GPU index                          |
| gpu_guaranteed_quota   | Guaranteed GPU quota per project   |
| image                  | Name of Docker image               |
| namespace_name         | Namespace                          |
| deployment_name        | Deployment name                    |
| job_name               | Job name                           |
| job_type               | Job type: training, interactive or inference               |
| job_uuid               | Job identifier                     |
| workload_name          | Workload name                      |
| workload_type          | Workload type: training, interactive or inference |
| workload_uuid          | Workload identifier                |
| pod_name               | Pod name. A Workload can contain many pods. |
| pod_namespace          | Pod namespace                      |
| memory_quota           | CPU memory limit per project       |
| node                   | Node name                          |
| project                | Name of Run:ai Project             |
| status                 | Workload status: Running, Pending, etc. For more information on Workload statuses see [document](https://docs.run.ai/latest/Researcher/scheduling/job-statuses/) |
| user                   | User identifier                    |

## Other Metrics

Run:ai exports other metrics emitted by NVIDIA and Kubernetes packages, as follows:

| Metric name                                       | Description                          |
| ------------------------------------------------- | ------------------------------------ |
| runai_gpu_utilization_per_gpu                              | GPU utilization                      |
| kube_node_status_capacity                         | The capacity for different resources of a node                              |
| kube_node_status_condition                        | The condition of a cluster node                                             |
| kube_pod_container_resource_requests_cpu_cores    | The number of CPU cores requested by container                              |
| kube_pod_container_resource_requests_memory_bytes | Bytes of memory requested by a container                                    |
| kube_pod_info                                     | Information about pod                                                       |

For additional information, see Kubernetes [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics){target=_blank} and NVIDIA [dcgm exporter](https://github.com/NVIDIA/gpu-monitoring-tools){target=_blank}.

## Changed metrics and API mapping

Starting in version 2.17, Run:ai metrics are available as API endpoints. Using the API endpoints is more efficient and provides an easier way of retrieving metrics in any application. The following table lists the metrics that were changed.

| 2.16 | Change Description | 2.17 API Endpoint |
| --- |  --- |  --- |
| runai\_active\_job\_cpu\_requested\_cores | changed to API | https://app.run.ai/api/v1/workloads/{workloadId}/metrics ; with "CPU\_REQUEST" metricType |
| runai\_active\_job\_memory\_requested\_bytes | changed to API | https://app.run.ai/api/v1/workloads/{workloadId}/metrics ; with "CPU\_MEMORY\_REQUEST" metricType |
| runai\_cluster\_cpu\_utilization | changed to API | https://app.run.ai/api/v2/clusters/{clusterUuid}/metrics ; with "CPU\_UTILIZATION" metricType |
| runai\_cluster\_memory\_utilization | changed to API | https://app.run.ai/api/v2/clusters/{clusterUuid}/metrics ; with "CPU\_MEMORY\_UTILIZATION" metricType |
| runai\_gpu\_utilization\_non\_fractional\_jobs | no longer available |  |
| runai\_allocated\_gpu\_count\_per\_workload | labels changed |  |
| runai\_gpu\_utilization\_per\_pod\_per\_gpu | changed to API | https://app.run.ai/api/v1/workloads/{workloadId}/pods/{podId}/metrics ; with "GPU\_UTILIZATION\_PER\_GPU" metricType |
| runai\_gpu\_utilization\_per\_workload | changed to API + labels changed | https://app.run.ai/api/v1/workloads/{workloadId}/metrics ; with "GPU\_UTILIZATION" metricType |
| runai\_job\_image | no longer available |  |
| runai\_job\_requested\_gpu\_memory | changed to API + renamed to: "runai\_requested\_gpu\_memory\_mb\_per\_workload" with different labels | https://app.run.ai/api/v1/workloads/{workloadId}/metrics ; with "GPU\_MEMORY\_REQUEST" metricType |
| runai\_job\_requested\_gpus | renamed to: "runai\_requested\_gpus\_per\_workload" with different labels |  |
| runai\_job\_total\_runtime | renamed to: "runai\_run\_time\_seconds\_per\_workload" with different labels |  |
| runai\_job\_total\_wait\_time | renamed to: "runai\_wait\_time\_seconds\_per\_workload" with different labels |  |
| runai\_gpu\_memory\_used\_mebibytes\_per\_workload | changed to API + labels changed | https://app.run.ai/api/v1/workloads/{workloadId}/metrics ; with "GPU\_MEMORY\_USAGE" metricType |
| runai\_gpu\_memory\_used\_mebibytes\_per\_pod\_per\_gpu | changed to API + labels changed | https://app.run.ai/api/v1/workloads/{workloadId}/pods/{podId}/metrics ; with "GPU\_MEMORY\_USAGE\_PER\_GPU" metricType |
| runai\_node\_gpu\_used\_memory\_bytes | renamed and changed units: "runai\_gpu\_memory\_used\_mebibytes\_per\_node" |  |
| runai\_node\_total\_memory\_bytes | renamed and changed units: "runai\_gpu\_memory\_total\_mebibytes\_per\_node" |  |
| runai\_project\_info | labels changed |  |
| runai\_active\_job\_cpu\_limits | changed to API + renamed to: "runai\_cpu\_limits\_per\_active\_workload" | https://app.run.ai/api/v1/workloads/{workloadId}/metrics ; with "CPU\_LIMIT" metricType |
| runai\_job\_cpu\_usage | changed to API + labels changed | https://app.run.ai/api/v1/workloads/{workloadId}/metrics ; with "CPU\_USAGE" metricType |
| runai\_active\_job\_memory\_limits | changed to API + renamed to: "runai\_memory\_limits\_per\_active\_workload" | https://app.run.ai/api/v1/workloads/{workloadId}/metrics ; with "CPU\_MEMORY\_LIMIT" metricType |
| runai\_running\_job\_memory\_requested\_bytes | was a duplication of "runai\_active\_job\_memory\_requested\_bytes", see above |  |
| runai\_job\_memory\_used\_bytes | changed to API + labels changed | https://app.run.ai/api/v1/workloads/{workloadId}/metrics ; with "CPU\_MEMORY\_USAGE" metricType |
| runai\_job\_swap\_memory\_used\_bytes | no longer available |  |
| runai\_gpu\_count\_per\_node | added labels |  |
| runai\_last\_gpu\_utilization\_time\_per\_workload | labels changed |  |
| runai\_gpu\_idle\_time\_per\_workload | renamed to: "runai\_gpu\_idle\_seconds\_per\_workload" with different labels |  |

## Create custom dashboards

To create custom dashboards based on the above metrics, please contact Run:ai customer support.
