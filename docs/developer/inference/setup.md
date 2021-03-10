# Inference Setup

Inference Jobs are an integral part of Run:AI and do not require setting up per-se. However, Running multiple production-grade processes on a single GPU is best performed with an NVIDIA technology called _Multi-Process Service_ or _MPS_

By default, MPS is not enabled on GPU nodes.

## Enabling MPS 

In order to enable the MPS server on all nodes, use the following command:

``` bash
 kubectl patch runaiconfig runai -n runai --type='json' -p='[{"op": "add", "path": "/spec/mps-server", "value": {"enabled": true }}]''
```

Wait for the MPS server to start running:

``` bash
 kubectl get pods -n runai
```

When the MPS server pod has started to run, restart the `nvidia-device-plugin` pods:

``` bash
kubectl delete pods -n runai --selector=name=nvidia-device-plugin-ds
```

To enable the MPS server on selected nodes, please contact Run:AI customer support.



