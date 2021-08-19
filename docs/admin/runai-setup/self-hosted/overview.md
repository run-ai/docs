---
title: Self Hosted Run:AI Installation Overview
---
# Self Hosted Run:AI Installation


The self-hosted option is for organizations that cannot use a SaaS solution due to data leakage concerns.

Run:AI self-hosting comes with two variants:

| Self-hosting Type | Description | 
|-------------------|-------------|
| Connected | The organization can freely download from the internet (though upload is not allowed)    |
| Air-gapped | The organization has no connection to the internet <br> |

The self-hosted installation is priced differently. For further information please talk to Run:AI sales. 
## Self-hosting with Kubernetes vs OpenShift

Kubernetes has many [Certified Kubernetes Providers](https://kubernetes.io/docs/setup/#production-environment){target=_blank}. Run:AI has been installed with a number of those such as Rancher, Kubespray, OpenShift, HPE Ezmeral, and Native Kubernetes. The OpenShift installation is different from the rest. As such, the Run:AI self-hosted installation instructions are divided into two separate sections:

* OpenShift-based installation. See [Run:AI OpenShift installation](ocp/preparations.md). The Run:AI operator for OpenShift is [certified](https://catalog.redhat.com/software/operators/detail/60be3acc3308418324b5e9d8){target=_blank} by Red Hat.
* Kubernetes-based installation. See [Run:AI Kubernetes installation](k8s/preparations.md).




