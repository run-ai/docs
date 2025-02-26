## Cluster installation for self-hosted

This article explains the required hardware and software system requirements for the Run:ai cluster.

The system requirements needed depends on where the control plane and cluster are installed for Kubernetes only:

* If you are installing the first cluster and control plane on the same Kubernetes cluster,  Kubernetes ingress controller, Prometheus and Fully Qualified Domain Name are not required.

* If you are installing the first cluster and control plane on separate Kubernetes clusters, the Kubernetes ingress controller, Prometheus and Fully Qualified Domain Name are required.