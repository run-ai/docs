

## What are Metrics

[Metrics](https://prometheus.io/docs/introduction/overview/#what-are-metrics){target=_blank} are numeric measurements recorded __over time__ that are emitted from the Run:AI cluster. Typical metrics involve utilization, allocation, time measurements and the like. Metrics are used in Run:AI dashboards as well as in the Run:AI administration user interface. 

The purpose of this document is to detail the structure and purpose of metrics emitted by Run:AI so as to enable customers to create their own dashboards or integrate metric data into other monitoring systems. 

Run:AI uses [Prometheus](target=_blank) for collecting and querying metrics.


##  Published Run:AI Metrics

 <!-- https://tabletomarkdown,com/convert-spreadsheet-to-markdown/ -->


| Metric name                                           | Labels                                                                                             | Description                                                                                                                                                                                      |
| ----------------------------------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| runai_cluster_allocated_gpus                       |  {job_type, job_uuid, job_name, clusterId, project}                   | Jobs allocated GPUs                                                                                                                                                                             |
| runai_cluster_cpu_utilization                      |  {clusterId}                                                                     | CPU utilization of the entire cluster (0-1)                                                                                                                                                      |
| runai_cluster_memory_used_bytes                   |  {clusterId}                                                                     | Used CPU Memory of the entire cluster (Bytes)                                                                                                                                                    |
| runai_cluster_memory_utilization                   |  {clusterId}                                                                     | CPU Memory utilization of the entire cluster (0-1)                                                                                                                                               |
| runai_gpu_is_allocated                             |  {gpu, clusterId, node}                                                      | Is a GPU hosting a pod (0/1)                                                                                                                                                                     |
| runai_gpu_is_running_fractional_job              |  {gpu, clusterId, node}                                                      | Is GPU hosting Fractional GPU jobs? (0/1)                                                                                                                                                        |
| runai_gpu_last_active_time                        |  {gpu, clusterId, node}                                                      | Last time GPU was not idle                                                                                                                                                                           |
| runai_gpu_total_memory_bytes                      |  {clusterId, node}                                                             | Total GPU memory per node (Bytes)                                                                                                                                                                |
| runai_gpu_used_memory_bytes                       |  {clusterId, node}                                                             | Used CPU memory per node (Bytes)                                                                                                                                                                 |
| runai_gpu_utilization_non_fractional_jobs        |  {job_uuid, job_name, clusterId, gpu, node}                            | GPU utilization of jobs running on a full GPU (0-100)                                                                                                                                            |
| runai_job_gpu_utilization                          |  {job_uuid, clusterId, job_name, project}                                | GPU utilization per job (0-100)                                                                                                                                                                  |
| runai_job_image                                     |  {image, job_uuid, job_name, clusterId}                                  | Image name per job                                                                                                                                                                               |
| runai_job_requested_gpu_memory                    |  {job_type, job_uuid, job_name, clusterId, project}                   | Requested GPU memory per job (Bytes, 0 if not specified by the user)                                                                                                                             |
| runai_job_requested_gpus                           |  {job_type, job_uuid, job_name, clusterId, project}                   | Number of requested GPU per job                                                                                                                                                                  |
| runai_job_status_with_info                        |  {user, job_type, status, job_name, clusterId, node, project}      | Information on jobs including user name, job type, runai status (phase), K8s status (detailed_status), project name (queue_name), and node name, Current jobs status (phase) receives Value=1 |
| runai_job_total_runtime                            |  {clusterId, job_uuid}                                                        | Total run time per job (sec)                                                                                                                                                                     |
| runai_job_total_wait_time                         |  {clusterId, job_uuid}                                                        | Total wait time per job (sec)                                                                                                                                                                    |
| runai_job_used_gpu_memory_bytes                  |  {clusterId, job_uuid}                                                        | Used GPU memory per job (Bytes)                                                                                                                                                                  |
| runai_job_used_gpu_memory_bytes_with_gpu_node |  {job_uuid, job_name, clusterId, gpu, node}                            | Used GPU memory per job and GPU on which the job is running (Bytes)                                                                                                                              |
| runai_node_cpu_requested_cores                    |  {clusterId, node}                                                             | Sum of the requested CPU of all jobs running in a node (# of cores)                                                                                                                              |
| runai_node_cpu_utilization                         |  {clusterId, node}                                                             | CPU utilization per node (0-1)                                                                                                                                                                   |
| runai_node_gpu_used_memory_bytes                 |  {clusterId, node}                                                             | Used GPU memory per node (Bytes)                                                                                                                                                                 |
| runai_node_gpu_utilization                         |  {pod_namespace, pod_name, clusterId, gpu, node}                       | GPU utilization per GPU (0-100)                                                                                                                                                                  |
| runai_node_memory_utilization                      |  {clusterId, node}                                                             | CPU memory utilization per node (0-1)                                                                                                                                                            |
| runai_node_requested_memory_bytes                 |  {clusterId, node}                                                             | Sum of the requested CPU Memory of all jobs running in a node (# of cores)                                                                                                                       |
| runai_project_guaranteed_gpus                      |  {clusterId, project}                                                          | Guaranteed GPU quota per project                                                                                                                                             |
| runai_project_info                                  |  {memory_quota, cpu_quota, gpu_guaranteed_quota, clusterId, project} | Information on CPU, CPU Memory, GPU quota per project                                                                                                                       |
| runai_running_job_cpu_limit_cores,               | zzzz                                                                                               | xx                                                                                                                                                                                               |
| runai_running_job_cpu_requested_cores            |  {clusterId, job_name, job_uuid}                                           | Jobs requested CPU (# of cores) - can add a comment to K8s docs on requested vs, limit                                                                                                          |
| runai_running_job_cpu_used_cores                 |  {job_uuid, clusterId, job_name, project}                                | Jobs CPU utilization (# of cores)                                                                                                                                                               |
| runai_running_job_memory_limit_bytes             |  {clusterId, job_name, job_uuid}                                           | Jobs CPU Memory limit (Bytes) - can add a comment to K8s docs on requested vs, limit                                                                                                            |
| runai_running_job_memory_requested_bytes         |  {clusterId, job_name, job_uuid}                                           | Jobs requested CPU Memory (Bytes) - can add a comment to K8s docs on requested vs, limit                                                                                                        |
| runai_running_job_memory_used_bytes              |  {job_uuid, clusterId, job_name, project}                                | Jobs used CPU Memory (Bytes)                                                                                                                                                                    |
| dcgm_gpu_last_not_idle_time     | xxx | last time GPU was not idle           |



## Other Metrics

Run:AI exports other metrics emitted by NVIDIA and Kubernetes packages, as follows:

| Metric name                      | Description                          |
| -------------------------------- | ------------------------------------ |
| DCGM_GPU_MODEL                   | GPU model. example: Tesla V100-SXM2-32GB |
| dcgm_gpu_utilization             | GPU utilization                      |
| kube_node_status_allocatable                      | The allocatable for different resources of a node that are available for scheduling |
| kube_node_status_capacity                         | The capacity for different resources of a node                                      |
| kube_node_status_condition                        | The condition of a cluster node                                                     |
| kube_pod_container_resource_requests              | The number of requested request resource by a container                             |
| kube_pod_container_resource_requests_cpu_cores    | The number of CPU cores requested by container                                      |
| kube_pod_container_resource_requests_memory_bytes | Bytes of memory requested by a container                                            |
| kube_pod_info                                     | Information about pod                                                               |
| kube_pod_status_phase                             | The current phase of the pod                                                 |


For additional information, see Kubernetes [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics){target=_blank} and NVIDIA [dcgm exporter](https://github.com/NVIDIA/gpu-monitoring-tools){target=_blank}.

## Querying Metrics

XXXX