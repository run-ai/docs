# Submit an inference Workload via YAML

Parameters:

* `<WORKLOAD-NAME>`. The name of the Workload. The name must comply with Kubernetes naming conventions for [DNS Label names](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#dns-label-names){target=_blank}. With fractional workloads, the name is limited to 18 characters. 
* `<IMAGE-NAME>`. The name of the docker image to use. Example: `gcr.io/run-ai-demo/quickstart-inference-marian`
* `<USER-NAME>` The name of the user submitting the Workload. The name is used for display purposes only when Run:ai is installed in an [unauthenticated mode](../../admin/runai-setup/authentication/researcher-authentication.md).
* `<REQUESTED-GPUs>`. An integer number of GPUs you request to be allocated for the Workload. Examples: 1, 2
* `<NAMESAPCE>` The name of the Project's namespace. This is usually `runai-<PROJECT-NAME>`


##  Submit Inference Workloads Allocating Full GPUs

Copy the following into a file while substituting the parameters:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: <WORKLOAD-NAME>
  namespace: <NAMESPACE>
spec:
  replicas: 1
  selector:
    matchLabels:
      app: <WORKLOAD-NAME>
  template:
    metadata:
      labels:
        app: <WORKLOAD-NAME>
      annotations:
        user: <USER-NAME>
    spec:
      schedulerName: runai-scheduler
      containers:
        - image: <IMAGE-NAME>
          name: <WORKLOAD-NAME>
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
    app:  <WORKLOAD-NAME>
  name:  <WORKLOAD-NAME>
spec:
  type: NodePort
  ports:
    - port: <TARGET-PORT>
      targetPort: <TARGET-PORT>
  selector:
    app: <WORKLOAD-NAME>
```

!!! Note
    This example also contains the creation of a service. The service is used to connect to the inference server. It is not mandatory, but for most inference cases the service will be needed as well.   

To submit the Workload, run:

```
kubectl apply -f <FILE-NAME>
```


##  Submit Inference Workloads Allocating Fractions of a GPU


Replace `<REQUESTED-GPUs>` with a fraction in quotes. e.g. 

``` yaml
limits:
  nvidia.com/gpu: "0.5"
```


## NVIDIA MPS

Workloads with NVIDIA MPS require a change in the above YAML. 

``` yaml
spec:
  template: 
    metadata:
      annotations:
        mps: "true"
``` 

!!! Important Note
    To use MPS, your administrator must first enable it. See the [setup](setup.md) document. 


## Delete Workloads

To delete a Run:ai Inference workload, delete the Workload:

```
kubectl delete runaijob <WORKLOAD-NAME>
```
