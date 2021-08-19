

## What are Metrics

[Metrics](https://prometheus.io/docs/introduction/overview/#what-are-metrics){target=_blank} are numeric measurements recorded __over time__ that are emitted from the Run:AI cluster. Typical metrics involve utilization, allocation, time measurements and the like. Metrics are used in Run:AI dashboards as well as in the Run:AI administration user interface. 

The purpose of this document is to detail the structure and purpose of metrics emitted by Run:AI so as to enable customers to create their own dashboards or integrate metric data into other monitoring systems. 

Run:AI uses [Prometheus](target=_blank) for collecting and querying metrics.


##  Published Run:AI Metrics


Following is the list of published Run:AI Metrics

| Metric name                                    | Labels                                                                | Measurement | Description                                                                                                                                                                                      |
| ---------------------------------------------- | --------------------------------------------------------------------- |------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| runai_cluster_allocated_gpus                   |  {job_type, job_uuid, job_name, clusterId, project}                   | # of GPUS   | GPUs allocated to Jobs                                                                                                                                                                              |
| runai_cluster_cpu_utilization                  |  {clusterId}                                                          |    0 to 1   | CPU utilization of the entire cluster                                                                                                                                                      |
| runai_cluster_memory_used_bytes                |  {clusterId}                                                          | Bytes       | Used CPU Memory of the entire cluster                                                                                                                                                     |
| runai_cluster_memory_utilization               |  {clusterId}                                                          |    0 to 1   | CPU Memory utilization of the entire cluster                                                                                                                                               |
| runai_gpu_is_allocated                         |  {gpu, clusterId, node}                                               |    0/1      | Is a GPU hosting a pod                                                                                                                                                                    |
| runai_gpu_is_running_fractional_job            |  {gpu, clusterId, node}                                               |    0/1      | Is GPU hosting Fractional GPU jobs?                                                                                                                                                       |
| runai_gpu_last_active_time                     |  {gpu, clusterId, node}                                               | Unix time   | Last time GPU was not idle                                                                                                                                                                       |
| runai_gpu_total_memory_bytes                   |  {clusterId, node}                                                    | Bytes       | Total GPU memory per node                                                                                                                                                               |
| runai_gpu_used_memory_bytes                    |  {clusterId, node}                                                    | Bytes       | Used CPU memory per node                                                                                                                                                                |
| runai_gpu_utilization_non_<br>fractional_jobs  |  {job_uuid, job_name, clusterId, gpu, node}                           | 0 to 100    | GPU utilization of jobs running on a full GPU                                                                                                                                            |
| runai_job_gpu_utilization                      |  {job_uuid, clusterId, job_name, project}                             | 0 to 100    | GPU utilization per job                                                                                                                                                                  |
| runai_job_image                                |  {image, job_uuid, job_name, clusterId}                               | N/A         | Image name per job                                                                                                                                                                               |
| runai_job_requested_gpu_memory                 |  {job_type, job_uuid, job_name, clusterId, project}                   | Bytes       | Requested GPU memory per job (0 if not specified by the user)                                                                                                                             |
| runai_job_requested_gpus                       |  {job_type, job_uuid, job_name, clusterId, project}                   | #           | Number of requested GPU per job                                                                                                                                                                  |
| runai_job_status_with_info                     |  {user, job_type, status, job_name, clusterId, node, project}         | N/A         | Information on jobs including user name, job type, runai status (phase), K8s status (detailed_status), project name (queue_name), and node name, Current jobs status (phase) receives Value=1 |
| runai_job_total_runtime                        |  {clusterId, job_uuid}                                                | Seconds     | Total run time per job                                                                                                                                                                    |
| runai_job_total_wait_time                      |  {clusterId, job_uuid}                                                | Seconds     |  Total wait time per job                                                                                                                                                                 |
| runai_job_used_gpu_memory_bytes                |  {clusterId, job_uuid}                                                | Bytes       | Used GPU memory per job                                                                                                                                                              |
| runai_job_used_gpu_memory_bytes_<br>with_gpu_node  |  {job_uuid, job_name, clusterId, gpu, node}                       | Bytes       | Used GPU memory per job and GPU on which the job is running                                                                                                                             |
| runai_node_cpu_requested_cores                 |  {clusterId, node}                                                    | # of cores  | Sum of the requested CPU of all jobs running in a node                                                                                                                              |
| runai_node_cpu_utilization                     |  {clusterId, node}                                                    | 0 to 1      | CPU utilization per node                                                                                                                                                                 |
| runai_node_gpu_used_memory_bytes               |  {clusterId, node}                                                    | Bytes       | Used GPU memory per node                                                                                                                                                                  |
| runai_node_gpu_utilization                     |  {pod_namespace, pod_name, clusterId, gpu, node}                      | 0 to 100    | GPU utilization per GPU                                                                                                                                                                   |
| runai_node_memory_utilization                  |  {clusterId, node}                                                    | 0 to 1      | CPU memory utilization per node (0-1)                                                                                                                                                            |
| runai_node_requested_memory_bytes              |  {clusterId, node}                                                    | # of cores  | Sum of the requested CPU Memory of all jobs running in a node                                                                                                                      |
| runai_project_guaranteed_gpus                  |  {clusterId, project}                                                 | # of GPUs   | Guaranteed GPU quota per project                                                                                                                                             |
| runai_project_info                             |  {memory_quota, cpu_quota, gpu_guaranteed_quota, clusterId, project}  | N/A         | Information on CPU, CPU Memory, GPU quota per project                                                                                                                       |
| runai_running_job_cpu_limit_cores,             |  __zzzz__                                                             | __xx__      |                                                                                                                                                                                      |
| runai_running_job_cpu_requested_cores          |  {clusterId, job_name, job_uuid}                                      | # of cores  | Jobs requested CPU  -  __XXX can add a comment to K8s docs on requested vs, limit__                                                                                                          |
| runai_running_job_cpu_used_cores               |  {job_uuid, clusterId, job_name, project}                             | # of cores  | Jobs CPU utilization                                                                                                                                                                |
| runai_running_job_memory_limit_bytes           |  {clusterId, job_name, job_uuid}                                      | Bytes       | Jobs CPU Memory limit  - __XXX can add a comment to K8s docs on requested vs, limit__                                                                                                            |
| runai_running_job_memory_requested_bytes       |  {clusterId, job_name, job_uuid}                                      | Bytes       | Jobs requested CPU Memory  - __XXX can add a comment to K8s docs on requested vs, limit__                                                                                                        |
| runai_running_job_memory_used_bytes            |  {job_uuid, clusterId, job_name, project}                             | Bytes       | Jobs used CPU Memory                                                                                                                                                                     |
| dcgm_gpu_last_not_idle_time                    |  {device, exported_pod, UUID, pod, namespace, job, Hostname, pod_name, clusterId, service, gpu, modelName, instance, container_name, exported_namespace, pod_namespace, exported_container, endpoint, container} | __xxx__ | last time GPU was not idle           |


Following is a list of labels appearing in Run:I metrics:

 <!-- https://tabletomarkdown,com/convert-spreadsheet-to-markdown/ -->
| Label                  | Description   |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| clusterId              | Cluster Identifier                                                                                                                                               |
| cpu_quota              | ?                                                                                                                                                               |
| gpu                    | ?                                                                                                                                                                |
| gpu_guaranteed_quota   | ?                                                                                                                                                                |
| image                  | Name of docker image                                                                                                                                             |
| job_name               | Job name                                                                                                                                                         |
| job_type               | Job type: training, interactive or inference                                                                                                                     |
| job_uuid               | Job identifier                                                                                                                                                   |
| memory_quota           | ?                                                                                                                                                                |
| node                   | ?                                                                                                                                                                |
| pod_name               | ?                                                                                                                                                                |
| pod_namespace          | ?                                                                                                                                                                |
| project                | Name of Run:AI Project                                                                                                                                           |
| status                 | Job status: Running, Pending etc. For more information on Job statuses see \[document\](https://docs.run.ai/Researcher/scheduling/job-statuses/){target=\_blank} |
| user                   | User identifier                                                                                                                                                  |



## Other Metrics

Run:AI exports other metrics emitted by NVIDIA and Kubernetes packages, as follows:

| Metric name                      | Description                          |
| -------------------------------- | ------------------------------------ |
| DCGM_GPU_MODEL                   | GPU model. example: Tesla V100-SXM2-32GB |
| dcgm_gpu_utilization             | GPU utilization                      |
| kube_node_status_allocatable                      | Resources (cpu, memory, gpu etc) are allocatble (available for scheduling)  |
| kube_node_status_capacity                         | The capacity for different resources of a node                                      |
| kube_node_status_condition                        | The condition of a cluster node                                                     |
| kube_pod_container_resource_requests              | The number of requested request resource by a container                             |
| kube_pod_container_resource_requests_cpu_cores    | The number of CPU cores requested by container                                      |
| kube_pod_container_resource_requests_memory_bytes | Bytes of memory requested by a container                                            |
| kube_pod_info                                     | Information about pod                                                               |
| kube_pod_status_phase                             | The current phase of the pod                                                 |


For additional information, see Kubernetes [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics){target=_blank} and NVIDIA [dcgm exporter](https://github.com/NVIDIA/gpu-monitoring-tools){target=_blank}.

## How to Query Metrics

=== "SaaS" 
    do this

=== "Self Hosted" 
    do that