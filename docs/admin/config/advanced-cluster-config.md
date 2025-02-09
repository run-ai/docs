Advanced cluster configurations can be used to tailor your Run:ai cluster deployment to meet specific operational requirements and optimize resource management. By fine-tuning these settings, you can enhance functionality, ensure compatibility with organizational policies, and achieve better control over your cluster environment. This article provides guidance on implementing and managing these configurations to adapt the Run:ai cluster to your unique needs.

After the Run:ai cluster is installed, you can adjust various settings to better align with your organization's operational needs and security requirements.

## Edit cluster configurations

Advanced cluster configurations are managed through the runaiconfig [Kubernetes Custom Resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/){target=_blank}. To modify the cluster configurations, use the following command:

```
kubectl edit runaiconfig runai -n runai
```

## Configurations

The following configurations allow you to enable or disable features, control permissions, and customize the behavior of your Run:ai cluster:

| Key | Description | Default | 
| --- | --- |-------------|
| spec.project-controller.createNamespaces (boolean) | Allows Kubernetes namespace creation for new projects| true |
| spec.mps-server.enabled (boolean) | Enabled when using NVIDIA MPS | false |
| spec.global.subdomainSupport (boolean) | Allows the creation of subdomains for ingress endpoints, enabling access to workloads via unique subdomains on the Fully Qualified Domain Name (FQDN). For details, see External Access to Container| false |
| spec.runai-container-toolkit.enabled (boolean) | Allows workloads to use GPU fractions| true |
| spec.prometheus.spec.retention (string) | Defines how long Prometheus retains Run:ai metrics locally, which is useful in case of potential connectivity issues. For more information, see Prometheus Storage| 2h |
| spec.prometheus.spec.retentionSize (string) | Allocates storage space for Run:ai metrics in Prometheus, which is useful in case of potential connectivity issues. For more information, see Prometheus Storage| "" |
| spec.prometheus.logLevel (string) | Sets the Prometheus log levelPossible values: [debug, info, warn, error] |  “info" |
| spec.prometheus.additionalAlertLabels (object) | Sets additional custom labels for the [built-in alerts](../maintenance/alert-monitoring.md#built-in-alerts) Example: `{“env”: “prod”}` |  `{}` |
| spec.global.schedulingServices (object) | Defines resource constraints uniformly for the entire set of Run:ai scheduling services. For more information, see Resource requests and limits of Pod and container | `{resources: {}}` |
| spec.global.syncServices (object) | Defines resource constraints uniformly for the entire set of Run:ai sync services. For more information, see Resource requests and limits of Pod and container| `{resources: {}}` |
| spec.global.workloadServices (object) | Defines resource constraints uniformly for the entire set of Run:ai workload services. For more information, see Resource requests and limits of Pod and container | `{resources: {}}` |
| spec.global.nodeAffinity.restrictScheduling (boolean) | Enables setting node roles and restricting workload scheduling to designated nodes| false |
| spec.global.affinity (object) | Sets the system nodes where Run:ai system-level services are scheduled. Using global.affinity will overwrite the [node roles](node-roles.md) set using the Administrator CLI (runai-adm). | Prefer to schedule on nodes that are labeled with `node-role.kubernetes.io/runai-system` |
| spec.global.tolerations (object) | Configure Kubernetes tolerations for Run:ai system-level services. | | 
| spec.daemonSetsTolerations (object) | Configure Kubernetes tolerations for Run:ai daemonSets / engine. | |  
| spec.runai-container-toolkit.logLevel (boolean) | Specifies the run:ai-container-toolkit logging level: either 'SPAM', 'DEBUG', 'INFO', 'NOTICE', 'WARN', or 'ERROR' | INFO |
| node-scale-adjuster.args.gpuMemoryToFractionRatio (object) | A scaling-pod requesting a single GPU device will be created for every 1 to 10 pods requesting fractional GPU memory (1/gpuMemoryToFractionRatio). This value represents the ratio (0.1-0.9) of fractional GPU memory (any size) to GPU fraction (portion) conversion. | 0.1
| spec.global.core.dynamicFractions.enabled (boolean) | Enables dynamic GPU fractions | true |
| spec.global.core.swap.enabled (boolean) | Enables memory swap for GPU workloads | false |
| spec.global.core.swap.limits.cpuRam (string) | Sets the CPU memory size used to swap GPU workloads | 100Gi |
| spec.global.core.swap.limits.reservedGpuRam (string) | Sets the reserved GPU memory size used to swap GPU workloads | 2Gi |
| spec.global.core.nodeScheduler.enabled  (boolean) | Enables the node-level scheduler | false |
| spec.global.replicaCount  (int) | Sets a global number of pod replicas to be created for services that support replication | 1 |
| spec.limitRange.cpuDefaultRequestCpuLimitFactorNoGpu  (string) | Sets a default ratio between the CPU request and the limit for workloads without GPU requests| 0.1 |
| spec.limitRange.memoryDefaultRequestMemoryLimitFactorNoGpu  (string) | Sets a default ratio between the memory request and the limit for workloads without GPU requests | 0.1 |
| spec.limitRange.cpuDefaultRequestGpuFactor (string) | Sets a default amount of CPU allocated per GPU when the CPU is not specified| | 100m |
| spec.limitRange.cpuDefaultLimitGpuFactor (int) | Sets a default CPU limit based on the number of GPUs requested when no CPU limit is specified | NO DEFAULT |
| spec.limitRange.memoryDefaultRequestGpuFactor (string) | Sets a default amount of memory allocated per GPU when the memory is not specified | 100Mi |
| spec.limitRange.memoryDefaultLimitGpuFactor (string) | Sets a default memory limit based on the number of GPUs requested when no memory limit is specified | NO DEFAULT |
| spec.global.core.timeSlicing.mode (string) | Sets the GPU time-slicing mode.Possible values:`timesharing` - all pods on a GPU share the GPU compute time evenly.‘strict’ - each pod gets an exact time slice according to its memory fraction value.`fair` - each pod gets an exact time slice according to its memory fraction value and any unused GPU compute time is split evenly between the running pods.| timesharing |
| runai-scheduler.fullHierarchyFairness (boolean) | Enables fairness between departments, on top of projects fairness | true |
| spec.pod-grouper.args.gangSchedulingKnative (boolean) | Enables gang scheduling for inference workloads.For backward compatibility with versions earlier than v2.19, change the value to false | true |
| runai-scheduler.args.defaultStalenessGracePeriod | Sets the timeout in seconds before the scheduler evicts a stale pod-group (gang) that went below its min-members in running state: `0s` - Immediately (no timeout) `-1` - Never | 60s
| spec.runai-scheduler.args.verbosity (int) | Configures the level of detail in the logs generated by the scheduler service | 4 |
| pod-grouper.args.gangScheduleArgoWorkflow (boolean) | Groups all pods of a single ArgoWorkflow workload into a single Pod-Group for gang scheduling. | true |


### Run:ai Managed Nodes

To include or exclude specific nodes from running workloads within a cluster managed by Run:ai, use the `nodeSelectorTerms` flag. For additional details, see [Kubernetes nodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector).

Label the nodes using the below:

* key: Label key (e.g., zone, instance-type).
* operator: Operator defining the inclusion/exclusion condition (In, NotIn, Exists, DoesNotExist).
* values: List of values for the key when using In or NotIn.

The below example shows how to include NVIDIA GPUs only and exclude all other GPU types in a cluster with mixed nodes, based on product type GPU label:

``` bash
spec:   
   global:
      managedNodes:
        inclusionCriteria:
          nodeSelectorTerms:
          - matchExpressions:
            - key: nvidia.com/gpu.product  
              operator: Exists
```

!!! Tip
    To view the full runaiconfig object structure, use the following command: 
    ```
    kubectl get crds/runaiconfigs.run.ai -n runai -o yaml
    ```