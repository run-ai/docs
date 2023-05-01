
# Installation Types

Run:ai consists of two components:

* The Run:ai [Cluster](../../../home/components/#the-runai-cluster). One or more data-science GPU clusters hosted by the customer (on-prem or cloud).
* The Run:ai [Control plane](../../../home/components/#the-runai-cloud). A single entity that monitors clusters, sets priorities, and business policies. 

<!-- ![img/architecture.png](img/architecture.png) -->

There are two main installation options:

| Installation Type | Description |
|-------------------|-------------|
| [Classic (SaaS)](cluster-setup/cluster-setup-intro.md)  | Run:ai is installed on the customer's data science GPU clusters. The cluster connects to the Run:ai control plane on the cloud (https://`<tenant-name>`.run.ai). <br> With this installation, the cluster requires an __outbound__ connection to the Run:ai cloud. |
| [Self-hosted](self-hosted/overview.md)       | The Run:ai control plane is also installed in the customer's data center |


The self-hosted option is for organizations that cannot use a SaaS solution due to data leakage concerns. The self-hosted installation is priced differently. For further information please talk to Run:ai sales. 


## Self-hosted Installation


Run:ai self-hosting comes with two variants:

| Self-hosting Type | Description | 
|------------|-------------|
| Connected  | The organization can freely download from the internet (though upload is not allowed) |
| Air-gapped | The organization has no connection to the internet |

### Self-hosting with Kubernetes vs OpenShift

Kubernetes has many [Certified Kubernetes Providers](https://kubernetes.io/docs/setup/#production-environment){target=_blank}. Run:ai has been certified with several of them (see the [Kubernetes prerequisites](cluster-setup/cluster-prerequisites.md#kubernetes) section). The OpenShift installation is different from the rest. As such, the Run:ai self-hosted installation instructions are divided into two separate sections:

* OpenShift-based installation. See [Run:ai OpenShift installation](self-hosted/ocp/prerequisites.md).
* Kubernetes-based installation. See [Run:ai Kubernetes installation](self-hosted/k8s/prerequisites.md).

## Secure Installation

In many organizations, Kubernetes is governed by IT compliance rules. In this scenario, there are strict access control rules during the installation and running of workloads:

* OpenShift is secured using _Security Context Constraints_ (SCC). The Run:ai installation supports SCC.
* Kubernetes _Pod Security Policy_ (PSP) has been deprecated by Kubernetes. Support for PSP will be removed on Run:ai versions higher than 2.8.



