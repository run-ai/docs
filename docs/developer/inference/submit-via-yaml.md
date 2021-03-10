# Submit an inference Job using YAML



## Submit Workloads


### Regular Inference Jobs

* ``<JOB-NAME>``. The name of the Job.

* ``<IMAGE-NAME>``. The name of the docker image to use. Example: ``gcr.io/run-ai-demo/quickstart``

* ``<USER-NAME>`` The name of the user submitting the Job. The name is used for display purposes only when Run:AI is installed in an [unauthenticated mode](../../Administrator/Cluster-Setup/researcher-authentication.md).

* ``<REQUESTED-GPUs>``. An integer number of GPUs you request to be allocated for the Job. Examples: 1, 2

Copy the following into a file and change the parameters:
Notice that this example contains a service creation as well. It is not a must, but for most inference cases the service will be created as well.  

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: <JOB-NAME>
spec:
  replicas: 1
  selector:
    matchLabels:
      app: <JOB-NAME>
  template:
    metadata:
      labels:
        app: inference
      annotations:
        gpu-fraction: 1
        user: <USER-NAME>
    spec:
      schedulerName: runai-scheduler
      containers:
        - image: <IMAGE-NAME>
          name: <JOB-NAME>
          ports:
            - containerPort: <TARGET-PORT>
          resources:
            limits:
              nvidia.com/gpu: <REQUESTED-GPUs>
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app:  <JOB-NAME>
  name:  <JOB-NAME>
spec:
  type: NodePort
  ports:
    - port: <PORT>
      targetPort: <TARGET-PORT>
  selector:
    app: <JOB-NAME>
```


To submit the job, run:

```
kubectl apply -f <FILE-NAME>
```


Jobs with Fractions requires a change in the above YAML. Specifically, the limits section:


``` yaml
limits:
  nvidia.com/gpu: <REQUESTED-GPUs>
```

should be omitted and replaced with:

``` yaml
spec:
  template: 
    metadata:
      annotations:
        gpu-fraction: "0.5"
``` 

Jobs with MPS enabled requires a change in the above YAML. Specifically, the limits section:
should be omitted and replaced with:

``` yaml
spec:
  template: 
    metadata:
      annotations:
        mps: "true"
``` 

where "0.5" is the requested GPU fraction.


## Delete Workloads

To delete a Run:AI workload, delete the Job:

```
kubectl delete runaijob <JOB-NAME>
```
