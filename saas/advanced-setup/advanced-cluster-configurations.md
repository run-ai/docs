# Advanced cluster configuration

Advanced cluster configurations can be used to tailor your Run:ai cluster deployment to meet specific operational requirements and optimize resource management. By fine-tuning these settings, you can enhance functionality, ensure compatibility with organizational policies, and achieve better control over your cluster environment. This article provides guidance on implementing and managing these configurations to adapt the Run:ai cluster to your unique needs.

After the Run:ai cluster is installed, you can adjust various settings to better align with your organization's operational needs and security requirements.

### Edit cluster configurations

Advanced cluster configurations are managed through the `runaiconfig` [Kubernetes Custom Resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/). To modify the cluster configurations, use the following command:

```bash
kubectl edit runaiconfig runai -n runai
```

### Configurations

The following configurations allow you to enable or disable features, control permissions, and customize the behavior of your Run:ai cluster:

| Key                                                                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| --------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| spec.project-controller.createNamespaces _(boolean)_                  | <p>Allows Kubernetes namespace creation for new projects<br>Default: <code>true</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| spec.mps-server.enabled _(boolean)_                                   | <p>Enabled when using <a href="https://docs.nvidia.com/deploy/mps/index.html">NVIDIA MPS</a><br>Default: <code>false</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| spec.global.subdomainSupport _(boolean)_                              | <p>Allows the creation of subdomains for ingress endpoints, enabling access to workloads via unique subdomains on the <a href="../cluster-installation/system-requirements.md#fully-qualified-domain-name-fqdn">Fully Qualified Domain Name (FQDN)</a>. For details, see <a href="https://docs.run.ai/latest/admin/config/allow-external-access-to-containers/">External Access to Container</a><br>Default: <code>false</code></p>                                                                                                                                                     |
| spec.prometheus.spec.retention _(string)_                             | <p>Defines how long Prometheus retains Run:ai metrics locally, which is useful in case of potential connectivity issues. For more information, see <a href="https://prometheus.io/docs/prometheus/latest/storage/#storage">Prometheus Storage</a>.<br>Default: <code>2h</code></p>                                                                                                                                                                                                                                                                                                      |
| spec.prometheus.spec.retentionSize _(string)_                         | <p>Allocates storage space for Run:ai metrics in Prometheus, which is useful in case of potential connectivity issues. For more information, see <a href="https://prometheus.io/docs/prometheus/latest/storage/#storage">Prometheus Storage</a>.<br>Default: <code>“"</code></p>                                                                                                                                                                                                                                                                                                        |
| spec.prometheus.logLevel _(string)_                                   | <p>Sets the Prometheus log levelPossible values: [debug, info, warn, error]<br>Default: <code>“info"</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| spec.prometheus.additionalAlertLabels _(object)_                      | <p>Sets additional custom labels for the <a href="../infrastructure-procedures/runai-system-monitoring.md#built-in-alerts">built-in alerts</a><br>Example: <code>{“env”: “prod”}</code><br>Default: <code>{}</code></p>                                                                                                                                                                                                                                                                                                                                                                 |
| spec.global.nodeAffinity.restrictScheduling _(boolean)_               | <p>Enables setting <a href="node-roles.md">node roles</a> and restricting workload scheduling to designated nodes<br>Default: <code>false</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| spec.global.affinity _(object)_                                       | <p>Sets the system nodes where Run:ai system-level services are scheduled. Using global.affinity will overwrite the <a href="node-roles.md">node roles</a> set using the Administrator CLI (runai-adm).<br>Default: Prefer to schedule on nodes that are labeled with <a href="http://node-role.kubernetes.io/runai-system">node-role.kubernetes.io/runai-system</a></p>                                                                                                                                                                                                                |
| spec.global.tolerations _(object)_                                    | Configure Kubernetes tolerations for Run:ai system-level services                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| spec.daemonSetsTolerations _(object)_                                 | Configure Kubernetes tolerations for Run:ai daemonSets / engine                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| spec.runai-container-toolkit.logLevel _(boolean)_                     | <p>Specifies the run:ai-container-toolkit logging level: either 'SPAM', 'DEBUG', 'INFO', 'NOTICE', 'WARN', or 'ERROR'<br>Default: <code>INFO</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| spec.runai-container-toolkit.enabled _(boolean)_                      | <p>Enables workloads to use <a href="../scheduling-and-resource-optimization/resource-optimization/gpu-fractions.md">GPU fractions</a></p><p>Default: <code>true</code></p>                                                                                                                                                                                                                                                                                                                                                                                                             |
| node-scale-adjuster.args.gpuMemoryToFractionRatio _(object)_          | <p>A scaling-pod requesting a single GPU device will be created for every 1 to 10 pods requesting fractional GPU memory (1/gpuMemoryToFractionRatio). This value represents the ratio (0.1-0.9) of fractional GPU memory (any size) to GPU fraction (portion) conversion.<br>Default: <code>0.1</code></p>                                                                                                                                                                                                                                                                              |
| spec.global.core.dynamicFractions.enabled _(boolean)_                 | <p>Enables <a href="../scheduling-and-resource-optimization/resource-optimization/dynamic-gpu-fractions.md">dynamic GPU fractions</a><br>Default: <code>true</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                 |
| spec.global.core.swap.enabled _(boolean)_                             | <p>Enables <a href="../scheduling-and-resource-optimization/resource-optimization/gpu-memory-swap.md">memory swap</a> for GPU workloads<br>Default: <code>false</code></p>                                                                                                                                                                                                                                                                                                                                                                                                              |
| spec.global.core.swap.limits.cpuRam _(string)_                        | <p>Sets the CPU memory size used to swap GPU workloads<br>Default:<code>100Gi</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| spec.global.core.swap.limits.reservedGpuRam _(string)_                | <p>Sets the reserved GPU memory size used to swap GPU workloads<br>Default: <code>2Gi</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| spec.global.core.nodeScheduler.enabled _(boolean)_                    | <p>Enables the <a href="../scheduling-and-resource-optimization/resource-optimization/node-level-scheduler.md">node-level scheduler</a><br>Default: <code>false</code></p>                                                                                                                                                                                                                                                                                                                                                                                                              |
| spec.global.core.timeSlicing.mode _(string)_                          | <p>Sets the <a href="../scheduling-and-resource-optimization/resource-optimization/gpu-time-slicing.md">GPU time-slicing mode</a>. Possible values:</p><ul><li><code>timesharing</code> - all pods on a GPU share the GPU compute time evenly.</li><li><code>strict</code> - each pod gets an exact time slice according to its memory fraction value.</li><li><code>fair</code> - each pod gets an exact time slice according to its memory fraction value and any unused GPU compute time is split evenly between the running pods.</li></ul><p>Default: <code>timesharing</code></p> |
| spec.runai-scheduler.fullHierarchyFairness _(boolean)_                | <p>Enables fairness between departments, on top of projects fairness<br>Default: <code>true</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| spec.runai-scheduler.args.defaultStalenessGracePeriod                 | <p>Sets the timeout in seconds before the scheduler evicts a stale pod-group (gang) that went below its min-members in running state:</p><ul><li><code>0s</code> - Immediately (no timeout)</li><li><code>-1</code> - Never</li></ul><p>Default: <code>60s</code></p>                                                                                                                                                                                                                                                                                                                   |
| spec.pod-grouper.args.gangSchedulingKnative _(boolean)_               | <p>Enables gang scheduling for inference workloads.For backward compatibility with versions earlier than v2.19, change the value to false<br>Default: <code>false</code></p>                                                                                                                                                                                                                                                                                                                                                                                                            |
| spec.pod-grouper.args.gangScheduleArgoWorkflow _(boolean)_            | <p>Groups all pods of a single ArgoWorkflow workload into a single Pod-Group for gang scheduling<br>Default: <code>true</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| spec.runai-scheduler.args.verbosity _(int)_                           | <p>Configures the level of detail in the logs generated by the scheduler service<br>Default: <code>4</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| spec.limitRange.cpuDefaultRequestCpuLimitFactorNoGpu _(string)_       | <p>Sets a default ratio between the CPU request and the limit for workloads without GPU requests<br>Default: <code>0.1</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| spec.limitRange.memoryDefaultRequestMemoryLimitFactorNoGpu _(string)_ | <p>Sets a default ratio between the memory request and the limit for workloads without GPU requests<br>Default: <code>0.1</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| spec.limitRange.cpuDefaultRequestGpuFactor _(string)_                 | <p>Sets a default amount of CPU allocated per GPU when the CPU is not specified<br>Default: <code>100</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| spec.limitRange.cpuDefaultLimitGpuFactor _(int)_                      | <p>Sets a default CPU limit based on the number of GPUs requested when no CPU limit is specified<br>Default: <code>NO DEFAULT</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| spec.limitRange.memoryDefaultRequestGpuFactor _(string)_              | <p>Sets a default amount of memory allocated per GPU when the memory is not specified<br>Default: <code>100Mi</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| spec.limitRange.memoryDefaultLimitGpuFactor _(string)_                | <p>Sets a default memory limit based on the number of GPUs requested when no memory limit is specified<br>Default: <code>NO DEFAULT</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| spec.global.enableWorkloadOwnershipProtection _(boolean)_             | <p>Prevents users within the same project from deleting workloads created by others. This enhances workload ownership security and ensures better collaboration by restricting unauthorized modifications or deletions.<br>Default: <code>false</code></p>                                                                                                                                                                                                                                                                                                                              |

#### Run:ai services resource management

Run:ai cluster includes many different services. To simplify resource management, the configuration structure allows you to configure the containers CPU / memory resources for each service individually or group of services together.

| Service Group      | Description                                                                                        | Run:ai containers                                                               |
| ------------------ | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| SchedulingServices | Containers associated with the Run:ai Scheduler                                                    | Scheduler, StatusUpdater, MetricsExporter, PodGrouper, PodGroupAssigner, Binder |
| SyncServices       | Containers associated with syncing updates between the Run:ai cluster and the Run:ai control plane | Agent, ClusterSync, AssetsSync                                                  |
| WorkloadServices   | Containers associated with submitting Run:ai workloads                                             | <p>WorkloadController, </p><p>JobController</p>                                 |

Apply the following configuration in order to change resources request and limit for a group of services:

```yaml
spec:
  global:
   <service-group-name>: #schedulingServices | SyncServices | WorkloadServices
     resources:
       limits:
         cpu: 1000m
         memory: 1Gi
       requests:
         cpu: 100m
         memory: 512Mi
```

Or, apply the following configuration in order to change resources request and limit for each service individually:

```yaml
spec:
  <service-name>: # for example: pod-grouper
    resources:
      limits:
        cpu: 1000m
        memory: 1Gi
      requests:
        cpu: 100m
        memory: 512Mi
```

For resource recommendations, see [Vertical scaling](../infrastructure-procedures/runai-at-scale.md#vertical-scaling).

#### Run:ai services replicas

By default, all Run:ai containers are deployed with a single replica. Some services support multiple replicas for redundancy and performance.

To simplify configuring replicas, a global replicas configuration can be set and is applied to all supported services:

```yaml
spec:
  global: 
    replicaCount: 1 # default
```

&#x20;This can be overwritten for specific services (if supported). Services without the `replicas` configuration does not support replicas:

```yaml
spec:
  <service-name>: # for example: pod-grouper
    properties:
      replicas: 1 # default
```

#### Prometheus

The prometheus instance can be configured b

#### Run:ai managed nodes

To include or exclude specific nodes from running workloads within a cluster managed by Run:ai, use the `nodeSelectorTerms` flag. For additional details, see [Kubernetes nodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector).

Label the nodes using the below:

* key: Label key (e.g., zone, instance-type).
* operator: Operator defining the inclusion/exclusion condition (In, NotIn, Exists, DoesNotExist).
* values: List of values for the key when using In or NotIn.

The below example shows how to include NVIDIA GPUs only and exclude all other GPU types in a cluster with mixed nodes, based on product type GPU label:

<pre class="language-bash"><code class="lang-bash">nodeSelectorTerms:
- matchExpressions:
<strong>  - key: nvidia.com/gpu.product  
</strong>    operator: Exists
</code></pre>

{% hint style="info" %}
To view the full runaiconfig object structure, use the following command: `kubectl get crds/runaiconfigs.run.ai -n runai -o yaml`
{% endhint %}
