# (Optional) Customize Cluster Installation

The Run:AI Admin UI cluster creation wizard requires the download of a _Helm values file_ `runai-<cluster-name>.yaml`. You may need to edit this file. Examples:

* Disable the installation of third-party dependencies which already exist on the Kubernetes cluster
* Security review and pre-installation of Kubernetes cluster-wide access roles
* Add an _ingress_ point
* Add an outbound internet proxy


## Configuration Flags

|  Key     |  Change  | Description |
|----------|----------|-------------| 
| `runai-operator.config.global.openshift` | set to `true` with OpenShift | |
| `runai-operator.config.init-ca.enabled` | set to `false` with OpenShift | |
| `pspEnabled` | `<true/false>` | Set to `true` when using [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} | 
| `runai-operator.config.project-controller.createNamespacesAndRoleBindings` | Set to `false` when using PodSecurityPolicy or OpenShift | Will requires an additional manual step when creating new Run:AI Projects | 
| `runai-operator.config.project-controller.clusterWideSecret` | Set to `false` when using PodSecurityPolicy or OpenShift | | 
| `runai-operator.config.mps-server.enabled` | Default is `false` | Allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads  | 
| `runai-operator.config.runai-container-toolkit.enabled` | Default is `true` | Controls the usage of __Fractions__. Requires [extra permissions](../preparations/#cluster-installation) | 
| `runai-operator.config.runaiBackend.password` | Default password already set  | admin@run.ai password. Need to change only if you have changed the password [here](../backend/#other-changes-to-perform) | 
| `gpu-feature-discovery.enabled` | set to `false` | Do not install Node Feature Discovery (assumes a prior install outside Run:AI scope) |
| `kube-prometheus-stack.enabled` | set to `false` | Do not install Prometheus (assumes a prior install outside Run:AI scope). Requires additional configuration of Prometheus to add Run:AI related exporter rules |



## Add an Ingress point

Set aside an IP address for _ingress_ access to containers (e.g. for Jupyter Notebooks, PyCharm, VisualStudio Code). See: [Allow external access to Containers](allow-external-access-to-containers.md). Note that you can access containers via _port forwarding_ without requiring an ingress point. 


## Add a Proxy

Allow outbound internet connectivity in a proxied network environment. See [Installing Run:AI with an Internet Proxy Server](proxy-server.md).


## Access roles

### Review Access Roles


The default Run:AI installation assumes administrative rights to create its required access roles. You may want to want to provide your IT department with the ability to view and then pre-create these roles. 

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

The `clusterroles` folder contains the following:

* `base.yaml` - Mandatory Kubernetes _Cluster Roles_ and _Cluster Role Bindings_ 
* `project-controller-ns-creation-and-user-auth.yaml` - Automatic Project Creation and Maintenance. Provides Run:AI with the ability to create Kubernetes namespaces when the Run:AI administrator creates new Projects. 
* `project-controller-cluster-wide-secrets.yaml` - allow the propagation of Secrets. See [Secrets in Jobs](../Researcher-Setup/use-secrets.md)

The `priorityclasses` folder contains a list of _Priority Classes_ used by Run:AI

The `ocp` folder contains OpenShift related access files.


### Pre-install Access Roles

Your IT department can pre-apply the above YAML files after reviewing them.
<!-- and then install Run:AI under reduced privileges with access to designated namespaces only (`runai`, `node-feature-discovery` and `monitoring` for Prometheus). -->

In this case, in the values file, change `createRbac` to `false`.
 

