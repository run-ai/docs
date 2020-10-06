# Planned and Unplanned Node Downtime  

## Introduction

Nodes (Machines) that are part of the cluster are susceptible to occasional downtime. This can be either as part of __planned maintenance__ where we bring down the node for a specified time in an orderly fashion or an __unplanned downtime__ where the machine stops due to a software or hardware issue.

The purpose of this document is to provide a process for retaining the Run:AI service during and after the downtime. The document differentiates between CPU-Only Worker Nodes and  GPU Worker Nodes:

* __CPU-Only Worker Nodes__ - In a production installation Run:AI software runs on one or more [CPU-only Worker Nodes](../cluster-prerequisites/#hardware-requirements) on which the Run:AI software runs. 

* __GPU Worker Nodes__ are where Machine Learning workloads run. Run:AI only runs monitoring services on these nodes. This monitoring services recover automatically. 


## Preparations: Shared Storage

Some of the Run:AI services use disk storage. A key to successful node recovery is to __not__ rely on node-storage. Rather, during the installation, you must follow the protocol for installing the Run:AI cluster over __shared__ storage. For further details see [Installing Run:AI over network file storage](nfs-install.md)

## Planned Maintenance

Before stopping a node, perform the following: 

* Stop the Kubernetes scheduler from starting __new__ workloads on the node:

        kubectl cordon <node-name>

* Force all services that _have a state_ to move to another node:

        kubectl scale sts --all --replicas=0  -n runai
        kubectl scale sts --all --replicas=1  -n runai  

> On GPU Workers this will move Interactive workloads to another node if possible. 

> On CPU-only Workers this will move Run:AI storage-dependant services to another node.  

* Shutdown the node and perform the required maintenance. When done, start the node and then run:

        kubectl uncordon <node-name>

For further information see [Kubernetes Documentation](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/).

## Unplanned Downtime

* If the node has failed and has immediately restarted then all services will automatically start and there is nothing that needs doing.

* If the node is to remain down for some time and you want Run:AI services to commence, you must temporarily remove the node from Kubernetes. Run:

        kubectl delete node <node-name>

* When the node is up again, on the master node, run:

        kubeadm token create --print-join-command

* This would output a ``kubeadm join`` command that you must run on the worker node in order for it to re-join the Kubernetes cluster. 

* Verify that the node is joined by running:

        kubectl get nodes


* After the node has joined, [re-run](../cluster-install/#step-23-cpu-only-worker-nodes) the following command to mark the node as a CPU node:

        kubectl label node <node-name> run.ai/cpu-node=true