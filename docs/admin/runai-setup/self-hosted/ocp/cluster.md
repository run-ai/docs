---
title: Self Hosted installation over OpenShift - Cluster Setup
---

## Monitoring Pre-check 

Run:ai uses the OpenShift monitoring stack. As such, it requires creating or changing the OpenShift monitoring configuration. Check if a `configmap` already exists: 

```
oc get configmap cluster-monitoring-config -n openshift-monitoring
```

If it does,

1. To the cluster values file, add the flag `createOpenshiftMonitoringConfig` as described under `Cluster Installation` below. 
2. Post-installation, edit the `configmap` by running: `oc edit configmap cluster-monitoring-config -n openshift-monitoring`. Add the following:

``` YAML 
apiVersion: v1
kind: ConfigMap
metadata:
  name: cluster-monitoring-config
  namespace: openshift-monitoring
data:
  config.yaml: |
    prometheusK8s:
      scrapeInterval: "10s"
      evaluationInterval: "10s"
      externalLabels:
        clusterId: <CLUSTER_ID>
        prometheus: ""
        prometheus_replica: ""
```
For `<CLUSTER_ID>` use the `Cluster UUID` field as shown in the Run:ai user interface under the `Clusters` area.  

## Cluster Installation

* Perform the cluster installation instructions explained [here](../../../cluster-setup/cluster-install/#step-3-install-runai). When creating a new cluster on step 3, select __OpenShift__ as the target platform.
* __(Optional)__ make the following changes to the configuration file you have downloaded:


|  Key     |  Change  | Description |
|----------|----------|-------------| 
| `createOpenshiftMonitoringConfig` | false | see Monitoring Pre-check above. | 
| `runai-operator.config.project-controller.createNamespaces` |  `true` | Set to `false` if unwilling to provide Run:ai the ability to create namespaces, or would want to create namespaces manually rather than use the Run:ai convention of `runai-<PROJECT-NAME>`. When set to `false`, will require an additional [manual step](project-management.md) when creating new Run:ai Projects. | 
| `runai-operator.config.mps-server.enabled` | Default is `false` | Allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads. Requires [extra permissions](../preparations/#cluster-installation) | 
| `runai-operator.config.runai-container-toolkit.enabled` | Default is `true` | Controls the usage of __Fractions__. Requires [extra permissions](../preparations/#cluster-installation) | 
| `runai-operator.config.runaiBackend.password` | Default password already set  | admin@run.ai password. Need to change only if you have changed the password [here](../backend/#other-changes-to-perform) | 
| `runai-operator.config.global.prometheusService.address` | The address of the default Prometheus Service | If you installed your own custom Prometheus Service, change to its' address |


<!-- | `runai-operator.config.project-controller.createRoleBindings` |  `true` | Automatically assign Users to Projects. Set to `false` if unwilling to provide Run:ai the ability to set _RoleBinding_. When set to `false`, will require an additional [manual step](project-management.md) when adding or removing users from Projects.  |  -->


<!-- 
admission-controller:
  args:
    runaiFractionalMinAllocationEnforcementBytes: 1000000  
-->

Run:


=== "Connected"
    Follow the instructions on the Cluster Wizard
    
    !!! Info
        To install a specific version, add `--version <version>` to the install command.


=== "Airgapped"
    ```
    oc label ns runai openshift.io/cluster-monitoring=true
    oc -n openshift-ingress-operator patch ingresscontroller/default --patch '{"spec":{"routeAdmission":{"namespaceOwnership":"InterNamespaceAllowed"}}}' --type=merge

    helm install runai-cluster -n runai  \ 
      runai-cluster-<version>.tgz -f runai-<cluster-name>.yaml  
    ```

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. For more details see [Understanding cluster](../../../config/access-roles/) access roles](../../../config/access-roles/).


### Connect Run:ai to GPU Operator

Locate the name of the GPU operator namespace and run:

```
kubectl patch RunaiConfig runai -n runai -p '{"spec": {"global": {"nvidiaDcgmExporter": {"namespace": "INSERT_NAMESPACE_HERE"}}}}' --type="merge"
```

### (Optional) Prometheus Adapter 
The Prometheus adapter is required if you are using Inference workloads and require a custom metric for autoscaling. The following additional steps are required for it to work:

1. Copy `prometheus-adapter-prometheus-config` and `serving-certs-ca-bundle` ConfigMaps from `openshift-monitoring` namespace to the `monitoring` namespace
```
kubectl get cm prometheus-adapter-prometheus-config --namespace=openshift-monitoring -o yaml \
  | sed 's/namespace: openshift-monitoring/namespace: monitoring/' \
  | kubectl create -f -
kubectl get cm serving-certs-ca-bundle --namespace=openshift-monitoring -o yaml \
  | sed 's/namespace: openshift-monitoring/namespace: monitoring/' \
  | kubectl create -f -
```
2. Allow Prometheus Adapter `serviceaccount` to create a `SecurityContext` with RunAsUser 10001:
```
oc adm policy add-scc-to-user anyuid system:serviceaccount:monitoring:runai-cluster-prometheus-adapter
```





## Next Steps

Continue to [create Run:ai Projects](project-management.md).
