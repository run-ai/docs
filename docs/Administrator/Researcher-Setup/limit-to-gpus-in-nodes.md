## Why?

In a gradual approach for incorporating Run:AI in a research operation, it is possible that some researchers are using the system with Run:AI and some without.

It is, therefore, possible to limit Run:AI to use specific nodes and specific GPUs within these nodes.


## How?

To configure restrictions on certain nodes:

*   Get the names of the nodes where you want to limit Run:AI and the GPU indices inside these nodes where you want Run:AI to be __enabled__. For example. let’s say you want Run:AI scheduling for GPUs 1 and 3 on node\_2, GPUs 0 and 2 on node\_4, and for all GPUs on every other node.
*   Run the following command:

        kubectl create configmap nvidia-device-plugin-config -n runai \
        --from-literal node_2=“1,3” --from-literal node_4=“0,2" && \
        kubectl delete pod -n runai -l app=pod-gpu-metrics-exporter && \
        kubectl delete pod -n runai -l name=nvidia-device-plugin-ds

__Note__: if names of nodes contain dashes/hyphens (‘-’), they should be replaced with underscores (‘\_’) inside the command from step 2 (e.g if a node is called node-2, we will write it as node\_2 in the command).