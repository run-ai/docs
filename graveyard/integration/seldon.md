# Integrate Run:ai with Seldon Core

[Seldon Core](https://github.com/SeldonIO/seldon-core){target=_blank} is software that deploys machine learning models to production over Kubernetes. The purpose of this document is to explain how to use Seldon Core together with Run:ai.  

Of special importance, is the usage of Seldon together with the Run:ai [fractions](../../Researcher/Walkthroughs/walkthrough-fractions.md) technology: Machine learning production tends to take less GPU Memory. As such, allocating a fraction of the GPU per job allows for better GPU Utilization. 



## Prerequisites

Install Seldon Core as described [here](https://github.com/SeldonIO/seldon-core){target=_blank}. We recommend using the helm-based installation of both Seldon Core and Istio.


## Create a Seldon deployment

The instructions below follow a [sample machine learning model](https://github.com/SeldonIO/seldon-core/blob/master/examples/models/autoscaling/model_with_hpa.yaml){target=_blank} that tests the Run:ai - Seldon Core integration.  Save the following in a file named `<FILE-NAME>.yaml`

``` YAML
apiVersion: machinelearning.seldon.io/v1
kind: SeldonDeployment
metadata:
  name: seldon-model
  namespace: runai-<PROJECT-NAME>
spec:
  name: test-deployment
  predictors:
  - componentSpecs:
    - spec:
        containers:
        - name: classifier
          image: seldonio/mock_classifier:1.5.0-dev
          resources:
            limits:
              nvidia.com/gpu: <GPUs>
        schedulerName: runai-scheduler
    graph:
      children: []
      endpoint:
        type: REST
      name: classifier
      type: MODEL
    name: example
    replicas: 1
```


apiVersion: machinelearning.seldon.io/v1
kind: SeldonDeployment
metadata:
  name: seldon-model
  namespace: runai-<PROJECT-NAME>
spec:
  name: test-deployment
  predictors:
  - componentSpecs:
    - spec:
        containers:
        - name: classifier
          image: seldonio/mock_classifier:1.0
          resources:
            limits:
              nvidia.com/gpu: <GPUs>
        schedulerName: runai-scheduler
    graph:
      children: []
      endpoint:
        type: REST
      name: classifier
      type: MODEL
    name: example
    replicas: 1


Replace `<PROJECT-NAME>` with the Run:ai projects and `<GPUs>` with the amount of GPUs you want to allocate (e.g. 0.5 GPUs).

```
kubectl apply -f <FILE-NAME>.yaml
```

## Verification 

Run: `runai list jobs` and verify that the job is running

## Delete a deployment

Run: 

```
kubectl delete -f <FILE-NAME>.yaml
```

