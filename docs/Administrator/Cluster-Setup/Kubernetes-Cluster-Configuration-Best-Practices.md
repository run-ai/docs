# Node Memory Management

It is possible for researchers to over-allocate memory to the extent that, if not managed properly,&nbsp; will destabilize the chosen node&nbsp; (machine).&nbsp;

## Symptoms

1. The node enters the "NotReady" state, and won't be "Ready" again until the resource issues have been fixed. This issue enhances on certain versions of kubelet (1.17.4 for example), that have a bug which causes kubelet to not recover properly when encountering certain errors, and must be restarted manually.

2. SSH to the node and overall node access can be very slow.

3. When running "top" command, Memory availability appears to be low.

To make sure the node remains stable regardless of any pod resources issues, Kubernetes offers two features to control the way resources are managed on the nodes:

## Resource Reservation

Kubernetes offers two variables that can be configured as part of kubelet configuration file:

*   systemReserved
*   kubeReserved

When configured, these two variables "tell" kubelet to preserve a certain amount of resources for system processes (kernel, sshd, .etc) and for Kubernetes node components (like kubelet) respectively.

When configuring these variables alongside a third argument that is configured by default (<span>--enforce-node-allocatable), kubelet limits the amount of resources that can be consumed by pods on the node (Total Amount - kubeReseved - systemReserved), based on a Linux feature called cgroup.</span>

<span>This limitation ensures that in any situation where the total amount of memory consumed by pods on a node grows above the allowed limit, Linux itself will start to evict pods that consume more resources than requested. This way, important processes are guaranteed to have a minimum&nbsp;amount of resources available.</span>

To configure, edit the file&nbsp;_/etc/kubernetes/kubelet-config.yaml_&nbsp;and add the following:

<pre>kubeReserved:<br/> cpu: 100m<br/> memory: 1G<br/>systemReserved:<br/> cpu: 100m<br/> memory: 1G</pre>

## <span>Eviction</span>

<span>Another argument that can be passed to kubelet is evictionHard, which specifies an absolute amount of memory that should always be available on the node. Setting this argument guarantees that critical processes might have extra room to expand __above__ their reserved resources in case they need to and prevent starvation for those processes on the node.</span>

<span>If the amount of memory available on the nodes drops below the configured value, kubelet will start to evict pods on the node.</span>

<span>This enforcement is made by kubelet itself, and therefore less reliable, but it lowers the chance for resource issues on the node, and therefore recommended for use. To configure, please update the file&nbsp; _/etc/kubernetes/kubelet-config.yaml_ with the following:</span>

<pre><span>evictionHard:<br/> memory.available: "500Mi"</span></pre>

<span>For further reading please refer to&nbsp;<https://kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/> &nbsp;</span>