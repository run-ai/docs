# Support for other Kubernetes Applications

## Introduction

Kubernetes has several built-in resources that encapsulate running _Pods_. These are called [Kubernetes Workloads](https://kubernetes.io/docs/concepts/workloads/){target=_blank} and __should not be confused__ with [Run:ai Workloads](workload-overview-dev.md). 

Examples of such resources are a _Deployment_ that manages a stateless application, or a _Job_ that runs tasks to completion. 

Run:ai natively runs [Run:ai Workloads](workload-overview-dev.md). A Run:ai workload encapsulates all the resources needed to run, creates them, and deletes them together. However, Run:ai, being an __open platform__ allows the scheduling of __any__ Kubernetes Workflow.

## How To

To run Kubernetes Workloads with Run:ai you must add the following to the YAML:

* A namespace that is associated with a Run:ai Project.
* A scheduler name: `runai-scheduler`.
* When using Fractions, use a specific syntax for the `nvidia/gpu` limit.

## Example: Job

``` YAML title="job1.yaml"
apiVersion: batch/v1
kind: Job # (1)
metadata:
  name: job1
  namespace: runai-team-a # (2)
spec:
  template:
    spec:
      containers:
      - name: job1-container
        image: gcr.io/run-ai-demo/quickstart
        resources:
          limits:
            nvidia.com/gpu: 1 # (4)
      restartPolicy: Never
      schedulerName: runai-scheduler # (3)
```

1. This is a Kubernetes _Job_.
2. Namespace: Replace `runai-team-a` with the name of the Run:ai namespace for the specific Project (typically `runai-<Project-Name>`).
3. The job to be scheduled with the Run:ai scheduler. 
4. To run with half a GPU replace 1 with "0.5" (with apostrophes).

To submit the Job run:

```
kubectl apply -f job1.yaml
```

You will be able to see the Job in the Run:ai User interface, including all metrics and lists 

## Example: Deployment

``` YAML title="deployment1.yaml"
apiVersion: apps/v1
kind: Deployment # (1)
metadata:
  name: inference-1
  namespace: runai-team-a # (2)
spec:
  replicas: 1
  selector:
    matchLabels:
      app: inference-1
  template:
    metadata:
      labels:
        app: inference-1
    spec:
      containers:
        - resources:
            limits:
              nvidia.com/gpu: 1 # (4)
          image: runai/example-marian-server
          imagePullPolicy: Always
          name: inference-1
          ports:
            - containerPort: 8888
      schedulerName: runai-scheduler # (3)

---
apiVersion: v1
kind: Service # (5)
metadata:
  labels:
    app: inference-1
  name: inference-1
spec:
  type: ClusterIP
  ports:
    - port: 8888
      targetPort: 8888
  selector:
    app: inference-1

```

1. This is a Kubernetes _Deployment_.
2. Namespace: Replace `runai-team-a` with the name of the Run:ai namespace for the specific Project (typically `runai-<Project-Name>`).
3. The job to be scheduled with the Run:ai scheduler. 
4. To run with half a GPU replace 1 with "0.5" (with apostrophes).
5. This example also contains the creation of a service to connect to the deployment. It is not mandatory.   

To submit the Deployment run:

```
kubectl apply -f deployment1.yaml
```


## Limitations

The Run:ai command line interface provides limited support for Kubernetes Workloads.


## See Also
Run:ai has specific integrations with additional third-party tools such as [KubeFlow](../../admin/integration/kubeflow.md), [MLFlow](../../admin/integration/mlflow.md), and more. These integrations use the same instructions as described above. 
