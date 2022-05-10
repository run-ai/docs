# Inference Setup


!!! Warning
    Inference API is deprecated. See [Cluster API](../../cluster-api/workload-overview-dev.md) for its replacement.


Inference Jobs are an integral part of Run:ai and do not require setting up per se. However, Running multiple production-grade processes on a single GPU is best performed with an NVIDIA technology called _Multi-Process Service_ or _MPS_

By default, MPS is not enabled on GPU nodes.

## Enable MPS 

To enable the MPS server on all nodes, you must edit the cluster installation values file:

* When installing the Run:ai cluster, edit the [values file](/admin/runai-setup/cluster-setup/cluster-install/#step-3-install-runai).
* On an existing installation, use the [upgrade](/admin/runai-setup/cluster-setup/cluster-upgrade) cluster instructions to modify the values file.

Use:

```  yaml
runai-operator:
  config:
    mps-server:
      enabled: true
```


Wait for the MPS server to start running:

``` bash
 kubectl get pods -n runai
```

When the MPS server pod has started to run, restart the `nvidia-device-plugin` pods:

``` bash
kubectl rollout restart ds/nvidia-device-plugin-daemonset -n gpu-operator
```

To enable the MPS server on selected nodes, please contact Run:ai customer support.

## Verify MPS is Enabled

Run:

```
kubectl get pods -n runai --selector=app=runai-mps-server -o wide
```

* Verify that all mps-server pods are in `Running` state. 

* Submit a workload with MPS enabled using the [--mps](../../../Researcher/cli-reference/runai-submit.md#mps) flag.  Then run:

```
runai list
```

* Identify the node on which the workload is running. In the `get pods` command above find the pod __running on the same node__ and then run: 

```
kubectl logs -n runai runai-mps-server-<name> -f
```

You should see activity in the log 



