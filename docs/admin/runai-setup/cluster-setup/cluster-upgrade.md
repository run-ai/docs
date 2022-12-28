
# Upgrading a Cluster Installation

## Find out Run:ai Cluster version 

To find the Run:ai cluster version before and after upgrade run:

```
helm list -n runai -f runai-cluster
```

and record the chart version in the form of `runai-cluster-<version-number>`

## Upgrade Run:ai cluster 

Replace `<version>` with the new version number in the command below. Then run: 

```
kubectl apply -f https://raw.githubusercontent.com/run-ai/public/main/<version>/runai-crds.yaml
```
The number should have 3 digits (for example `2.7.14`). You can find Run:ai version numbers by running `helm search repo -l runai-cluster`.

Then run:

```
helm repo update
helm get values runai-cluster -n runai > values.yaml
helm upgrade runai-cluster runai/runai-cluster -n runai -f values.yaml
```


### Upgrade from version 2.3 or older to version 2.4 or higher

!!! Note
    We recommend working with Run:ai support to perform this upgrade during planned downtime.

1. Make sure you have no fractional jobs running. These are Jobs that have been assigned a _part_ of a GPU as described [here](../../../Researcher/scheduling/fractions.md).
2. Upgrade the cluster as described above.
3. Change NVIDIA Software installation as described below:

=== "Previous install of the GPU Operator"
    If you have previously installed the _NVIDIA GPU Operator_, we recommend uninstalling the Operator and installing it again. Use NVIDIA Operator version 1.9 or higher. 

=== "Previous install of NVIDIA software on Each Node"
    An alternative method described in the past is to install NVIDIA software __on each node separately__. This method is documented by NVIDIA [here](https://docs.nvidia.com/datacenter/cloud-native/kubernetes/install-k8s.html#install-nvidia-dependencies){target=_blank} and is __no longer recommended__ for Run:ai.

    If used, to upgrade Run:ai, you must now install the [NVIDIA GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#install-nvidia-gpu-operator){target=_blank} version 1.9 or higher, while taking into account the parts that are __already installed__ on your system (typically the NVIDIA Drivers and the NVIDIA toolkit). Use the GPU Operator flags: `--set driver.enabled=false.
    <!-- 
    (alternatively, and less recommended, is to forgo the GPU Operator altogether and install the _NVIDIA Device Plugin_ and _NVIDIA GPU Telemetry_ as described in the [NVIDIA documentation](https://docs.nvidia.com/datacenter/cloud-native/kubernetes/install-k8s.html#install-nvidia-dependencies){target=_blank}). -->

    After the installation/upgrade of both gpu-operator and runai-cluster, run:
    `kubectl rollout restart ds nvidia-device-plugin-daemonset -n gpu-operator`

## Upgrade to a Specific Verison

To upgrade to a specific version, add `--version <version-number>` to the `helm upgrade` command. 

## Verify Successful Installation

To verify that the upgrade has succeeded run:

```
kubectl get pods -n runai
```

Verify that all pods are running or completed.


