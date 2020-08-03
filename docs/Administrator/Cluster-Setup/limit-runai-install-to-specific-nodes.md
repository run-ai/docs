## Why?

Sometimes you have a Kubernetes cluster which is not dedicated to Run:AI. 
You can choose to limit Run:AI to install only on specific nodes. Note that if you do that, you will lose the benefits of Node visibility of the Run:AI Administration User Interface.

## How?

Set a label on the Nodes you want Run:AI to run on: 

    kubectl label node <node-name> run.ai/enable.scheduling="true"

Then run the following:

    kubectl patch runaiconfig runai -n runai --type='json' \
        -p='[{"op": "add", "path": "/spec/gpu-metrics-exporter/gpuLabel", "value": "run.ai/enable.scheduling"}]'
    kubectl patch runaiconfig runai -n runai --type='json' \
        -p='[{"op": "add", "path": "/spec/nvidia-device-plugin", "value": {"gpuLabel": "run.ai/enable.scheduling"}}]'
    kubectl patch runaiconfig runai -n runai --type='json' \
        -p='[{"op": "add", "path": "/spec/memory-manager/gpuLabel", "value": "run.ai/enable.scheduling"}]'
    kubectl patch runaiconfig runai -n runai --type='json' \
        -p='[{"op": "add", "path": "/spec/prometheus-operator/prometheus-node-exporter", "value": {"nodeSelector": {"run.ai/enable.scheduling": "true"}}}]'
