# (Optional) Customize Cluster Installation

The Run:AI Admin UI cluster creation wizard requires the download of a _Helm values file_ `runai-<cluster-name>.yaml`. You may need to edit this file. Examples:

* Disable the installation of third-party dependencies which already exist on the Kubernetes cluster
* Security review and pre-installation of Kubernetes cluster-wide access roles
* Add an _ingress_ point
* Add an outbound internet proxy


## Disable the installation of third-party dependencies

The default Run:AI installation packages all of its third-party dependencies. If your Kubernetes environment already has some of these dependencies, you may disable their installation. 

These dependencies are:

* [Node feature discovery](https://kubernetes-sigs.github.io/node-feature-discovery/stable/get-started/index.html){target=_blank} 
* NVIDIA [GPU feature discovery](https://github.com/NVIDIA/gpu-feature-discovery){target=_blank} (also contains Node feature discovery)
* [Prometheus](https://github.com/prometheus-operator/kube-prometheus){target=_blank}. To disable Prometheus please contact Run:AI customer support

Edit  `runai-<cluster-name>.yaml` and set `enabled` to `false` for the respective third-party

## Access roles

### Review Access Roles


The default Run:AI installation assumes administrative rights to create its own required access roles. You may want to want to provide your IT department with the ability to view and then pre-create these roles. 

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
<!-- and then install Run:AI under reduced previlidges with access to designated namespaces only (`runai`, `node-feature-discovery` and `monitoring` for Prometheus). -->

In this case, in the values file, change `createRbac` to `false`.
 


## Add an Ingress point

Set aside an IP address for _ingress_ access to containers (e.g. for Jupyter Notebooks, PyCharm, VisualStudio Code). See: [Allow external access to Containers](allow-external-access-to-containers.md). Note that you can access containers via _port forwarding_ without requiring an ingress point. 


## Add a Proxy

Allow outbound internet connectivity in a proxied network environment. See: [Installing Run:AI with an Internet Proxy Server](proxy-server.md).