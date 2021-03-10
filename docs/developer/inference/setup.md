# MPS Setup
By default, MPS is not enabled on the GPU nodes.

## Enabling MPS 
In order to enable the MPS server on all nodes, use the following command:
``` bash
 kubectl patch runaiconfig runai -n runai --type='json' -p='[{"op": "add", "path": "/spec/mps-server", "value": {"enabled": true }}]''
```
In order to enable the MPS server on selected nodes, please contact runai support:

Wait for the MPS server to start running.
``` bash
 kubectl get pods -n runai
```

After the pod MPS server has started to run, restart the nvidia-device-plugin pods:
``` bash
kubectl delete pods -n runai --selector=name=nvidia-device-plugin-ds
```




