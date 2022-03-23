## Why?

In some business scenarios, you may want to direct the Run:ai scheduler to schedule a Workload to a specific node or a node group. For example, in some academic institutions, Hardware is bought using a specific grant and thus "belongs" to a specific research group.

Run:ai allows this "taint" by labeling a node, or a set of nodes and then during scheduling, using the flag `--node-type <label>` to force this allocation

!!! Important
    There is a tradeoff to be weighed in when allowing Researchers to designate specific nodes. Overuse of this feature limits the scheduler in finding an optimal resource and thus reduces overall cluster utilization.


## Configuring Node Groups

To configure a node group:

*   Get the names of the nodes where you want to limit Run:ai. To get a list of nodes, run:

        kubectl get nodes

*   For each node run the following:

        kubectl label node <node-name> run.ai/type=<label>

The same value can be set to a single node, or for multiple nodes.

A node can only be set with a single value

## Using Node Groups via the CLI

Use the node type label with the --node-type flag, such as:

    runai submit job1 ... --node-type "my-nodes"

See the [runai submit](../../Researcher/cli-reference/runai-submit.md) documentation for further information

## Assigning Node Groups to a Project

To assign specific node groups to a Project see [working with Projects](../admin-ui-setup/project-setup.md).

When the CLI flag is used in conjunction with Project-based affinity, the flag is used to refine the list of allowable node groups set in the Project.