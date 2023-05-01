# Integrate Run:ai with ClearML

[ClearML](https://clear.ml/){target=_blank} is an open-source and commercial platform to manage the ML lifecycle. The purpose of this document is to explain how to run Jobs with MLflow using the Run:ai scheduler. 

## Overview 

ClearML concepts are discussed [here](https://clear.ml/docs/latest/docs/){target=_blank}. Specifically see ClearML Kubernetes architecture.


## Terminology

* Run:ai uses _Projects_. A Project is assigned to users and contains information such as quota, affinity, and more. A Run:ai Project is implemented as a Kubernetes namespace. 
* ClearML allows the Researcher to run _Experiments_. Experiment is equivalent to a Run:ai Job. A ClearML Experiment is sent to a ClearML _Queue_ for execution. 
* ClearML execute _Agents_. An agent runs on a Kubernetes namespace. An Agent is configured to watch a Queue. The Agent fetches an experiment from the queue for execution within the Kubernetes namespace.

## Step by Step Instructions


### Prerequisites

* A working Run:ai cluster.
* Install ClearML via [ClearML helm charts](https://github.com/allegroai/clearml-helm-charts){target=_blank}. Once ClearML is installed, verify that the installation is working by running:

```
kubectl get pod -n clearml
```

See that all pods are up. 



### Preparations

To prepare a Run:ai Project and a ClearML Queue do the following:

* In ClearML, create a queue named `runai-clearml`.
* In Run:ai, create a project named `clearml`. This will create a namespace called `runai-clearml`
* Associate the queue and the project by running:

``` bash
kubectl get role -n clearml k8sagent-pods-access -ojson | jq '.metadata.namespace="runai-clearml"' | jq 'del(.metadata.uid)' | jq 'del(.metadata.resourceVersion)' | jq 'del(.metadata.creationTimestamp)' | kubectl create -f -
kubectl get rolebinding -n clearml k8sagent-pods-access -ojson | jq '.metadata.namespace="runai-clearml"' | jq 'del(.metadata.uid)' | jq 'del(.metadata.resourceVersion)' | jq 'del(.metadata.creationTimestamp)' | kubectl create -f -
kubectl get secret -n clearml clearml-conf -ojson | jq '.metadata.namespace="runai-clearml"' | jq 'del(.metadata.uid)' | jq 'del(.metadata.resourceVersion)' | jq 'del(.metadata.creationTimestamp)' | kubectl create -f -
kubectl get configmap -n clearml k8sagent-pod-template -ojson | sed 's@tolerations:\\n    {}@tolerations:\\n    []@g' | jq '.metadata.namespace="runai-clearml"' | jq 'del(.metadata.uid)' | jq 'del(.metadata.resourceVersion)' | jq 'del(.metadata.creationTimestamp)' | jq '.data["template.yaml"]=(.data["template.yaml"] + "  schedulerName: runai-scheduler")' | kubectl create -f -
kubectl get deployment -n clearml clearml-k8sagent -ojson | sed 's/clearml-apiserver/clearml-apiserver.clearml.svc.cluster.local/; s/clearml-webserver/clearml-webserver.clearml.svc.cluster.local/; s/clearml-fileserver/clearml-fileserver.clearml.svc.cluster.local/; s@--template-yaml /root/template/template.yaml@--template-yaml /root/template/template.yaml --namespace runai-clearml@; s/k8s-agent/runai-k8s-agent/; s/aws-instances/runai-clearml/' | jq 'del(.status)' | jq 'del(.metadata.creationTimestamp)' | jq 'del(.metadata.generation)' | jq 'del(.metadata.uid)' | jq 'del(.metadata.resourceVersion)' | jq '.metadata.namespace="runai-clearml"' | kubectl create -f -
```

!!! Note
    The script is hardcoded for the above queue name and Run:ai Project name. You can change the script accordingly.

Validate that the Queue and the Project are connected by running:

```
kubectl get pod -n runai-clearml
```

You should see a ClearML agent running inside the Run:ai namespace. 


### Running an Experiment

* Using the ClearML interface create an experiment and enqueue it to the `runai-clearml` queue.
* Go to the Run:ai user interface. Under `Jobs` see that the job was created. 

