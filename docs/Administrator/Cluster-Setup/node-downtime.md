# Planned and Unplanned Node Downtime  

## Introduction

Nodes (Machines) that are part of the cluster are susceptible to occasional downtime. This can be either as part of __planned maintenance__ where we bring down the node for a specified time in an orderly fashion or an __unplanned downtime__ where the machine abruptly stops due to a software or hardware issue.

The purpose of this document is to provide a process for retaining the Run:AI service and Researcher workloads during and after the downtime. 

## Node Types
The document differentiates between __Run:AI System Worker Nodes__ and __GPU Worker Nodes__:

* Worker Nodes - are where Machine Learning workloads run. 
* Run:AI System Nodes - In a production installation Run:AI software runs on one or more [Run:AI System Nodes](../cluster-prerequisites/#hardware-requirements) on which the Run:AI software runs. 


## Worker Nodes
Worker Nodes are where machine learning workloads run. Ideally, when a node is down, whether for planned maintenance or due to an abrupt downtime, these workloads should migrate to other available nodes or wait in the queue to be started when possible. 

### Training vs. Interactive
Run:AI differentiates between _Training_ and _Interactive_ workloads. The key difference at node downtime is that Training workloads will automatically move to a new node while Interactive workloads require a manual process. The manual process is recommended for Training workloads as well, as it hastens the process -- it takes time for Kubernetes to identify that a node is down.

### Planned Maintenance

Before stopping a Worker node, perform the following: 

* Stop the Kubernetes scheduler from starting __new__ workloads on the node and drain node from all existing workloads. Workloads will move to other nodes or await on queue for renewed execution:

```
kubectl drain <node_name> --delete-local-data --ignore-daemonsets
```

* Shut down the node and perform the required maintenance. 


* When done, start the node and then run:

```
kubectl uncordon <node-name>
```

### Unplanned Downtime

* If a node has failed and has immediately restarted, all services will automatically start. 

* If a node is to remain down for some time, you will want to drain the node so that workloads will migrate to another node:

```
kubectl drain <node_name> --delete-local-data --ignore-daemonsets
```

When the node is up again, run: 

```
kubectl uncordon <node-name>
```

* If the node is to be permanently shut down, you can remove it completely from Kubernetes. Run:

```
kubectl delete node <node-name>
```

However, if you plan to bring back the node, you will need to rejoin the node into the cluster. See [Rejoin](#Rejoin-a-Node-into-the-Kubernetes-Cluster).



## Run:AI System Nodes
 
 In a production installation, Run:AI software runs on one or more Run:AI system nodes. As a best practice, it's best to have __more than one__ such node so that during planned maintenance or unplanned downtime of a single node, the other node will take over. If a second node does not exist, you will have to [designate an arbitrary node](node-roles.md) on the cluster as a Run:AI system node to complete the process below.

 Protocols for planned maintenance and unplanned downtime are identical to Worker Nodes. See the section above. 



## Rejoin a Node into the Kubernetes Cluster

To rejoin a node to the cluster follow the following steps:

* On the __master__ node, run:

        kubeadm token create --print-join-command

* This would output a ``kubeadm join`` command. Run the command on the worker node for it to re-join the Kubernetes cluster. 

* Verify that the node is joined by running:

        kubectl get nodes


* When the machine is up you will need to [re-label nodes according to their role](node-roles.md)