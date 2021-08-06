
# Installation Types

Run:AI consists of two components:

* The Run:AI [Cluster](../../../home/components/#the-runai-cluster). One or more data-science GPU clusters hosted by the customer (on-prem or cloud).
* The Run:AI [Backend](../../../home/components/#the-runai-cloud) or _Control Plane_. A single entity that monitors clusters, sets priorities, and business policies. 

<!-- ![img/architecture.png](img/architecture.png) -->

There are two main installation options:

| Installation Type | Description | 
|-------------------|-------------|
| [Classic (SaaS)](../Cluster-Setup/cluster-setup-intro.md)  | Run:AI is installed on the customer's data science GPU clusters together with the Run:AI control-plan on the cloud. <br> Requires an __outbound__ connection from the cluster to the cloud. |
| Self-hosted       | The Run:AI backend is also installed in the customer's data center |


The self-hosted option is for organizations that cannot use a SaaS solution due to data leakage concerns. The self-hosted installation is priced differently. For further information please talk to Run:AI sales. 


## Self-hosted Installation


Run:AI self-hosting comes with two variants:

| Self-hosting Type | Description | 
|------|-------------|
| Connected | The organization can freely download from the internet (though upload is not allowed)    |
| Air-gapped | The organization has no connection to the internet <br> |

### Self-hosting with Kubernetes vs OpenShift

Kubernetes has many [Certified Kubernetes Providers](https://kubernetes.io/docs/setup/#production-environment){target=_blank}. Run:AI has been installed with a number of those such as Rancher, Kubespray, OpenShift, HPE Ezmeral, and Native Kubernetes. The OpenShift installation is different from the rest. As such, the Run:AI self-hosted installation instructions are divided into two separate sections:

* OpenShift-based installation. See [Run:AI OpenShift installation](self-hosted/ocp/prerequisites.md).
* Kubernetes-based installation. See [Run:AI Kubernetes installation](self-hosted/k8s/prerequisites.md).

## Secure Installation

In many organizations, Kubernetes is governed by IT compliance rules. In this scenario, there are strict access control rules during the installation and running of workloads:

* OpenShift is secured using _Security Context Constraints_ (SCC). The Run:AI installation supports SCC.
* Kubernetes is secured using _Pod Security Policy_ (PSP). The Run:AI installation supports PSP.



