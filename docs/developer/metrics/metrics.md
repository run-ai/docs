
 <!-- Tables in this doc were generated using:  https://tabletomarkdown,com/convert-spreadsheet-to-markdown/ -->

## What are Metrics

[Metrics](https://prometheus.io/docs/introduction/overview/#what-are-metrics){target=_blank} are numeric measurements recorded __over time__ that are emitted from the Run:ai cluster. Typical metrics involve utilization, allocation, time measurements and so on. Metrics are used in Run:ai dashboards as well as in the Run:ai administration user interface. 

The purpose of this document is to detail the structure and purpose of metrics emitted by Run:ai to enable customers to create custom dashboards or integrate metric data into other monitoring systems. 

Run:ai uses [Prometheus](https://prometheus.io){target=_blank} for collecting and querying metrics.


##  Published Run:ai Metrics


Following is the list of published Run:ai metrics:

| Metric name                                    | Labels                                                                | Measurement | Description                           |
| ---------------------------------------------- | --------------------------------------------------------------------- |------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| runai_active_job_cpu_requested_cores           | {clusterId,  job_name, job_uuid}              | CPU Cores | Job's requested CPU cores |
| runai_active_job_memory_requested_bytes        | {clusterId,  job_name, job_uuid}              | Bytes | Job's requested CPU memory |
| runai_cluster_cpu_utilization                  |  {clusterId}                                                          |    0 to 1   | CPU utilization of the entire cluster                                                |
| runai_cluster_memory_used_bytes                |  {clusterId}                                                          | Bytes       | Used CPU memory of the entire cluster                                              |
| runai_cluster_memory_utilization               |  {clusterId}                                                          |    0 to 1   | CPU memory utilization of the entire cluster                                         |
| runai_gpu_is_allocated                         |  {gpu, clusterId, node}                                               |    0/1      | Is a GPU hosting a pod         |
| runai_gpu_is_running_fractional_job            |  {gpu, clusterId, node}                                               |    0/1      | Is GPU hosting Fractional GPU jobs                                                  |
| runai_gpu_last_active_time                     |  {gpu, clusterId, node}                                               | Unix time   | Last time GPU was not idle            |
| runai_gpu_utilization_non_<br>fractional_jobs  |  {job_uuid, job_name, clusterId, gpu, node}                           | 0 to 100    | Utilization per GPU for jobs running on a full GPU   |
| runai_gpu_utilization_with_pod_info            |  {pod_namespace, pod_name, clusterId, gpu, node}                      | 0 to 100    | GPU utilization per GPU        |
| runai_job_allocated_gpus                       |  {job_type, job_uuid, job_name, clusterId, project}                   | Double      | GPUs allocated to Jobs                   |
| runai_job_gpu_utilization                      |  {job_uuid, clusterId, job_name, project}                             | 0 to 100    | Average GPU utilization per job   |
| runai_job_image                                |  {image, job_uuid, job_name, clusterId}                               | N/A         | Image name per job                    |
| runai_job_requested_gpu_memory                 |  {job_type, job_uuid, job_name, clusterId, project}                   | Bytes       | Requested GPU memory per job (0 if not specified by the user)                       |
| runai_job_requested_gpus                       |  {job_type, job_uuid, job_name, clusterId, project}                   | Double      | Number of requested GPU per job       |
| runai_job_status_with_info                     |  {user, job_type, status, job_name, clusterId, node, project}         | N/A         | Additional information on jobs  |
| runai_job_total_runtime                        |  {clusterId, job_uuid}                                                | Seconds     | Total run time per job         |
| runai_job_total_wait_time                      |  {clusterId, job_uuid}                                                | Seconds     |  Total wait time per job      |
| runai_job_used_gpu_memory_bytes                |  {clusterId, job_uuid}                                                | Bytes       | Used GPU memory per job   |
| runai_job_used_gpu_memory_bytes_<br>with_gpu_node  |  {job_uuid, job_name, clusterId, gpu, node}                       | Bytes       | Used GPU memory per job, per GPU on which the job is running     |
| runai_node_cpu_requested_cores                 |  {clusterId, node}                                                    | Double      | Sum of the requested CPU cores of all jobs running in a node         |
| runai_node_cpu_utilization                     |  {clusterId, node}                                                    | 0 to 1      | CPU utilization per node      |
| runai_node_gpu_used_memory_bytes               |  {clusterId, node}                                                    | Bytes       | Used GPU memory per node       |
| runai_node_memory_utilization                  |  {clusterId, node}                                                    | 0 to 1      | CPU memory utilization per node |
| runai_node_requested_memory_bytes              |  {clusterId, node}                                                    | Bytes       | Sum of the requested CPU memory of all jobs running in a node       |
| runai_node_total_memory_bytes                  |  {clusterId, node}                                                    | Bytes       | Total GPU memory per node    |
| runai_node_used_memory_bytes                   |  {clusterId, node}                                                    | Bytes       | Used CPU memory per node     |
| runai_project_guaranteed_gpus                  |  {clusterId, project}                                                 | Double      | Guaranteed GPU quota per project                                       |
| runai_project_info                             |  {memory_quota, cpu_quota, gpu_guaranteed_quota, clusterId, project, department_name}  | N/A         | Information on CPU, CPU memory, GPU quota per project                  |
| runai_running_job_cpu_limit_cores              |  {clusterId, job_name , job_uuid}                                        | Double      | Jobs CPU limit (in number of cores). See [link](https://docs.run.ai/Researcher/scheduling/allocation-of-cpu-and-memory)    |
| runai_running_job_cpu_requested_cores          |  {clusterId, job_name, job_uuid}                                      | Double      | Jobs requested CPU cores. See [link](https://docs.run.ai/Researcher/scheduling/allocation-of-cpu-and-memory)                                                                 |
| runai_running_job_cpu_used_cores               |  {job_uuid, clusterId, job_name, project}                             | Double      | Jobs CPU usage (in number of cores)     |
| runai_running_job_memory_limit_bytes           |  {clusterId, job_name, job_uuid}                                      | Bytes       | Jobs CPU memory limit. See [link](https://docs.run.ai/Researcher/scheduling/allocation-of-cpu-and-memory)       |
| runai_running_job_memory_requested_bytes       |  {clusterId, job_name, job_uuid}                                      | Bytes       | Jobs requested CPU memory. See [link](https://docs.run.ai/Researcher/scheduling/allocation-of-cpu-and-memory)    |
| runai_running_job_memory_used_bytes            |  {job_uuid, clusterId, job_name, project}                             | Bytes       | Jobs used CPU memory          |
| runai_mig_mode_gpu_count                       |  {clusterId, node}                                                    | Double      | Number of GPUs on MIG nodes          |
| runai_job_swap_memory_used_bytes               |  {clusterId, job_uuid, job_name, project, node}                          | Bytes       | Used Swap CPU memory for the job | 
| runai_deployment_request_rate                  | {clusterId, namespace_name, deployment_name}                             | Number      | Rate of received HTTP requests per second
| runai_deployment_request_latencies             | {clusterId, namespace_name, deployment_name, le}                         | Number      | Histogram of response time (bins are in milliseconds)

Additional metrics for version 2.9 and above

| Metric name                                    | Labels                                                                | Measurement | Description                           |
| ---------------------------------------------- | --------------------------------------------------------------------- |------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| runai_gpu_utilization_per_gpu           | {clusterId, gpu, node}              | % | GPU Utilization per GPU |
| runai_gpu_utilization_per_node        | {clusterId, node}              | % | GPU Utilization per Node |
| runai_gpu_memory_used_mebibytes_per_gpu           | {clusterId, gpu, node}              | MiB | Used GPU memory per GPU |
| runai_gpu_memory_used_mebibytes_per_node        | {clusterId, node}              | MiB | Used GPU memory per Node |
| runai_gpu_memory_total_mebibytes_per_gpu           | {clusterId, gpu, node}              | MiB | Total GPU memory per GPU |
| runai_gpu_memory_total_mebibytes_per_node        | {clusterId, node}              | MiB | Toal GPU memory per Node |
| runai_gpu_count_per_node           | {clusterId, node}              | Number | Number of GPUs per Node |
| runai_allocated_gpu_count_per_workload        | {clusterId, job_name, job_uuid, job_type, user}              | Double | Number of allocated GPUs per Workload |
| runai_allocated_gpu_count_per_project           | {clusterId, project}              | Double | Number of allocated GPUs per Project |
| runai_gpu_memory_used_mebibytes_per_pod_per_gpu        | {clusterId, pod_name, pod_uuid, pod_namespace, node, gpu}              | MiB | Used GPU Memory per Pod per Gpu |
| runai_gpu_memory_used_mebibytes_per_workload        | {clusterId, job_name, job_uuid, job_type, user}              | MiB | Used GPU Memory per Workload |
| runai_gpu_utilization_per_pod_per_gpu        | {clusterId, pod_name, pod_uuid, pod_namespace, node, gpu}              | % | GPU Utilization per Pod per GPU |
| runai_gpu_utilization_per_workload        | {clusterId, job_name, job_uuid, job_type, user}              | % | GPU Utilization per Workload |
| runai_gpu_utilization_per_project        | {clusterId, project}              | % | GPU Utilization per Project |
| runai_last_gpu_utilization_time_per_workload        | {clusterId, job_name, job_uuid, job_type, user}              | Seconds (Unix Timestamp) | The Last Time (Unix Timestamp) That The Workload Utilized Any Of His Allocated GPUs |
| runai_gpu_idle_time_per_workload        | {clusterId, job_name, job_uuid, job_type, user}              | Seconds | Seconds Passed Since The Workload Utilized Any Of His Allocated GPUs |
| runai_allocated_gpu_count_per_pod        | {clusterId, pod_name, pod_uuid, pod_namespace, node}              | Double | Number Of Allocated GPUs per Pod |
| runai_allocated_gpu_count_per_node        | {clusterId, node}              | Double | Number Of Allocated GPUs per Node |
| runai_allocated_millicpus_per_pod        | {clusterId, pod_name, pod_uuid, pod_namespace, node}              | Integer | Number Of Allocated Millicpus per Pod |
| runai_allocated_memory_per_pod        | {clusterId, pod_name, pod_uuid, pod_namespace, node}              | Bytes | Allocated Memory per Pod |


Following is a list of labels appearing in Run:ai metrics:

| Label                  | Description   |
| ---------------------- | -------------------------------------------------------------- |
| clusterId              | Cluster Identifier                 |
| department_name        | Name of Run:ai Department          |
| cpu_quota              | CPU limit per project              |
| gpu                    | GPU index                          |
| gpu_guaranteed_quota   | Guaranteed GPU quota per project   |
| image                  | Name of Docker image               |
| namespace_name         | Namespace                          |
| deployment_name        | Deployment name                    |
| job_name               | Job name                           |
| job_type               | Job type: training, interactive or inference               |
| job_uuid               | Job identifier                     |
| pod_name               | Pod name. A Job can contain many pods. |
| pod_namespace          | Pod namespace                      |
| memory_quota           | CPU memory limit per project       |
| node                   | Node name                          |
| project                | Name of Run:ai Project             |
| status                 | Job status: Running, Pending, etc. For more information on Job statuses see [document](https://docs.run.ai/Researcher/scheduling/job-statuses/) |
| user                   | User identifier                    |


## Other Metrics

Run:ai exports other metrics emitted by NVIDIA and Kubernetes packages, as follows:

| Metric name                                       | Description                          |
| ------------------------------------------------- | ------------------------------------ |
| dcgm_gpu_utilization                              | GPU utilization                      |
| kube_node_status_allocatable                      | Resources (CPU, memory, GPU etc) are allocatble (available for scheduling)  |
| kube_node_status_capacity                         | The capacity for different resources of a node                              |
| kube_node_status_condition                        | The condition of a cluster node                                             |
| kube_pod_container_resource_requests              | The number of requested resources by a container                            |
| kube_pod_container_resource_requests_cpu_cores    | The number of CPU cores requested by container                              |
| kube_pod_container_resource_requests_memory_bytes | Bytes of memory requested by a container                                    |
| kube_pod_info                                     | Information about pod                                                       |
| kube_pod_status_phase                             | The current phase of the pod                                                |


For additional information, see Kubernetes [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics){target=_blank} and NVIDIA [dcgm exporter](https://github.com/NVIDIA/gpu-monitoring-tools){target=_blank}.

## Create custom dasbhoards

To create custom dashboards based on the above metrics, please contact Run:ai customer support. 
