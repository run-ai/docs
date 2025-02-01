# Support for other Kubernetes Applications

## Introduction

Kubernetes has several built-in resources that encapsulate running *Pods*. These are called [Kubernetes Workloads](https://kubernetes.io/docs/concepts/workloads/){target=_blank} and **should not be confused** with [Run:ai Workloads](workload-overview-dev.md).

Examples of such resources are a *Deployment* that manages a stateless application, or a *Job* that runs tasks to completion.

Run:ai natively runs [Run:ai Workloads](workload-overview-dev.md). A Run:ai workload encapsulates all the resources needed to run, creates them, and deletes them together. However, Run:ai, being an **open platform** allows the scheduling of **any** Kubernetes Workflow.

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
        image: runai.jfrog.io/demo/quickstart
        resources:
          limits:
            nvidia.com/gpu: 1 # (4)
      restartPolicy: Never
      schedulerName: runai-scheduler # (3)
```

1. This is a Kubernetes *Job*.
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

1. This is a Kubernetes *Deployment*.
2. Namespace: Replace `runai-team-a` with the name of the Run:ai namespace for the specific Project (typically `runai-<Project-Name>`).
3. The job to be scheduled with the Run:ai scheduler.
4. To run with half a GPU replace 1 with "0.5" (with apostrophes).
5. This example also contains the creation of a service to connect to the deployment. It is not mandatory.

To submit the Deployment run:

```
kubectl apply -f deployment1.yaml
```


## Example: Submit a Cron job via YAML

The cron command-line utility is a job scheduler typically used to set up and maintain software environments at scheduled intervals. Run:ai now supports submitting jobs with cron using a YAML file. 

To submit a job using cron, run the following command:

```console
kubectl apply -f <file_name>.yaml
```

The following is an example YAML file:

```YAML
apiVersion: batch/v1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "* * * * *"
  jobTemplate:
    spec:
      template:
        metadata:
          labels:
          - (Mandatory) runai/queue: team-a
        spec:
          (Mandatory) schedulerName: runai-scheduler
          containers:
          - name: hello
            image: busybox:1.28
            imagePullPolicy: IfNotPresent
            command:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
          (Optional) priorityClassName: build / train / inference / interactivePreemptible
```


## Limitations

The Run:ai command line interface provides limited support for Kubernetes Workloads.

## See Also
Run:ai has specific integrations with additional third-party tools such as [KubeFlow](https://runai.my.site.com/community/s/article/How-to-integrate-Run-ai-with-Kubeflow){target=_blank}, [MLFlow](https://runai.my.site.com/community/s/article/How-to-integrate-Run-ai-with-MLflow){target=_blank}, and more. These integrations use the same instructions as described above.
