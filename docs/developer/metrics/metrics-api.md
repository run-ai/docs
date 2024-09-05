# Metrics and telemetry

## Telemetry

Telemetry is a numeric measurement recorded in real-time when emitted from the Run:ai cluster.

## Metrics

*Metrics* are numeric measurements recorded **over time** that are emitted from the Run:ai cluster. Typical metrics involve utilization, allocation, time measurements and so on. Metrics are used in Run:ai dashboards as well as in the Run:ai administration user interface.

---

The purpose of this document is to detail the structure and purpose of metrics emitted by Run:ai. This enables customers to create custom dashboards or integrate metric data into other monitoring systems.

Run:ai provides metrics via the [Run:ai Control-plane API](http://../admin-rest-api/overview.md). In the past, Run:ai provided metrics information via direct access to an internal metrics store. This method is deprecated but is still documented [here](http://metrics.md).

## Metric and telemetry Scopes

Run:ai provides Control-plane API which supports and aggregates metrics at various levels.

| Level | Description |
| :---- | :---- |
| Cluster | A cluster is a set of Nodes Pools & Nodes. With Cluster metrics, metrics are aggregated at the Cluster level |
| Node | Data is aggregated at the Node level. |
| Node Pool | Data is aggregated at the Node Pool level. |
| Workload | Data is aggregated at the Workload level. In some Workloads, e.g. with distributed workloads, these metrics aggregate data from all worker pods |
| Pod | The basic execution unit |

## Supported Metrics

| Metric | Cluster | Node Pool | Node | Workload | Pod |
| :---- | :---- | :---- | :---- | :---- | :---- |
| API | [Cluster API](https://app.run.ai/api/docs\#tag/Clusters/operation/get\_cluster\_metrics){target=\_blank} | [Node Pool API](https://app.run.ai/api/docs\#tag/NodePools/operation/get\_nodepool\_metrics){target=\_blank} |  | [Workload API](https://app.run.ai/api/docs\#tag/Workloads/operation/get\_workload\_metrics){target=\_blank} | [Pod API](https://app.run.ai/api/docs\#tag/Pods/operation/get\_workload\_pod\_metrics){target=\_blank} |
| ALLOCATED\_GPU | TRUE | TRUE |  | TRUE |  |
| AVG\_WORKLOAD\_WAIT\_TIME | TRUE | TRUE |  |  |  |
| CPU\_LIMIT\_CORES |  |  |  | TRUE |  |
| CPU\_MEMORY\_LIMIT\_BYTES |  |  |  | TRUE |  |
| CPU\_MEMORY\_REQUEST\_BYTES |  |  |  | TRUE |  |
| CPU\_MEMORY\_USAGE\_BYTES |  |  | TRUE | TRUE | TRUE |
| CPU\_MEMORY\_UTILIZATION | TRUE | TRUE | TRUE |  |  |
| CPU\_REQUEST\_CORES |  |  |  | TRUE |  |
| CPU\_USAGE\_CORES |  |  | TRUE | TRUE | TRUE |
| CPU\_UTILIZATION | TRUE | TRUE | TRUE |  |  |
| GPU\_ALLOCATION |  |  |  | TRUE |  |
| GPU\_MEMORY\_REQUEST\_BYTES |  |  |  | TRUE |  |
| GPU\_MEMORY\_USAGE\_BYTES |  |  |  | TRUE | TRUE |
| GPU\_MEMORY\_USAGE\_BYTES\_PER\_GPU |  |  | TRUE |  | TRUE |
| GPU\_MEMORY\_UTILIZATION | TRUE | TRUE |  |  |  |
| GPU\_MEMORY\_UTILIZATION\_PER\_GPU  |  |  | TRU |  |  |
| GPU\_QUOTA | TRUE | TRUE |  |  |  |
| GPU\_UTILIZATION | TRUE | TRUE |  | TRUE | TRUE |
| GPU\_UTILIZATION\_PER\_GPU |  |  | TRUE |  | TRUE |
| POD\_COUNT |  |  |  | TRUE |  |
| RUNNING\_POD\_COUNT |  |  |  | TRUE |  |
| TOTAL\_GPU | TRUE | TRUE |  |  |  |
| TOTAL\_GPU\_NODES | TRUE | TRUE |  |  |  |
| GPU\_UTILIZATION\_DISTRIBUTION | TRUE | TRUE |  |  |  |
| UNALLOCATED\_GPU | TRUE | TRUE |  |  |  |
|  |  |  |  |  |  |

### Advanced Metrics

NVIDIA provides extended metrics at the **Pod** level. These are documented [here](https://docs.nvidia.com/datacenter/dcgm/latest/user-guide/feature-overview.html\#profiling-metrics){target=\_blank}. To enable these metrics please contact Run:ai customer support.

| Metric | Cluster | Node Pool | Workload | Pod |
| :---- | :---- | :---- | :---- | :---- |
| GPU\_FP16\_ENGINE\_ACTIVITY\_PER\_GPU |  |  |  | TRUE |
| GPU\_FP32\_ENGINE\_ACTIVITY\_PER\_GPU |  |  |  | TRUE |
| GPU\_FP64\_ENGINE\_ACTIVITY\_PER\_GPU |  |  |  | TRUE |
| GPU\_GRAPHICS\_ENGINE\_ACTIVITY\_PER\_GPU |  |  |  | TRUE |
| GPU\_MEMORY\_BANDWIDTH\_UTILIZATION\_PER\_GPU |  |  |  | TRUE |
| GPU\_NVLINK\_RECEIVED\_BANDWIDTH\_PER\_GPU |  |  |  | TRUE |
| GPU\_NVLINK\_TRANSMITTED\_BANDWIDTH\_PER\_GPU |  |  |  | TRUE |
| GPU\_PCIE\_RECEIVED\_BANDWIDTH\_PER\_GPU |  |  |  | TRUE |
| GPU\_PCIE\_TRANSMITTED\_BANDWIDTH\_PER\_GPU |  |  |  | TRUE |
| GPU\_SM\_ACTIVITY\_PER\_GPU |  |  |  | TRUE |
| GPU\_SM\_OCCUPANCY\_PER\_GPU |  |  |  | TRUE |
| GPU\_TENSOR\_ACTIVITY\_PER\_GPU |  |  |  | TRUE |

## 

## Supported telemetry

| telemetry | Node | Workload |
| :---- | :---- | :---- |
| API | [Node API](https://api-docs.run.ai/2.18/tag/Nodes\#operation/get\_node\_telemetry){target=\_blank} | [Workload API](https://api-docs.run.ai/2.18/tag/Workloads\#operation/get\_workloads\_telemetry){target=\_blank} |
| WORKLOADS\_COUNT |  | TRUE |
| ALLOCATED\_GPUS | TRUE | TRUE |
| READY\_GPU\_NODES | TRUE |  |
| READY\_GPUS | TRUE |  |
| TOTAL\_GPU\_NODES | TRUE |  |
| TOTAL\_GPUS | TRUE |  |
| IDLE\_ALLOCATED\_GPUS | TRUE |  |
| FREE\_GPUS | TRUE |  |
| TOTAL\_CPU\_CORES | TRUE |  |
| USED\_CPU\_CORES | TRUE |  |
| ALLOCATED\_CPU\_CORES | TRUE |  |
| TOTAL\_GPU\_MEMORY\_BYTES | TRUE |  |
| USED\_GPU\_MEMORY\_BYTES | TRUE |  |
| TOTAL\_CPU\_MEMORY\_BYTES | TRUE |  |
| USED\_CPU\_MEMORY\_BYTES | TRUE |  |
| ALLOCATED\_CPU\_MEMORY\_BYTES | TRUE |  |

