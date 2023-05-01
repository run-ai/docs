# Understand the Kubernetes Cluster Access provided to Run:ai

Run:ai has configuration flags that control specific behavioral aspects of Run:ai. Specifically, those which require additional permissions. Such as automatic namespace/project creation, secret propagation, and more.

The purpose of this document is to provide security officers with the ability to review what cluster-wide access Run:ai requires, and verify that it is in line with organizational policy, before installing the Run:ai cluster. 


## Review Cluster Access Roles

Run the folloinwg:

```
helm repo add runai https://run-ai-charts.storage.googleapis.com
helm repo update
helm install runai-cluster runai/runai-cluster -n runai -f runai-<cluster-name>.yaml \
        --dry-run > cluster-all.yaml
```

The file `cluster-all.yaml` can be then be reviewed. You can use the internal filenames (provided in comments within the file) to gain more understanding according to the table below:

|   Folder    | File  |  Purpose | 
|-------------|-------|----------|
| `clusterroles` | `base.yaml` | Mandatory Kubernetes _Cluster Roles_ and _Cluster Role Bindings_  |
| `clusterroles` |`project-controller-ns-creation.yaml` | Automatic Project Creation and Maintenance. Provides Run:ai with the ability to create Kubernetes namespaces when the Run:ai administrator creates new Projects. Can be turned on/off via [flag](../cluster-setup/customize-cluster-install.md) |  
| `clusterroles` |`project-controller-rb-creation.yaml` | Automatically assign Users to Projects. Can be turned on/off via [flag](../cluster-setup/customize-cluster-install.md) |  
| `clusterroles` | `project-controller-cluster-wide-secrets.yaml` | Allow the propagation of Secrets. See [Secrets in Jobs](../../workloads/secrets.md). Can be turned on/off via [flag](../cluster-setup/customize-cluster-install.md) | 
| `clusterroles` | `project-controller-limit-range.yaml` | Disables the usage of the Kubernetes [Limit Range](https://kubernetes.io/docs/concepts/policy/limit-range/#:~:text=A%20LimitRange%20is%20a%20policy,per%20PersistentVolumeClaim%20in%20a%20namespace){target=_blank} feature. Can be turned on/off via [flag](../cluster-setup/customize-cluster-install.md) |
| `ocp` | `scc.yaml`| OpenShift-specific Security Contexts | 
| `priorityclasses` | 4 files |  Folder contains a list of _Priority Classes_ used by Run:ai | 
