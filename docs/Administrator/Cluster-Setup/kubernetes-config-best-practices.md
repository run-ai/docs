## Safely Remove a Node

Every now and again, you may need to take down a node. Typically for maintenance purposes. The node about to be taken down may be running Jobs. Without additional preparations, these Jobs will abruptly come to an end, and wait for the node to come up. To allow the Jobs to gracefully shut-down and be immediately re-allocated to other nodes, perform the following:

To get the name of the node, run: 

    kubectl get nodes 

Then run:

    kubectl drain <NODE-NAME>

The command will tell Kubernetes to not schedule any __new__ jobs on the node and evict all __currently running__ Jobs. Kubernetes will attempt to immediately schedule evicted Jobs to other nodes. 

You can then safely shutdown the node. When the node is up again, run:

    kubectl uncordon <NODE-NAME>

The command tells Kubernetes that the node is ready again to accept Jobs.


## Node Memory Management

It is possible for researchers to over-allocate memory to the extent that, if not managed properly,  will destabilize the chosen node  (machine). 

### Symptoms

1. The node enters the "NotReady" state, and won't be "Ready" again until the resource issues have been fixed. This issue appears on certain versions of _kubelet_ (1.17.4 for example), that have a bug which causes kubelet to not recover properly when encountering certain errors, and must be restarted manually.

2. SSH to the node and overall node access can be very slow.

3. When running "top" command, Memory availability appears to be low.

To make sure the node remains stable regardless of any pod resources issues, Kubernetes offers two features to control the way resources are managed on the nodes:

### Resource Reservation

Kubernetes offers two variables that can be configured as part of _kubelet_ configuration file:

*   systemReserved
*   kubeReserved

When configured, these two variables "tell" kubelet to preserve a certain amount of resources for system processes (kernel, sshd, .etc) and for Kubernetes node components (like kubelet) respectively.

When configuring these variables alongside a third argument that is configured by default ( --enforce-node-allocatable), _kubelet_ limits the amount of resources that can be consumed by pods on the node (Total Amount - kubeReseved - systemReserved), based on a Linux feature called _cgroup_. 

 This limitation ensures that in any situation where the total amount of memory consumed by pods on a node grows above the allowed limit, Linux itself will start to evict pods that consume more resources than requested. This way, important processes are guaranteed to have a minimum amount of resources available. 

To configure, edit the file _/etc/kubernetes/kubelet-config.yaml_ and add the following:

``` yaml
kubeReserved:
  cpu: 100m
  memory: 1G
systemReserved:
  cpu: 100m
  memory: 1G
```


###  Eviction 

 Another argument that can be passed to _kubelet_ is evictionHard, which specifies an absolute amount of memory that should always be available on the node. Setting this argument guarantees that critical processes might have extra room to expand __above__ their reserved resources in case they need to and prevent starvation for those processes on the node. 

 If the amount of memory available on the nodes drops below the configured value, _kubelet_ will start to evict pods on the node. 

 This enforcement is made by kubelet itself, and therefore less reliable, but it lowers the chance for resource issues on the node, and therefore recommended for use. To configure, please update the file  _/etc/kubernetes/kubelet-config.yaml_ with the following: 

``` yaml

evictionHard:
  memory.available: "500Mi"
  # Default value for evictionHard on kubelet
  nodefs.available: "10%"
  nodefs.inodesFree: "5%"
  imagefs.available: "15%"

```

 Please note that specifying values for evictionHard will override the default values on kubelet which are of very high importance.
 For further reading please refer to <https://kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/>.
