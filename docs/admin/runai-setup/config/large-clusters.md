# Large Cluster Configuration 

## Background

Under Kubernetes, each of the Run:ai containers, has default resource requirements that reflect an average customer load. With significantly larger cluster loads, certain Run:ai services will require more CPU and memory resources. Run:ai now supports the ability to configure these resources and to do so for each Run:ai service group separately.

## Service Groups

Run:ai supports setting requests and limit configurations for CPU and memory for Run:ai containers. The configuration is set per _service group_. Each service group reflects a certain load type:

| Service Group | Description | Run:ai containers |
|---------------|-------------|-------------------|
| SchedulingServices | Containers associated with the Run:ai scheduler | Scheduler, StatusUpdater, MetricsExporter, PodGrouper, PodGroupAssigner, Binder |
| SyncServices | Containers associated with syncing updates between the Run:ai cluster and the Run:ai control plane | Agent, ClusterSync, AssetsSync | 
| WorkloadServices| Containers associated with submitting Run:ai Workloads | WorkloadController, JobController |

## Configuration Steps
To configure resource requirements for a group of services, update the RunaiConfig. Set the  `spec.global.<service-group>.` resources section.
The following example shows the configuration of scheduling services resource requirements:

``` yaml
apiVersion: run.ai/v1
kind: RunaiConfig
metadata:
spec:
 global:
   schedulingServices:
     resources:
       limits:
         cpu: 1000m
         memory: 1Gi
       requests:
         cpu: 100m
         memory: 512Mi
```

Use `syncServices` and `workloadServices` for the other two service groups. 

## Recommended Resource Specifications For Large Clusters

In large clusters (100 nodes or 1500 GPUs or more), we recommend the following configuration for SchedulingServices and SyncServices groups:

``` yaml
resources:
 requests:
   cpu: 1
   memory: 1Gi
 limits:
   cpu: 2
   memory: 2Gi
```



