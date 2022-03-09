
An OpenShift installation of Run:AI has third-party dependencies that must be pre-installed before installing Run:AI itself. The following document provides instructions for installing and configuring these dependencies.

!!! Note
    You must have Cluster Administrator rights to install these dependencies. 

## Install Operators 

NVIDIA provided [detailed documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/openshift/contents.html){target=_blank} on how to install the required Operators so as to suppport GPUs on OpenShift. 

## Disable the NVIDIA Device Plugin and DCGM Exporter

Verify that the GPU Operator is installed by running:

```
oc get pods -n gpu-operator-resources
```

__After successful verification__, 

(1) Disabled the GPU Operator by running:

```
oc scale --replicas=0 -n openshift-operators deployment gpu-operator
```

(1) Disable the NVIDIA DCGM exporter by running:

```
oc -n gpu-operator patch daemonset nvidia-dcgm-exporter \
   -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
```

(2) Replace the NVIDIA Device Plug-in with the Run:AI version:

```
oc patch daemonsets.apps -n gpu-operator nvidia-device-plugin-daemonset \
   -p '{"spec":{"template":{"spec":{"containers":[{"name":"nvidia-device-plugin-ctr","image":"gcr.io/run-ai-prod/nvidia-device-plugin:1.0.11"}]}}}}'
oc create clusterrolebinding --clusterrole=admin \
  --serviceaccount=gpu-operator:nvidia-device-plugin nvidia-device-plugin-crb
```
<!-- oc -n gpu-operator-resources patch daemonset nvidia-device-plugin-daemonset \
  -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}' -->


## Next Steps

Continue with installing the [Run:AI Backend](backend.md).
