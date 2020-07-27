## Why?

Sometimes you have a Kubernetes cluster which is not dedicated to Run:AI. 

It is possible for Run:AI to be installed on all nodes, but to only schedule jobs on specific nodes. See  __Node Group Affinity__ under [Working with Projects](../Admin-User-Interface-Setup/Working-with-Projects.md#limit-jobs-to-run-on-specific-node-groups). With this scheme, Run:AI is still installed on all nodes.

You can also choose to limit Run:AI to install only on specific nodes. Note that if you do that, you will lose the benefits of Node visibility of the Run:AI Administration User Interface.

## How?

Set a label on the Nodes you want Run:AI to run on: 

    kubectl label node <node-name> run.ai/type=<label>

Where ``<label>`` can be a Kubernetes label of your choosing.

Then run the following:

    kubectl patch runaiconfig runai -n runai --type='json' \
        -p='[{"op": "add", "path": "/spec/gpu-metrics-exporter/gpuLabel", "value": "run.ai/type"}]'
    kubectl patch runaiconfig runai -n runai --type='json' \
        -p='[{"op": "add", "path": "/spec/nvidia-device-plugin", "value": {"gpuLabel": "run.ai/type"}}]'
    kubectl patch runaiconfig runai -n runai --type='json' \
        -p='[{"op": "add", "path": "/spec/memory-manager/gpuLabel", "value": "run.ai/type"}]'
    kubectl patch runaiconfig runai -n runai --type='json' \
        -p='[{"op": "add", "path": "/spec/prometheus-operator/prometheus-node-exporter", "value": {"nodeSelector": {"run.ai/type": "<label>"}}}]'

In the  command above, replace ``<label>`` with the label you have created.