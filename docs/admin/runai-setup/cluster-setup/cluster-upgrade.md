
# Upgrading a Cluster Installation

## Find out Run:ai Cluster version 

To find the Run:ai cluster version before and after upgrade run:

```
helm list -n runai -f runai-cluster
```

and record the chart version in the form of `runai-cluster-<version-number>`

## Upgrade Run:ai cluster 
Run:

```
kubectl apply -f https://raw.githubusercontent.com/run-ai/public/main/runai-crds.yaml
helm repo update
helm get values runai-cluster -n runai > values.yaml
helm upgrade runai-cluster runai/runai-cluster -n runai -f values.yaml
```

### Upgrade from version 2.2 or older to version 2.3 or higher

Delete the cluster as described [here](cluster-delete.md) and perform cluster installation again.

### Upgrade from version 2.3 or older to version 2.4 or higher

1. Make sure you have no fractional jobs running. These are Jobs that have been assigned a _part_ of a GPU as described [here](../../../Researcher/scheduling/fractions.md).
2. Upgrade the cluster as described above.
3. Change NVIDIA Software installation as described below:

#### Using the GPU Operator
If you have previously installed the _NVIDIA GPU Operator_, previous instructions required a patch to the GPU Operator. You must patch the NDIVIA components back to the original state as follows:

=== "Kubernetes"
    ```
    kubectl -n gpu-operator-resources patch daemonset nvidia-device-plugin-daemonset \
    -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "false"}}}}}'
    kubectl -n gpu-operator-resources patch daemonset nvidia-dcgm-exporter \
    -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "false"}}}}}'
    ```
    
=== "OpenShift"
    ```
    oc scale --replicas=1 -n openshift-operators deployment gpu-operator
    ```
    <!-- oc -n gpu-operator-resources patch daemonset nvidia-dcgm-exporter \ -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "false"}}}}}' -->

#### Install on Each Node

An alternative method described in the past is to Install NVIDIA software on each node separately. This method is __less recommended__ but is documented in detail in the [NVIDIA documentation](https://docs.nvidia.com/datacenter/cloud-native/kubernetes/install-k8s.html#install-nvidia-dependencies){target=_blank}. If you have previously installed NVIDIA sofware on each node, you must now install the [NVIDIA GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#install-nvidia-gpu-operator){target=_blank} while taking into account the parts that are __already installed__ on your system. Specifically: the NVIDIA Drivers and the NVIDIA toolkit. Use the GPU Operator helm installation flags: `--set nfd.enabled=false --set driver.enabled=false --set toolkit.enabled=false --set migManager.enabled=false`.

(alternatively, and less recommended, is to forgo the GPU Operator alltogether and install the _NVIDIA Device Plugin_ and _NVIDIA GPU Telemetry_ as described in the [NVIDIA documentation](https://docs.nvidia.com/datacenter/cloud-native/kubernetes/install-k8s.html#install-nvidia-dependencies){target=_blank}).


## Verify successful installation

To verify that the upgrade has succeeded run:

```
kubectl get pods -n runai
```

Verify that all pods are running or completed.


