# Connect JupyterHub with Run:AI


## Overview

A [Jupyter Notebook](https://jupyter.org){target=_blank} is an open-source web application that allows you to create and share documents that contain live code. Uses include: data cleaning and transformation, numerical simulation, statistical modeling, data visualization, machine learning, and much more. Jupyter Notebooks are popular with Researchers as a way to code and run deep-learning code. 

[JupyterHub](https://jupyter.org/hub){target=_blank} JupyterHub makes it possible to serve a pre-configured data science environments.

This document explains how to set up JupyterHub to integrate with Run:AI such that Notebooks spawned via JuptyerHub will use resources scheduled by Run:AI

If you wish to connect to a __local__ Jupyter Notebook inside a container, see [Using a Jupyter Notebook within a Run:AI Job](../../Researcher/tools/dev-jupyter.md) 


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
* The example PV refers to `/srv/jupyterhub`

Then run:

```
kubectl apply -f pv-example.yaml 
```

!!!Note
    The JupyterHub installation will create a _PersistentVolumeClaim_ named `hub-db-dir` that should be referred to by any PV you create.

### Create a configuration file

Create a configuration file for JupyterHub. An example configuration file for Run:AI can be found in [https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/config.yaml](https://raw.githubusercontent.com/run-ai/docs/master/install/jupyterhub/config.yaml){target=_blank}. It contains 3 sample Run:AI configurations. 

* Download the file 
* Replace `<SECRET-TOKEN>` with a random number generated, by running `openssl rand -hex 32`

### Install

Run:

``` bash 
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
helm install jhub jupyterhub/jupyterhub -n jhub --values config.yaml
```

### Log on to the node and run `sudo chmod 777 -R /srv/jupyterhub`

### Verify Installation

Run: 

```
kubectl get pods -n jhub
```

Verify that all pods are running


## Access JupyterHub

Run:

```
kubectl get service -n jhub proxy-public
```

Use the `External IP` of the service to access the service.

Login with Run:AI Project name as user name.

## Troubleshooting the JupyterHub Installation

If the `External IP` of the proxy-public service is stuck on `pending`, it might mean that this service isn't configured with an `External IP` by default.

To check and fix this, lets see which pod is the proxy pod running on.

Run: 

```
kubectl get pods -n jhub -l component=proxy -o=jsonpath='{.items[0].spec.nodeName}{"\n"}'
```
This will print the node that the proxy pod is running on.
You will need to get both the internal and external IPs of this node for the next step. 

Now lets check the proxy-public service definition.

Run:

```
kubectl edit svc proxy-public -n jhub
```

You should see something like this:

```yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    meta.helm.sh/release-name: jhub
    meta.helm.sh/release-namespace: jhub
  creationTimestamp: "2021-04-25T09:15:26Z"
  labels:
    app: jupyterhub
    app.kubernetes.io/managed-by: Helm
    chart: jupyterhub-0.11.1
    component: proxy-public
    heritage: Helm
    release: jhub
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .: {}
          f:meta.helm.sh/release-name: {}
          f:meta.helm.sh/release-namespace: {}
        f:labels:
          .: {}
          f:app: {}
          f:app.kubernetes.io/managed-by: {}
          f:chart: {}
          f:component: {}
          f:heritage: {}
          f:release: {}
      f:spec:
        f:externalTrafficPolicy: {}
        f:ports:
          .: {}
          k:{"port":80,"protocol":"TCP"}:
            .: {}
            f:name: {}
            f:port: {}
            f:protocol: {}
            f:targetPort: {}
        f:selector:
          .: {}
          f:component: {}
          f:release: {}
        f:sessionAffinity: {}
        f:type: {}
    manager: Go-http-client
    operation: Update
    time: "2021-04-25T09:15:26Z"
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:spec:
        f:externalIPs: {}
    manager: kubectl-edit
    operation: Update
    time: "2021-04-25T10:34:41Z"
  name: proxy-public
  namespace: jhub
  resourceVersion: "17399"
  uid: 985b6973-1abb-4a45-9406-b7b7cc4e5601
spec:
  clusterIP: 10.108.102.132
  clusterIPs:
  - 10.108.102.132
  externalIPs:
  - 35.224.44.230
  - 10.8.0.9
  externalTrafficPolicy: Cluster
  ports:
  - name: http
    nodePort: 32679
    port: 80
    protocol: TCP
    targetPort: http
  selector:
    component: proxy
    release: jhub
  sessionAffinity: None
  type: LoadBalancer
status:
  loadBalancer: {}
```

If you don't see an externalIPs block under spec, you will need to add it there.
It should contain both the external and the internal IPs of the proxy pod, for example:

```yaml
externalIPs:
- 35.224.44.230
- 10.8.0.9
```

Once you add this to the YAML, save it and then try to access the JupyterHub UI by using the external IP from the previous step in your browser.

