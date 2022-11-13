## Why?

In some business scenarios, you may want to direct the Run:ai scheduler to schedule a Workload to a specific node or a node group. For example, in some academic institutions, Hardware is bought using a specific grant and thus "belongs" to a specific research group. Another example is an inference workload that is optimized to a specific GPU type and must have dedicated resources reserved to ensure enough capacity.

Run:ai provides two methods to designate and group specific resources:
- Node Pool
    Run:ai allows administrators to group specific nodes by label into a node pool. A node pool is a group of nodes identified by a given name (node pool name) and grouped by any label (key and value combination) an administrator choses to use for that, either by using a preset label (such as gpu-type=a100) or setting your own label on a set on nodes.
- Node Affinity
    Run:ai allows this "taint" by labeling a node, or a set of nodes and then during scheduling, using the flag `--node-type <label>` to force this allocation

!!! Important
    One can set and use both node pool and node affinity combined as a prerequisite to the scheduler, for example if a researcher wants to use an T4 node with Infiniband card - she can use a node pool of T4 and from that group chose only the nodes with Infiniband card (node-type = infiniband).
    There is a tradeoff to be weighed in when allowing Researchers to designate specific nodes. Overuse of this feature limits the scheduler in finding an optimal resource and thus reduces overall cluster utilization.


## Configuring Node Groups

To configure a node pool:
*   Find the label key & value you want to use for Run:ai to create a node pool.

*   Check that the nodes you want to group as a pool have a unique label to use, otherwise you should mark those nodes with your own uniquely identifiable label.

*   Get the names of the nodes you want Run:ai to group. To get a list of nodes, run:

    kubectl get nodes
    Kubectl get nodes --show-labels

*   If you chose to set your own label, run the following:

        kubectl label node <node-name> <label-key>=<label-value>

*   The same value can be set to a single node, or multiple nodes.

*   Node Pool can only use one label (key & value) at a time.

*   To create node pool use Run:ai API:
        /v1/k8s/clusters/{clusterId}/node-pools:
            clusterId (string): Unique identifier of the cluster
            Example:
            {
                "name": "node-pool-a",
                "labelKey": "gpu-type",
                "labelValue": "T4"
            }


To configure a node affinity:

*   Get the names of the nodes where you want to limit Run:ai. To get a list of nodes, run:

        kubectl get nodes

*   For each node run the following:

        kubectl label node <node-name> run.ai/type=<label>

The same value can be set to a single node, or for multiple nodes.

A node can only be set with a single value

## Using Node Groups via the CLI

To use Run:ai node pool with a workload, use Run:ai CLI command ‘node-pool’: 
    runai submit job1 ... --node-pool "my-pool"

To use node affinity, use the node type label with the --node-type flag, such as:

    runai submit job1 ... --node-type "my-nodes"

Researcher may combine the two flags together to select both a node pool and specific set of nodes out of that node pool (e.g. gpu-type=t4 and node-type=infiniband):
runai submit job1 ... --node-pool-name “my pool” --node-type "my-nodes"
Note! When submitting a workload, if you chose a node pool label and node affinity (node type)label which do not intersect, Run:ai schduler will not be able to schedule that workload as it represents an empty nodes group.

See the [runai submit](../../Researcher/cli-reference/runai-submit.md) documentation for further information

## Assigning Node Groups to a Project

Node Pools are automatically assigned to all Projects and Departments with zero resource allocation as default. Allocating resources to a node pool can be done for each Project and Department an administrator wants to add resources to. Submitting a workload to a node pool that has zero allocation for a specific project (or department) results in that workload running as an over-quota workload.

To assign and configure specific node affnity groups or node pools to a Project see [working with Projects](../admin-ui-setup/project-setup.md).

When the CLI flag is used in conjunction with Project-based affinity, the flag is used to refine the list of allowable node groups set in the Project.