

# Setting Run:ai as the default scheduler per Project

## Introduction
Kubernetes has a default scheduler that makes decisions on where to place Kubernetes Pods. Run:ai has implemented a different scheduler called the `runai-scheduler`. By default, Run:ai uses its own scheduler

You can decide to use the Run:ai scheduler for other, non-Run:ai, workloads by adding the following to the workload's YAML file:

``` yaml
schedulerName: runai-scheduler
```

## Making Run:ai the default scheduler

There may be cases where you cannot change the YAML file but still want to use the Run:ai Scheduler to schedule those workloads. 

For such cases, another option is to configure the Run:ai Scheduler as the default scheduler __for a specific namespace__. This will now make any workload type that is submitted to that namespace (equivalent to a Run:ai Project) use the Run:ai scheduler. 

To configure this, add the following annotation to the namespace itself:

`runai/enforce-scheduler-name: true`

### Example

To annotate a project named `proj-a`, use the following command:
	
```bash
kubectl annotate ns runai-proj-a runai/enforce-scheduler-name=true
```

Verify the namespace in YAML format to see the annotation:

```bash
kubectl get ns runai-proj-a -o yaml
```

Output: 

```YAML
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    runai/enforce-scheduler-name: "true"
  creationTimestamp: "2024-04-09T08:15:50Z"
  labels:
    kubernetes.io/metadata.name: runai-proj-a
    runai/namespace-version: v2
    runai/queue: proj-a
  name: runai-proj-a
  resourceVersion: "388336"
  uid: c53af666-7989-43df-9804-42bf8965ce83
spec:
  finalizers:
  - kubernetes
status:
  phase: Active
```
