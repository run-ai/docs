# Support for other Kubernetes Applications

Kubernetes has several built-in resources, which encapsulate running Pods on the cluster. These are called [Kubernetes Workloads](https://kubernetes.io/docs/concepts/workloads/){target=_blank} and should not be confused with Run:ai Workloads. 

Examples of such resources are _Deployment_ which manages a stateless application, or _Job_ that run tasks to completion. 

Run:ai natively runs [Run:ai Workloads](workload-overview-dev.md). A Run:ai workload encapsulates all the resources needed to run, creates them, and deletes them together. However, Run:ai, being an __open platform__ allows the scheduling of any __Kubernetes Workflow__. 