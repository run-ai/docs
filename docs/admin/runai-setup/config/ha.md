
# High Availability

The purpose of this document is to configure Run:ai such that it will continue to provide service even if parts of the system are down. 

A frequent fail scenario is a physical node in the system becoming non-responsive due to physical problems or lack of resources. In such a case, Kubernetes will attempt to relocate the running pods, but the process may take time, during which Run:ai will be down. 

A different scenario is a high transaction load, leading to system overload. To address such a scenario, please review the article: [scaling the Run:ai system](./large-clusters.md).


## Run:ai Control Plane

### Run:ai system workers

The Run:ai control plane allows the **optional** [gathering of Run:ai pods into specific nodes](../self-hosted/k8s/preparations.md#optional-mark-runai-system-workers). When this feature is used, it is important to set more than one node as a Run:ai system worker. Otherwise, the horizontal scaling described below will not span multiple nodes, and the system will remain with a single point of failure.  

### Horizontal Scalability of Run:ai services

Horizontal scalability is about instructing the system to create more pods to dynamically scale according to incoming load and downsize when the load subsides. 

The Run:ai control plane is running on a single Kubernetes namespace named `runai-backend`. The namespace contains various Kubernetes [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/){target=_blank} and [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){target=_blank}. Each of these services can be scaled horizontally. 

#### Deployments

Each of the Run:ai deployments can be set to scale up, by adding a helm settings on install/upgrade. E.g. `--set frontend.autoscaling.enabled=true`. For a full list of settings, please contact Run:ai customer support. 

#### StatefulSets

Run:ai uses three third parties which are managed as Kubernetes StatefulSets:

* **Keycloak**&mdash;Stores the Run:ai authentication configuration as well as user identities. To scale Keycloak, use the Run:ai control-plane helm flag `--set keycloakx.autoscaling.enabled=true`. By default, Keycloak sets a minimum of 3 pods and will scale to more on transaction load.
* **PostgreSQL**&mdash;It is not possible to configure an internal PostgreSQL to scale horizontally. If this is of importance, please contact Customer Support to understand how to connect Run:ai to an external PostgreSQL service which can be configured for high availability. 
* **Thanos**&mdash;To enable Thanos autoscaling, use the following Run:ai control-plane helm flags: 
```
--set thanos.receive.autoscaling.enabled=true 
--set thanos.query.autoscaling.enabled=true  
--set thanos.query.autoscaling.maxReplicas=2 
--set thanos.receive.autoscaling.maxReplicas=3 
--set thanos.query.autoscaling.minReplicas=2 
--set thanos.receive.autoscaling.minReplicas=3
``` 

## Run:ai Cluster

### Run:ai system workers

The Run:ai cluster allows the __mandatory__ [gathering of Run:ai pods into specific nodes](../self-hosted/k8s/preparations.md#optional-mark-runai-system-workers). When this feature is used, it is important to set more than one node as a Run:ai system worker. Otherwise, the horizontal scaling described below may not span multiple nodes, and the system will remain with a single point of failure.  

### Prometheus 

The default Prometheus installation uses a single pod replica. If the node running the pod is unresponsive, metrics will not be scraped from the cluster and will not be sent to the Run:ai control-plane. 

[Prometheus supports](https://prometheus.io/docs/introduction/faq/#can-prometheus-be-made-highly-available){target=_blank} high availability by allowing to run multiple instances. The tradeoff of this approach is that all instances will scrape and send the same data. The Run:ai control plane will identify duplicate metric series and ignore them. This approach will thus increase network, CPU and memory consumption.

To change the number of Prometheus instances, edit the `runaiconfig` as described under [customizing the Run:ai cluster](../cluster-setup/customize-cluster-install.md). Under `prometheus`, set `replicas` to 2. 
