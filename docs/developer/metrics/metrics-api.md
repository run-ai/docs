

## What are Metrics

_Metrics_ are numeric measurements recorded __over time__ that are emitted from the Run:ai cluster. Typical metrics involve utilization, allocation, time measurements and so on. Metrics are used in Run:ai dashboards as well as in the Run:ai administration user interface.

The purpose of this document is to detail the structure and purpose of metrics emitted by Run:ai to enable customers to create custom dashboards or integrate metric data into other monitoring systems.

Run:ai provides metrics via the [Run:ai Control-plane API](../admin-rest-api/overview.md). In the past, Run:ai provided metrics information via direct access to an internal metrics store. This method is deprecated but is still documented [here](metrics.md).


## Metric Scopes

Run:ai provides Control-plane API which supports and aggregates metrics at various levels.

| Level | Description | 
| :---- | ----- |  
| Cluster | Cluster is a set of Nodes Pools & Nodes. With Cluster metrics, metrics are aggregated at the Cluster level | 
| Node Pool | Metrics are aggregated at the Node (machine) level |
| Workload | Metrics are aggregated at the Workload level. Some Workloads, e.g. with distributed workloads, these metrics aggregate data from all worker pods |
| Pod | The basic execution unit | 

## Supported Metrics


| Metric | Cluster | Node Pool | Workload | Pod |
| :---- | ----- | ----- | ----- | ----- |
| API | [Cluster API](https://app.run.ai/api/docs#tag/Clusters/operation/get_cluster_metrics){target=_blank} | [Node Pool API](https://app.run.ai/api/docs#tag/NodePools/operation/get_nodepool_metrics){target=_blank} | [Workload API](https://app.run.ai/api/docs#tag/Workloads/operation/get_workload_metrics){target=_blank} | [Pod API](https://app.run.ai/api/docs#tag/Pods/operation/get_workload_pod_metrics){target=_blank} |
| ALLOCATED_GPU | TRUE | TRUE |  |  |
| AVG_WORKLOAD_WAIT_TIME | TRUE | TRUE |  | n/a |
| CPU_LIMIT_CORES |  |  | TRUE |  |
| CPU_MEMORY_LIMIT_BYTES | n/a | n/a | TRUE |  |
| CPU_MEMORY_REQUEST_BYTES | n/a | n/a | TRUE |  |
| CPU_MEMORY_USAGE_BYTES |  |  | TRUE | TRUE |
| CPU_MEMORY_UTILIZATION | TRUE | TRUE |  |  |
| CPU_REQUEST_CORES |  |  | TRUE |  |
| CPU_USAGE_CORES |  |  | TRUE | TRUE |
| CPU_UTILIZATION | TRUE | TRUE |  |  |
| GPU_ALLOCATION |  |  | TRUE |  |
| GPU_MEMORY_REQUEST_BYTES |  |  | TRUE |  |
| GPU_MEMORY_USAGE_BYTES |  |  | TRUE | TRUE |
| GPU_MEMORY_USAGE_BYTES_PER_GPU |  |  |  | TRUE |
| GPU_MEMORY_UTILIZATION | TRUE | TRUE |  |  |
| GPU_QUOTA | TRUE | TRUE | n/a | n/a |
| GPU_UTILIZATION | TRUE | TRUE | TRUE | TRUE |
| GPU_UTILIZATION_PER_GPU |  |  |  | TRUE |
| POD_COUNT |  |  | TRUE | n/a |
| RUNNING_POD_COUNT |  |  | TRUE | n/a |
| TOTAL_GPU | TRUE | TRUE | n/a | n/a |


### Advanced Metrics

NVIDIA provides extended metrics at the __Pod__ level. These are documented [here](https://docs.nvidia.com/datacenter/dcgm/latest/user-guide/feature-overview.html#profiling-metrics){target=_blank}. To enable these metrics please contact Run:ai customer support. 


| Metric | Cluster | Node Pool | Workload | Pod |
| :---- | ----- | ----- | ----- | ----- |
| GPU_FP16_ENGINE_ACTIVITY_PER_GPU |  |  |  | TRUE |
| GPU_FP32_ENGINE_ACTIVITY_PER_GPU |  |  |  | TRUE |
| GPU_FP64_ENGINE_ACTIVITY_PER_GPU |  |  |  | TRUE |
| GPU_GRAPHICS_ENGINE_ACTIVITY_PER_GPU |  |  |  | TRUE |
| GPU_MEMORY_BANDWIDTH_UTILIZATION_PER_GPU |  |  |  | TRUE |
| GPU_NVLINK_RECEIVED_BANDWIDTH_PER_GPU |  |  |  | TRUE |
| GPU_NVLINK_TRANSMITTED_BANDWIDTH_PER_GPU |  |  |  | TRUE |
| GPU_PCIE_RECEIVED_BANDWIDTH_PER_GPU |  |  |  | TRUE |
| GPU_PCIE_TRANSMITTED_BANDWIDTH_PER_GPU |  |  |  | TRUE |
| GPU_SM_ACTIVITY_PER_GPU |  |  |  | TRUE |
| GPU_SM_OCCUPANCY_PER_GPU |  |  |  | TRUE |
| GPU_TENSOR_ACTIVITY_PER_GPU |  |  |  | TRUE |

