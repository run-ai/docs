# Scaling the Run:ai system

The purpose of this document is to provide information on how to scale the Run:ai cluster and the Run:ai control-plane to withstand large transaction loads

## Scaling the Run:ai Control Plane

The Control plane [deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/){target=_blank} which may encounter load are:

| Name |  Kubernetes Deployment name | Purpose | 
|------|-----------------------------|---------|
| Backend | runai-backend-backend | Main control-plane service | 
| Frontend | runai-backend-frontend | Serving of the Run:ai console | 
| Grafana | runai-backend-grafana | Serving of the Run:ai metrics inside the Run:ai console | 

To increase the number of replicas, run:


To increase the number of replicas, use the following Run:ai control-plane helm flags 

```
--set backend.autoscaling.enabled=true 
--set frontend.autoscaling.enabled=true
--set grafana.autoscaling.enabled=true  --set grafana.autoscaling.minReplicas=2
```


!!! Important
    If you have chosen to mark some of the nodes as Run:ai System Workers, the new replicas will attempt to use these nodes first. Thus, for [high availability](ha.md) purposes, you will want to mark more than one node as a Run:ai System Worker.  

### Thanos Querier

[Thanos](https://thanos.io/){target=_blank} is the 3rd party used by Run:ai to store metrics Under a significant user load, we would also need to increase resources for the Thanos query function:

```
kubectl edit deploy -n runai-backend runai-backend-thanos-query 
```
Change the limit and request to 2 CPUs and 2 GB of memory. 


## Scaling the Run:ai Cluster 

### CPU & Memory Resources

Under Kubernetes, each of the Run:ai containers, has default resource requirements that reflect an average customer load. With significantly larger cluster loads, certain Run:ai services will require more CPU and memory resources. Run:ai now supports the ability to configure these resources and to do so for each Run:ai service group separately.

#### Service Groups

Run:ai supports setting requests and limits configurations for CPU and memory for Run:ai containers. The configuration is set per *service group*. Each service group reflects a certain load type:

| Service Group | Description | Run:ai containers |
|---------------|-------------|-------------------|
| SchedulingServices | Containers associated with the Run:ai scheduler | Scheduler, StatusUpdater, MetricsExporter, PodGrouper, PodGroupAssigner, Binder |
| SyncServices | Containers associated with syncing updates between the Run:ai cluster and the Run:ai control plane | Agent, ClusterSync, AssetsSync | 
| WorkloadServices| Containers associated with submitting Run:ai Workloads | WorkloadController, JobController |

#### Configuration Steps
To configure resource requirements for a group of services, update the RunaiConfig. Set the `spec.global.<service-group>.` resources section.
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

#### Recommended Resource Specifications For Large Clusters

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

### Sending Metrics

Run:ai uses [Prometheus](https://prometheus.io/){target=_blank} to scrape metrics from the Run:ai cluster and to send them to the Run:ai control plane. The number of metrics is a function of the number of Nodes, Jobs and Projects which the system contains. When reaching hundreds of Nodes and Projects, the system will be sending large quantities of metrics which, in turn, will create a strain on the network as well as the receiving side in the control plane (SaaS or self-hosted).

To reduce this strain, we suggest to configure Prometheus to send information in larger bulks and reduce the number of network connections:

* Edit the `runaiconfig` as described under [customizing the cluster](../cluster-setup/customize-cluster-install.md).
* Under `prometheus.remoteWrite` add the following:

``` yaml
queueConfig:
  capacity: 5000
  maxSamplesPerSend: 1000
  maxShards: 100
```

This [article](https://last9.io/blog/how-to-scale-prometheus-remote-write/){target=_blank} provides additional details and insight. 

Also, note that this configuration enlarges the Prometheus queues and thus increases the required memory. It is hence suggested to reduce the metrics retention period as described [here](../cluster-setup/customize-cluster-install.md#configurations)
