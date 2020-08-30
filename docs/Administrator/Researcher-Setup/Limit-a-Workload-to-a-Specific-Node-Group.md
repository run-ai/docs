## Why?

In some business scenarios, you may want to direct the Run:AI scheduler to schedule a Workload to a specific node or a node group. For example, in some academic institutions, hardware is bought using a specific grant and thus "belongs" to a specific research group.

Run:AI allows this "taint" by labeling a node, or a set of nodes and then during scheduling, using the flag ``--node-type <label>`` to force this allocation


## Configuring Node Groups

To configure a node group:

*   Get the names of the nodes where you want to limit Run:AI. To get a list of nodes, run:

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

To assign specific node groups to a project see [working with projects](../Admin-User-Interface-Setup/Working-with-Projects.md).

When the CLI flag is used in conjunction with Project-based affinity, the flag is used to refine the list of allowable node groups set in the project.