# Connect JupyterHub with Run:ai


## Overview

A [Jupyter Notebook](https://jupyter.org){target=_blank} is an open-source web application that allows you to create and share documents that contain live code. Uses include data cleaning and transformation, numerical simulation, statistical modeling, data visualization, machine learning, and much more. Jupyter Notebooks are popular with Researchers as a way to code and run deep-learning code. A Jupyter Notebook __runs inside the user container__. For more information, see [Using a Jupyter Notebook within a Run:ai Job](../../Researcher/tools/dev-jupyter.md).

[JupyterHub](https://jupyter.org/hub){target=_blank} is a __separate service__ that makes it possible to serve pre-configured data science environments. 

This document explains how to set up JupyterHub to integrate with Run:ai such that Notebooks spawned via JuptyerHub will use resources scheduled by Run:ai.


## Installing JupyterHub

This document follows the JupyterHub [installation documentation](https://zero-to-jupyterhub.readthedocs.io/en/stable/jupyterhub/installation.html){target=_blank}

### Create a namespace

Run:

```
kubectl create namespace jhub
```

### Provide access roles

```
kubectl apply -f https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/jhubroles.yaml
```

### Create storage

JupyterHub requires storage in the form of a PersistentVolume (PV). For __an example__ of a _local_ PV:

* Download [https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/pv-example.yaml](https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/pv-example.yaml){target=_blank} 
* Replace `<NODE-NAME>` with one of your worker nodes. 
* The example PV refers to `/srv/jupyterhub`. Log on to `<NODE-NAME>` and create the folder and run `sudo chmod 777 -R /srv/jupyterhub`


Then run:

```
kubectl apply -f pv-example.yaml 
```

!!!Note
    The JupyterHub installation will create a _PersistentVolumeClaim_ named `hub-db-dir` that should be referred to by any PV you create.

### Create a configuration file

Create a configuration file for JupyterHub. An example configuration file for Run:ai can be found in [https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/config.yaml](https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/config.yaml){target=_blank}. It contains 3 sample Run:ai configurations. 

* Download the file 
* Replace `<SECRET-TOKEN>` with a random number generated, by running `openssl rand -hex 32`

### Install

Run:

``` bash 
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
helm install jhub jupyterhub/jupyterhub -n jhub  --version=0.11.1 --values config.yaml
```



### Verify Installation

Run: 

```
kubectl get pods -n jhub
```

Verify that all pods are running


## Access JupyterHub

Run:

``` bash
kubectl get service -n jhub proxy-public
```

Use the `External IP` of the service to access the service.

Login with Run:ai Project name as user name.

## Troubleshooting the JupyterHub Installation

If the `External IP` of the proxy-public service remains in the `Pending` status, it might mean that this service is not configured with an `External IP` by default.

To fix, find out which pod is the proxy pod running on.

Run: 

``` bash
kubectl get pods -n jhub -l component=proxy -o=jsonpath='{.items[0].spec.nodeName}{"\n"}'
```

This will print the node that the proxy pod is running on.
You will need to get both the internal and external IPs of this node for the next step. 

Now, let's check the proxy-public service definition. Run:

``` bash
kubectl edit svc proxy-public -n jhub
```

Under `spec` You should see a section `externalIPs`. If it does not exist, you must add it there. The section must contain both the external and the internal IPs of the proxy pod, for example:

```yaml
spec:
  externalIPs:
  - 35.224.44.230
  - 10.8.0.9
```

Save the file and then try to access JupyterHub by using the external IP from the previous step in your browser.


!!! Caution
    Jupyter hub integration does not currently work properly when the Run:ai Project name includes a hyphen ('-'). We are working to fix that. 
