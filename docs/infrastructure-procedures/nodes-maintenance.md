# Nodes maintenance 

This article provides detailed instructions on how to manage both planned and unplanned node downtimes in a Kubernetes cluster running Run:ai. It covers all the steps to maintain service continuity and ensure the proper handling of workloads during these events.

## Prerequisites

* **Access to Kubernetes cluster** - Administrative access to the Kubernetes cluster, including permissions to run kubectl commands
* **Basic knowledge of Kubernetes** - Familiarity with Kubernetes concepts such as nodes, taints, and workloads
* **Run:ai installation** - The Run:ai software installed and configured within your Kubernetes cluster
* **Node naming conventions** - Know the names of the nodes within your cluster, as these are required when executing the commands

## Node types

This article distinguishes between two types of nodes within a Run:ai installation:

* **Worker nodes** - Nodes on which AI practitioners can submit and run workloads
* **Run:ai system nodes** - Nodes on which the Run:ai software runs, managing the cluster's operations

### Worker nodes

Worker nodes are responsible for running workloads. When a worker node goes down, either due to planned maintenance or unexpected failure, workloads ideally migrate to other available nodes or wait in the queue to be executed when possible.

#### Training vs. Interactive workloads

The following workload types can run on worker nodes: 

* **Training workloads** - These are long-running processes that, in case of node downtime, can automatically move to another node.
* **Interactive workloads** - These are short-lived, interactive processes that require manual intervention to be relocated to another node.

!!! Note
    While training workloads can be automatically migrated, it is recommended to plan maintenance and manually manage this process for a faster response, as it may take time for Kubernetes to detect a node failure.

#### Planned maintenance

Before stopping a worker node for maintenance, perform the following steps:

1. __Prevent new workloads on the node__  
   To stop the Kubernetes Scheduler from assigning new workloads to the node and to safely remove all existing workloads, copy the following command to your terminal:  

    ``` bash
    kubectl taint nodes <node-name> runai=drain:NoExecute
    ```

    __Explanation:__ 
    
    * `<node-name>`  
        Replace this placeholder with the actual name of the node you want to drain  
    * `kubectl taint nodes`  
        This command is used to add a taint to the node, which prevents any new pods from being scheduled on it  
    * `runai=drain:NoExecute`  
        This specific taint ensures that all existing pods on the node are evicted and rescheduled on other available nodes, if possible. 

    __Result__: The node stops accepting new workloads, and existing workloads either migrate to other nodes or are placed in a queue for later execution. 

2. __Shut down and perform maintenance__  
   After draining the node, you can safely shut it down and perform the necessary maintenance tasks. 

3. __Restart the node__ 
   Once maintenance is complete and the node is back online, remove the taint to allow the node to resume normal operations. Copy the following command to your terminal:  

    ``` bash
    kubectl taint nodes <node-name> runai=drain:NoExecute-
    ```

    __Explanation:__ 

    * `runai=drain:NoExecute-`  
      The `-` at the end of the command indicates the removal of the taint. This allows the node to start accepting new workloads again.

    __Result__: The node rejoins the cluster's pool of available resources, and workloads can be scheduled on it as usual

#### Unplanned downtime

In the event of unplanned downtime:

1. __Automatic Restart__  
    If a node fails but immediately restarts, all services and workloads automatically resume.  
2. __Extended Downtime__  
   If the node remains down for an extended period, drain the node to migrate workloads to other nodes. Copy the following command to your terminal:  

    ``` bash
    kubectl taint nodes <node-name> runai=drain:NoExecute
    ```

    __Explanation:__ The command works the same as in the planned maintenance section, ensuring that no workloads remain scheduled on the node while it is down.  

3. __Reintegrate the Node__ 
   Once the node is back online, remove the taint to allow it to rejoin the cluster's operations. Copy the following command to your terminal:  

    ``` bash
    kubectl taint nodes <node-name> runai=drain:NoExecute-
    ``` 
    __Result__: This action reintegrates the node into the cluster, allowing it to accept new workloads.  

4. __Permanent Shutdown__  
    If the node is to be permanently decommissioned, remove it from Kubernetes with the following command:  

    ``` bash
    kubectl delete node <node-name>
    ```  
    __Explanation__: 

    * `kubectl delete node`  
      This command completely removes the node from the cluster  
    * `<node-name>`  
      Replace this placeholder with the actual name of the node  

    __Result:__ The node is no longer part of the Kubernetes cluster. If you plan to bring the node back later, it must be rejoined to the cluster using the steps outlined in the next section.

### Run:ai System nodes

In a production environment, the services responsible for scheduling, submitting and managing Run:ai workloads operate on one or more Run:ai system nodes. It is recommended to have more than one system node to ensure [high availability](../config/ha.md). If one system node goes down, another can take over, maintaining continuity. If a second system node does not exist, you must designate another node in the cluster as a temporary Run:ai system node to maintain operations.

The protocols for handling planned maintenance and unplanned downtime are identical to those for worker nodes. Refer to the above section for detailed instructions. 

## Rejoining a node into the Kubernetes cluster

To rejoin a node to the Kubernetes cluster, follow these steps:

1. __Generate a join command on the master node__  
   On the master node, copy the following command to your terminal:  

    ``` bash
    kubeadm token create --print-join-command
    ``` 

    __Explanation__: 

    * `kubeadm token create`  
        This command generates a token that can be used to join a node to the Kubernetes cluster.  
    * `--print-join-command`  
        This option outputs the full command that needs to be run on the worker node to rejoin it to the cluster.

    __Result__: The command outputs a `kubeadm join` command. 
    
2. __Run the Join Command on the Worker Node__  
   Copy the `kubeadm join` command generated from the previous step and run it on the worker node that needs to rejoin the cluster.

    __Explanation:__  

    * The `kubeadm join` command re-enrolls the node into the cluster, allowing it to start participating in the cluster's workload scheduling. 

3. __Verify Node Rejoining__ 
   Verify that the node has successfully rejoined the cluster by running:  

    ``` bash
    kubectl get nodes
    ```

    __Explanation__:  

    This command lists all nodes currently part of the Kubernetes cluster, along with their status  
    
    __Result__: The rejoined node should appear in the list with a status of Ready 

4. __Re-label Nodes__  
    Once the node is back online, ensure it is labeled according to its role within the cluster

