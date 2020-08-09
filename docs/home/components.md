# Run:AI System Components 

## Components

* Run:AI is installed over a Kubernetes Cluster

* Researchers submit Machine Learning workloads via the Run:AI Command-Line Interface (CLI), or directly by sending YAML files to Kubernetes. 

* Administrators monitor and set priorities via the Administrator User Interface

![architecture](img/architecture.png)


## The Run:AI Cluster 

The Run:AI Cluster contains:

* The Run:AI Scheduler which extends the Kubernetes scheduler. It uses business rules to schedule workloads sent by Researchers. 
* Fractional GPU management. Responsible for the Run:AI Virtualization technology which allows Researchers to allocate parts of a GPU rather than a whole GPU 
* The Run:AI agent. Responsible for sending Monitoring data to the Run:AI Cloud.
* Clusters require outbound network connectivity to the Run:AI Cloud.  

### Kubernetes-Related Details

* The Run:AI cluster is installed as a [Kubernetes Operator](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)
* Run:AI is installed in its own namesapce __runai__
* Workloads are run in the context of __Projects__. Each project is a Kubernetes namespace with its own settings and access control. 

## The Run:AI Cloud

The Run:AI Cloud is the basis of the Administrator User Interface. 

* The Run:AI cloud aggregates monitoring information from __multiple__ tenants (customers).
* Each customer may manage __multiple__ Run:AI clusters.






