# Understanding Cluster Access Roles

Run:AI has the ability to work under restrictive Kubernetes environments. Namely:

* Kubernetes [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank}
* OpenShift

You can enable these restricted environment by setting the `pspEnabled` or `openshift` configuration [flags](../customize-cluster-install/#configuration-flags) in the Helm values file before installing the Run:AI cluster. 

Other configuration flags are controlling specific behavioral aspects of Run:AI. Specifically, those which require additional permissions. Such as automatic namespace/project creation, secret propagation, and more.

The purpose of this document is to provide security officers with the ability to review what cluster-wide access Run:AI requires, and verify that it is in line with organizational policy, before installing the Run:AI cluster. 


## Review Cluster Access Roles

If you have not done so before, run:

```
helm repo add runai https://run-ai-charts.storage.googleapis.com
helm repo update
```

Then run:

```
helm pull runai/runai-cluster --untar
cd runai-cluster/templates
```

Following is a description of some of the relevant files: 

|   Folder    | File  |  Purpose | 
|-------------|-------|----------|
| `clusterroles` | `base.yaml` | Mandatory Kubernetes _Cluster Roles_ and _Cluster Role Bindings_  | |
| `clusterroles` |`project-controller-ns-creation.yaml` | Automatic Project Creation and Maintenance. Provides Run:AI with the ability to create Kubernetes namespaces when the Run:AI administrator creates new Projects. Can be turned on/off via [flag](customize-cluster-install.md) |  
| `clusterroles` |`project-controller-rb-creation.yaml` | Automatically assign Users to Projects. Can be turned on/off via [flag](customize-cluster-install.md) |  
| `clusterroles` | `project-controller-cluster-wide-secrets.yaml` | Allow the propagation of Secrets. See [Secrets in Jobs](../Researcher-Setup/use-secrets.md). Can be turned on/off via [flag](customize-cluster-install.md) | 
| `clusterroles` | `project-controller-limit-range.yaml` | Disables the usage of the Kubernetes [Limit Range](https://kubernetes.io/docs/concepts/policy/limit-range/#:~:text=A%20LimitRange%20is%20a%20policy,per%20PersistentVolumeClaim%20in%20a%20namespace){target=_blank} feature. Can be turned on/off via [flag](customize-cluster-install.md) |
| `ocp` | `scc.yaml`| OpenShift-specific Security Contexts | 
| `priorityclasses` | 4 files |  Folder contains a list of _Priority Classes_ used by Run:AI | 
| `psp` | `baseline-psp.yaml`  | A subset of the Kubernetes __baseline__ PodSecurityPolicy ([here](https://github.com/kubernetes/website/blob/master/content/en/examples/policy/baseline-psp.yaml){target=_blank})| 
| `psp` | `nvidia-psp.yaml` | Required for NVIDIA components |
| `psp` | `runai-container-toolkit-psp.yaml` | Required for Run:AI GPU Fractions technology. Can be turned on/off via [flag](customize-cluster-install.md). | 
| `psp` | `runai-user-psp.yaml` | Required for User Workloads. Extends the Kubernetes __baseline__ PodSecurityPolicy for Run:AI GPU Fractions technology. Can be turned on/off via [flag](customize-cluster-install.md).  
| `psp` | `privileged.yaml` | __priviliged__ Kubernetes PodSecurityPolicy. Used only for installing _Node Feature Discovery_ and _NVIDIA GPU Feature Discovery_ third parties. Can be turned on/off via [flag](customize-cluster-install.md) | 
|<img width=400/>|<img width=600/>||



 

