
An OpenShift installation of Run:AI has third-party dependencies that must be pre-installed before installing Run:AI itself. The following document provides instructions for installing and configuring these dependencies.

!!! Note
    You must have Cluster Administrator rights to install these dependencies. 

## Install Operators 

[NVIDIA](https://docs.nvidia.com/datacenter/kubernetes/openshift-on-gpu-install-guide/index.html#openshift-gpu-support){target=_blank} describes two methods to install the two operators:

* Via [Operator Hub](https://docs.nvidia.com/datacenter/kubernetes/openshift-on-gpu-install-guide/index.html#openshift-gpu-support-install-via-operatorhub){target=_blank}. Use these instructions when you can download from the internet (Fully on Premise). 
* Via [Helm chart](https://docs.nvidia.com/datacenter/kubernetes/openshift-on-gpu-install-guide/index.html#openshift-gpu-support-install-helm){target=_blank}. Use these in an air-gapped environment.


## Disable the NVIDIA Device Plugin

Verify that the GPU Operator is installed by running:

```
kubectl get pods -n gpu-operator-resources
```

__After successful verification__, disable the NVIDIA Device Plugin (The [Run:AI Cluster installation](cluster.md) installs a custom version) by running:

```
kubectl -n gpu-operator-resources patch daemonset nvidia-device-plugin-daemonset \
  -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
```

## Prometheus

Run:AI uses the __Prometheus Operator__ built into OpenShift 

* Add label to the runai namespace:

```
kubectl label ns runai openshift.io/cluster-monitoring=true
```

* Apply the Run:AI Prometheus customizations by running:

=== "Airgapped"
    ```
    kubectl apply -f installation-files/backend/ocp-prom-custom.yaml
    ```

=== "Connected"
    ```
    kubectl apply -f https://raw.githubusercontent.com/run-ai/docs/master/install/backend/ocp-prom-custom.yaml
    ```

## Next Steps

Continue with installing the [Run:AI Backend](backend.md).