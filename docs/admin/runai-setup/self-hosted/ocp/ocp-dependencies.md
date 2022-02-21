
An OpenShift installation of Run:AI has third-party dependencies that must be pre-installed before installing Run:AI itself. The following document provides instructions for installing and configuring these dependencies.

!!! Note
    You must have Cluster Administrator rights to install these dependencies. 

## Install Operators 

NVIDIA provided [detailed documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/openshift/contents.html){target=_blank} on how to install the required Operators so as to suppport GPUs on OpenShift. 

After installing, verify that the GPU Operator is installed by running:

```
oc get pods -n gpu-operator-resources
```


## Next Steps

Continue with installing the [Run:AI Backend](backend.md).
