# Connect JupyterHub with Run:AI


## Overview

A [Jupyter Notebook](https://jupyter.org){target=_blank} is an open-source web application that allows you to create and share documents that contain live code. Uses include: data cleaning and transformation, numerical simulation, statistical modeling, data visualization, machine learning, and much more. Jupyter Notebooks are popular with Researchers as a way to code and run deep-learning code. 

[JupyterHub](https://jupyter.org/hub){target=_blank} JupyterHub makes it possible to serve a pre-configured data science environments.

This document explains how to set up JupyterHub to integrate with Run:AI such that Notebooks spawned via JuptyerHub will use resources scheduled by Run:AI

If you wish to connect to a __local__ Jupyter Notebook inside a container, see [Using a Jupyter Notebook within a Run:AI Job](../../Researcher/tools/dev-jupyter.md) 


## Installing JupyterHub

Create a namespace, by running:

```
kubectl create namespace jhub
```

Provide access roles:

```
kubectl apply -f https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/jhubroles.yaml
```

JupyterHub requires storage in the form of a PersistentVolume (PV). The following is just __an example__ of a _local_ PV. Replace <NODE-NAME> with one of your worker nodes:

``` YAML
apiVersion: v1
kind: PersistentVolume
metadata:
  name: hub-db-pv
  labels:
    type: local
spec:
  storageClassName: manual
  accessModes:
  - ReadWriteOnce
  capacity:
    storage: 5Gi
  claimRef:
    namespace: jhub
    name: hub-db-dir
  hostPath:
    path: "/srv/jupyterhub"
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - <NODE-NAME>
  persistentVolumeReclaimPolicy: Retain
  volumeMode: Filesystem
```

Place the above into a file name pv-example.yaml and run:

```
kubectl apply -f pv-example.yaml 
```

Run:

``` bash 
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
helm install jhub jupyterhub/jupyterhub -n jhub --values config.yaml
```

## Access JupyterHub

Run:

```
kubectl get service -n jhub proxy-public
```

Use the `External IP` of the service to access the service

xxx If there's no LoadBalancer in the cluster and the service was not given an external IP, edit the service and add the externalIPs of the machine manually.


## Configure Profiles

xxx For every jupyterhub user create a runai project with the user-name
