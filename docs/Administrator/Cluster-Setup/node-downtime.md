# Planned and Unplanned Node Downtime  

## Introduction

Nodes (Machines) that are part of the cluster are susceptible to occasional downtime. This can be either as part of __planned maintenance__ where we bring down the node for a specified time in an orderly fashion or an __unplanned downtime__ where the machine abruptly stops due to a software or hardware issue.

The purpose of this document is to provide a process for retaining the Run:AI service and Researcher workloads during and after the downtime. 

## Node Types
The document differentiates between __Run:AI System Worker Nodes__ and __GPU Worker Nodes__:

* Worker Nodes - are where Machine Learning workloads run. 
* Run:AI System Nodes - In a production installation Run:AI software runs on one or more [Run:AI System Nodes](../cluster-prerequisites/#hardware-requirements) on which the Run:AI software runs. 


## Worker Nodes
Worker Nodes are where machine learning workloads run. Ideally, when a node is down, whether for planned maintenance, or an abrupt downtime, these workloads should migrate to other available nodes or wait in the queue to be started when possible. 

### Planned Maintenance

Before stopping a Worker node, perform the following: 

* Stop the Kubernetes scheduler from starting __new__ workloads on the node:

```
kubectl cordon <node-name>
```

* Force all Interactive Workloads to move to another node or wait in queue:

``` 
kubectl scale sts --all --replicas=0  -n runai
kubectl scale sts --all --replicas=1  -n runai  
```

* Shutdown the node and perform the required maintenance. When done, start the node and then run:

```
kubectl uncordon <node-name>
```

### Unplanned Downtime


* If a node has failed and has immediately restarted then all services will automatically start and there is nothing that needs doing.

* If a node is to remain down for some time, then after a couple of minutes, Kubernetes will identify the Node is not working and will send previously running workloads back to the queue. To fasten the process you can temporarily remove the node from Kubernetes. This will require re-joining the node when it is up again. Run:

        kubectl delete node <node-name>

* When the node is up again, you will need to rejoin the node into the cluster. See [Rejoin](#Rejoin Node into Kubernetes Cluster)



## Run:AI System Nodes
 
 In a production installation, Run:AI software runs on one or more Run:AI system nodes. As a best practice, it's best to have __more than one__ such node so that during planned maintenance or unplanned downtime of a single node, the other node will take over. If a second node does not exist, you will have to designate an arbitrary node on the cluster as a Run:AI system node as part of the process below.


### Planned Maintenance

Designate another node as a Run:AI system node. 


Move Run:AI storage-dependant services to another node.  

        kubectl delete pvc --all -n runai
        kubectl scale sts --all --replicas=1  -n runai  
        kubectl apply -f  XXXX https://docs.run.io/ yaml migration


* Shutdown the node and perform the required maintenance. When done, start the node and then run:

        kubectl uncordon <node-name>

For further information see [Kubernetes Documentation](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/){target=_blank}.


### Unplanned Downtime

* If the node has failed and has immediately restarted then all services will automatically start and there is nothing that needs doing.

* If the node is to remain down for some time and you want Run:AI services to commence, you must temporarily remove the node from Kubernetes. Run:

        kubectl delete node <node-name>

* When the node is up again, you will need to rejoin the node into the cluster. See [Rejoin](#Rejoin Node into Kubernetes Cluster)



## Rejoin Node into Kubernetes Cluster

To rejoin a node to the cluster follow the following steps:

* On the __master__ node, run:

        kubeadm token create --print-join-command

* This would output a ``kubeadm join`` command. Run the command on the worker node in order for it to re-join the Kubernetes cluster. 

* Verify that the node is joined by running:

        kubectl get nodes


* When the machine is up RELABEL  