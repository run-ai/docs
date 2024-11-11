# Monitoring and maintenance Overview

Deploying Run:ai in mission-critical environments requires proper monitoring and maintenance of resources to ensure workloads run and are deployed as expected.

Details on how to monitor different parts of the physical resources in your Kubernetes system, including [clusters](../config/clusters.md) and [nodes](../../platform-admin/aiinitiatives/resources/nodes.md), can be found in the monitoring and maintenance section. Adjacent configuration and troubleshooting sections also cover [high availability](../config/ha.md), [restoring](../config/dr.md) and [securing](../config/secure-cluster.md) clusters, [collecting logs](../troubleshooting/logs-collection.md), and [reviewing audit logs](./audit-log.md) to meet compliance requirements.

In addition to monitoring Run:ai resources, it is also highly recommended to monitor Run:ai runs on Kubernetes, which manages containerized applications. In particular, focus on three main layers:

## Run:ai Control Plane and cluster services

This is the highest layer and includes the parts of Run:ai pods, which run in containers managed by Kubernetes.

## Kubernetes cluster

This layer includes the main Kubernetes system that runs and manages Run:ai components. Important elements to monitor include:

*   The health of the cluster and nodes (machines in the cluster).
*   The status of key Kubernetes services, such as the API server. For detailed information on managing clusters, see the [official Kubernetes documentation](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-usage-monitoring/){target=_blank}.

## Host infrastructure

This is the base layer, representing the actual machines (virtual or physical) that make up the cluster IT teams need to handle:

*   Managing CPU, memory, and storage
*   Keeping the operating system updated
*   Setting up the network and balancing the load

Run:ai does not require any special configurations at this level.

The articles below explain how to monitor these layers, maintain system security and compliance, and ensure the reliable operation of Run:ai in critical environments.

