## Node Memory Management

It is possible for researchers to over-allocate memory to the extent that, if not managed properly,  will destabilize the chosen node  (machine). 

### Symptoms

1. The node enters the "NotReady" state, and won't be "Ready" again until the resource issues have been fixed. This issue enhances on certain versions of kubelet (1.17.4 for example), that have a bug which causes kubelet to not recover properly when encountering certain errors, and must be restarted manually.

2. SSH to the node and overall node access can be very slow.

3. When running "top" command, Memory availability appears to be low.

To make sure the node remains stable regardless of any pod resources issues, Kubernetes offers two features to control the way resources are managed on the nodes:

### Resource Reservation

Kubernetes offers two variables that can be configured as part of kubelet configuration file:

*   systemReserved
*   kubeReserved

When configured, these two variables "tell" kubelet to preserve a certain amount of resources for system processes (kernel, sshd, .etc) and for Kubernetes node components (like kubelet) respectively.

When configuring these variables alongside a third argument that is configured by default ( --enforce-node-allocatable), kubelet limits the amount of resources that can be consumed by pods on the node (Total Amount - kubeReseved - systemReserved), based on a Linux feature called cgroup. 

 This limitation ensures that in any situation where the total amount of memory consumed by pods on a node grows above the allowed limit, Linux itself will start to evict pods that consume more resources than requested. This way, important processes are guaranteed to have a minimum amount of resources available. 

To configure, edit the file _/etc/kubernetes/kubelet-config.yaml_ and add the following:

    kubeReserved:
      cpu: 100m
      memory: 1G
    systemReserved:
      cpu: 100m
      memory: 1G

###  Eviction 

 Another argument that can be passed to kubelet is evictionHard, which specifies an absolute amount of memory that should always be available on the node. Setting this argument guarantees that critical processes might have extra room to expand __above__ their reserved resources in case they need to and prevent starvation for those processes on the node. 

 If the amount of memory available on the nodes drops below the configured value, kubelet will start to evict pods on the node. 

 This enforcement is made by kubelet itself, and therefore less reliable, but it lowers the chance for resource issues on the node, and therefore recommended for use. To configure, please update the file  _/etc/kubernetes/kubelet-config.yaml_ with the following: 

    evictionHard:
      memory.available: "500Mi"

 For further reading please refer to <https://kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/>   