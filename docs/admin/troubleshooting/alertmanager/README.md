---
title: Prometheus Alerts
summary: This article describes the alerts that Prometheus sends based on the alertmanager configuration.
authors:
    - Jason Novich
    - Gal Revach    
date: 2024-Jan-10
---
<!-- you can take some text from here https://prometheus-operator.dev/docs/user-guides/alerting/ -->
The Prometheus Operator introduces an Alertmanager resource that sends alerts about the cluster. Alertmanager is used to:

<!-- fill in here a small list -->

To configure Prometheus to send alerts, see [Setting up Alert Monitoring for Run:ai Using Alertmanager in Prometheus](../../runai-setup/maintenance/alert-monitoring.md#setting-up-alert-monitoring-for-runai-using-alertmanager-in-prometheus).

## List of Alerts

The following is a list of alerts that you will receive once Prometheus is configured.

| Alert Name |
|--|
| [RunaiAgentClusterInfoPushRateLow](RunaiAgentClusterInfoPushRateLow.md)&mdash;cluster-sync pod in ‘runai’ namespace might not be functioning properly. |
| [RunaiAgentPullRateLow](RunaiAgentPullRateLow.md)&mdash;The runai agent may not be functioning properly.                                               |
| [RunaiContainerMemoryUsageCritical](RunaiContainerMemoryUsageCritical.md)                                                                              |
| [RunaiContainerMemoryUsageWarning](RunaiContainerMemoryUsageWarning.md)                                                                                |
| [RunaiContainerRestarting](RunaiContainerRestarting.md)                                                                                                |
| [RunaiCpuUsageWarning](RunaiCpuUsageWarning.md)                                                                                                        |
| [RunaiCriticalProblem](RunaiCriticalProblem.md)                                                                                                        |
| [RunaiDaemonSetRolloutStuck](RunaiDaemonSetRolloutStuck.md)                                                                                            |
| [RunaiDaemonSetUnavailableOnNodes](RunaiDaemonSetUnavailableOnNodes.md)                                                                                |
| [RunaiDeploymentInsufficientReplicas](RunaiDeploymentInsufficientReplicas.md)                                                                          |
| [RunaiDeploymentNoAvailableReplicas](RunaiDeploymentNoAvailableReplicas.md)                                                                            |
| [RunaiDeploymentUnavailableReplicas](RunaiDeploymentUnavailableReplicas.md)                                                                            |
| [RunaiProjectControllerReconcileFailure](RunaiProjectControllerReconcileFailure.md)                                                                    |
| [RunaiStatefulSetInsufficientReplicas](RunaiStatefulSetInsufficientReplicas.md)                                                                        |
| [RunaiStatefulSetNoAvailableReplicas](RunaiStatefulSetNoAvailableReplicas.md)                                                                          |
