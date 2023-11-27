
# High Availability

The purpose of this document is to configure Run:ai such that it will continue to provide service even if parts of the system are down. 

The frequent scenario is typically a physical node in the system becoming non-responsive due to physical problems or lack of resources. In these cases, Kubernetes will attempt to relocate the running pods, but the process may take time, during which Run:ai will be down. 

A different scenario is a high transaction rate leading to system overload. To address such a scenario, please review [Scaling the Run:ai system](./large-clusters.md).


## Run:ai Control Plane

### Run:ai system workers

The Run:ai control plane allows the __optional__ [gathering of Run:ai pods into specific nodes](../self-hosted/k8s/preparations.md#optional-mark-runai-system-workers). If the feature is used, it is important to set more than one node as a Run:ai system worker. Otherwise, the horizontal scaling described below will not work and the system will remain with a single point of failure.  

### Horizontal Scalability of Run:ai services

Horizontal scalability is about instructing the system to create more pods to dynamically scale according to incoming load and downsize when the load subsides. 

The Run:ai control plane is running on a single Kubernetes namespace named `runai-backend`. The namespace contains various Kubernetes [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/){target=_blank} and [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){target=_blank}. Each of these services can be scaled horizontally. 

#### Deployments

Each of the Run:ai deployments can be set to scale up, by adding a helm settings on install/upgrade. E.g. `--set policyService.autoscaling.enabled=true`. For a full list of settings, please contact Run:ai customer support. 

#### StatefulSets

Run:ai uses three third parties which are managed as Kubernetes StatefulSets:

* __Keycloak__: Stores the Run:ai authentication configuration as well as user identities. To scale Keycloak, use the helm flag `--set keycloakx.autoscaling.enabled=true`. By default, Keycloak set a minimum of 3 pods and will scale to more on transaction load. 
* __PostgreSQL__: It is not possible to configure an internal PostgreSQL to scale horizontally. If this is of importance, please contact Customer Support to understand how to connect Run:ai to an external PostgreSQL service which can be configured for high availability. 
* __Thanos__: at the time of writing, there is no known solution for Thanos High availability. 
 


## Run:ai Cluster

### Run:ai system workers

The Run:ai cluster allows the __mandatory__ [gathering of Run:ai pods into specific nodes](../self-hosted/k8s/preparations.md#optional-mark-runai-system-workers). If the feature is used, it is important to set more than one node as a Run:ai system worker to remove this single point of failure. 

### Prometheus 

The default Prometheus installation uses a single pod replica. If the node running the pod is unresponsive, metrics will not be scraped from the cluster and will not be sent to the Run:ai control-plane. 

Prometheus [supports](https://prometheus.io/docs/introduction/faq/#can-prometheus-be-made-highly-available){target=_blank} high availability by allowing to run multiple instances. The tradeoff of this approach is that all instances will scrape and send the same data. The Run:ai control plane will identify duplicate metric series and ignore them. This approach will thus increase network, CPU and memory consumption.

To change the number of Prometheus instances, edit the `runaiconfig` as described under  [customizing the Run:ai cluster](../cluster-setup/customize-cluster-install.md). Under `prometheus`, set `replicas` to 2. 