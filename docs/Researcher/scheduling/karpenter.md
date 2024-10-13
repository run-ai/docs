# Interworking with Karpenter

Karpenter is an open-source, Kubernetes cluster autoscaler built for cloud deployments. Karpenter optimizes the cloud cost of a customer’s cluster by moving workloads between different node types, consolidating workloads into fewer nodes, using lower-cost nodes where possible, scaling up new nodes when needed, and shutting down unused nodes.

Karpenter’s main goal is cost optimization. Unlike Karpenter, Run:ai’s scheduler optimizes for fairness and resource utilization. Therefore, there are a few potential friction points when using both on the same cluster.

## Friction points using Karpenter with Run:ai

1.  Karpenter looks for “unschedulable” pending workloads and may try to scale up new nodes to make those workloads schedulable. However, in some scenarios, these workloads may exceed their quota parameters, and the Run:ai scheduler will put them into a pending state.
2.  Karpenter is not aware of the Run:ai fractions mechanism and may try to interfere incorrectly.
3.  Karpenter preempts any type of workload (i.e., high-priority, non-preemptible workloads will potentially be interrupted and moved to save cost).
4.  Karpenter has no pod-group (i.e., workload) notion or gang scheduling awareness, meaning that Karpenter is unaware that a set of “arbitrary” pods is a single workload. This may cause Karpenter to schedule those pods into different node pools (in the case of multi-node-pool workloads) or scale up or down a mix of wrong nodes.

### Mitigating the friction points

Run:ai scheduler mitigates the friction points using the following techniques (each numbered bullet below corresponds to the related friction point listed above):

1.  Karpenter uses a “nominated node” to recommend a node for the scheduler. The Run:ai scheduler treats this as a “preferred” recommendation, meaning it will try to use this node, but it’s not required and it may choose another node.
2.  Fractions - Karpenter won’t consolidate nodes with one or more pods that cannot be moved. The Run:ai reservation pod is marked as ‘do not evict’ to allow the Run:ai scheduler to control the scheduling of fractions.
3.  Non-preemptible workloads - Run:ai marks non-preemptible workloads as ‘do not evict’ and Karpenter respects this annotation.
4.  Run:ai node pools (single-node-pool workloads) - Karpenter respects the ‘node affinity’ that Run:ai sets on a pod, so Karpenter uses the node affinity for its recommended node. For the gang-scheduling/pod-group (workload) notion, Run:ai scheduler considers Karpenter directives as preferred recommendations rather than mandatory instructions and overrides Karpenter instructions where appropriate.

### Deployment Considerations

*   Using multi-node-pool workloads
    *   Workloads may include a list of optional nodepools. Karpenter is not aware that only a single node pool should be selected out of that list for the workload. It may therefore recommend putting pods of the same workload into different node pools and may scaleup nodes from different node pools to serve a “multi-node-pool” workload instead of nodes on the selected single node pool.
    *   If this becomes an issue (i.e., if Karpenter scales up the wrong node types), users can set an inter-pod affinity using the node pool label or another common label as a ‘topology’ identifier. This will force Karpenter to choose nodes from a single-node pool per workload, selecting from any of the node pools listed as allowed by the workload.
    *   An alternative approach is to use a single-node pool for each workload instead of multi-node pools.
*   Consolidation
    *   To make Karpenter more effective when using its consolidation function, users should consider separating preemptible and non-preemptible workloads, either by using node pools, node affinities, taint/tollerations, or inter-pod anti-affinity.
    *   If users don’t separate preemptible and non-preemptible workloads (i.e., make them run on different nodes), Karpenter’s ability to consolidate (binpack) and shut down nodes will be reduced, but it is still effective.
*   Conflicts between binpacking and spread policies
    *   If Run:ai is used with a scheduling spread policy, it will clash with Karpenter’s default binpacks/consolidation policy, and the outcome may be a deployment that is not optimized for any of these policies.
    *   Usually spread is used for Inference, which is non-preemptible and therefore not controlled by Karpenter (Run:ai scheduler will mark those workloads as ‘do not evict’ for Karpenter), so this should not present a real deployment issue for customers.