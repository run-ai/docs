# Run:ai at scale

Operating Run:ai at scale ensures that the system can efficiently handle fluctuating workloads while maintaining optimal performance. As clusters grow—whether due to an increasing number of nodes or a surge in workload demand—Run:ai services must be appropriately tuned to support large-scale environments.

This guide outlines the best practices for optimizing Run:ai for high-performance deployments, including Run:ai system services configurations, vertical scaling (adjusting CPU and memory resources) and where applicable, horizontal scaling (replicas).

## Run:ai services

### Vertical scaling

Each of the Run:ai containers has default resource requirements that reflect an average customer load. With significantly larger cluster loads, certain Run:ai services will require more CPU and memory resources. Run:ai supports configuring these resources for each Run:ai service group separately. For instructions and more information, see [Run:ai services resource management](../advanced-setup/advanced-cluster-configurations.md#run-ai-services-resource-management).

#### Scheduling services

The scheduling services group should be scaled together with the number of [nodes](../manage-ai-initiatives/managing-your-resources/nodes.md) and the number of [workloads](../workloads-in-runai/workloads.md) handled by the[ Scheduler](../scheduling-and-resource-optimization/scheduling/how-the-scheduler-works.md) (running / pending). These resource recommendations are based on internal benchmarks performed on stressed environments:

<table><thead><tr><th width="246">Scale (nodes/workloads)</th><th width="154">CPU (request)</th><th>Memory (request)</th></tr></thead><tbody><tr><td>Small - 30 / 480</td><td>1</td><td>1GB</td></tr><tr><td>Medium - 100 / 1600</td><td>2</td><td>2GB</td></tr><tr><td>Large - 500 / 8500</td><td>2</td><td>7GB</td></tr></tbody></table>

#### Sync and workload services

The sync and workload service groups are less sensitive for scale. The recommendation for large or intensive environments is set to the following:

<table><thead><tr><th width="258">CPU (request-limit)</th><th>Memory (request-limit)</th></tr></thead><tbody><tr><td>1-2</td><td>1GB-2GB</td></tr></tbody></table>

### Horizontal scaling

By default, Run:ai cluster services are deployed with a single replica. For large scale and intensive environments it is recommended to scale the Run:ai services horizontally by increasing the number of replicas. For more information, see [Run:ai services replicas](../advanced-setup/advanced-cluster-configurations.md#run-ai-services-replicas).

## Metrics collection

Run:ai relies on [Prometheus](../../saas/cluster-installation/system-requirements.md#prometheus) to scrape cluster metrics and forward them to the Run:ai control plane. The volume of metrics generated is directly proportional to the number of nodes, workloads, and projects in the system. When operating at scale—reaching hundreds, and thousands of nodes and projects—the system generates a significant volume of metrics which can place a strain on the cluster and the network bandwidth.

To mitigate this impact, it is recommended to tune the Prometheus [remote-write](https://prometheus.io/docs/specs/remote_write_spec/) configurations. See [remote write tuning](https://prometheus.io/docs/practices/remote_write/#remote-write-tuning) to read more about the tuning parameters available via the remote write configuration and refer to this [article](https://last9.io/blog/optimizing-prometheus-remote-write-performance-guide/) for optimizing Prometheus remote write performance.

You can apply the remote-write configurations required as described in [advanced cluster configurations.](../advanced-setup/advanced-cluster-configurations.md#prometheus)

The following example demonstrates the recommended approach in Run:ai for tuning **Prometheus remote-write** configurations:

```yaml
remoteWrite:
  queueConfig:
    capacity: 5000
    maxSamplesPerSend: 1000
    maxShards: 100
```

\\

\\
