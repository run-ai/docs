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

JupyterHub requires storage in the form of a PersistentVolume (PV). For __an example__ of a _local_ PV, download [https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/pv-example.yaml](https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/pv-example.yaml){target=_blank} and replace <NODE-NAME> with one of your worker nodes. Then run:

```
kubectl apply -f pv-example.yaml 
```

Create a configuration file for JupyterHub. An example configuration file for Run:AI can be found in [https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/config.yaml](https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/config.yaml){target=_blank}. It contains 3 JupyterHub configuration. 

For documentation on JupyterHub configuration see XXX

Run:

``` bash 
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
helm install jhub jupyterhub/jupyterhub -n jhub --values https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/config.yaml
```

## Access JupyterHub

Run:

```
kubectl get service -n jhub proxy-public
```

Use the `External IP` of the service to access the service

XXX If there's no LoadBalancer in the cluster and the service was not given an external IP, edit the service and add the externalIPs of the machine manually.


## Configure Profiles

XXX For every jupyterhub user create a runai project with the user-name
