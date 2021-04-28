# Understanding Cluster Access Roles

Run:AI has the ability to work under restrictive Kubernetes environments. Namely:

* Kubernetes [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank}
* OpenShift

You can enable these restricted environment by setting the `pspEnabled` or `openshift` configuration [flags](../customize-cluster-install/#configuration-flags) in the Helm values file before installing the Run:AI cluster. 

There are other configuration flags controlling specific behavioral aspects of Run:AI. Specifically those which require additional permissions. Such as automatic namespace/project creation, secret propagation and more.

The purpose of this document is to provide security officers with a ability to review what cluster-wide access Run:AI requires, and verify that it is in line with organizational policy, prior to installing the Run:AI cluster. 


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
| `clusterroles` |`project-controller-ns-creation-and-user-auth.yaml` | Automatic Project Creation and Maintenance. Provides Run:AI with the ability to create Kubernetes namespaces when the Run:AI administrator creates new Projects. Can be controlled via flag |  
| `clusterroles` | `project-controller-cluster-wide-secrets.yaml` | allow the propagation of Secrets. See [Secrets in Jobs](../Researcher-Setup/use-secrets.md). Can be controlled via flag. | 
| `clusterroles` | `project-controller-limit-range` ||
| `ocp` | `scc.yaml`| OpenShift-specific Security Contexts | 
| `priorityclasses` | 4 files |  folder contains a list of _Priority Classes_ used by Run:AI | 
| `psp` | file 1.....  Itay .... | | 



 

