# Configure BCM Kubernetes for Run:ai

## Label the Run:ai control plane  nodes

Label the nodes using CMSH:

```
cmsh
kubernetes
labelsets
add runai-control-plane
append categories runai-control-plane
append labels 
node-role.kubernetes.io/runai-system=true
commit
```

!!! Note
    the names of the categories are arbitrary names so they may vary depending on the customer choice or any other preference. Make sure that you label the correct category. Mixing labels will result in pods running on incorrect nodes or not being scheduled at all.


## Create the CPU worker node ConfigurationOverlay

The default Kubernetes worker ConfigurationOverlay initializes `containerd` with the NVIDIA Container Toolkit plugin runtime. This is not desirable on nodes with GPU resources and can lead to problems when certain workloads deploy (minimal containers that cannot handle the Toolkit’s CRI initialization. For that reason, it is recommended to create a separate configuration overlay for those nodes:

```
root@bcmhead1:~/certs# cmsh
[bcmhead1]% configurationoverlay
[bcmhead1->configurationoverlay]% clone kube-dra-worker kube-dra-worker-cpuonly
[bcmhead1->configurationoverlay*[kube-dra-worker-cpuonly*]->roles[generic::containerd]]% configurations
[bcmhead1->configurationoverlay*[kube-dra-worker-cpuonly*]->roles[generic::containerd]->configurations*]% remove containerd-nvidia-cri
[bcmhead1->configurationoverlay*[kube-dra-worker-cpuonly*]->roles*[generic::containerd*]->configurations*]% commit
```

After that you need to extend the worker node label to members of the new ConfigurationOverlay:
```
[bcmhead1]% kubernetes
[bcmhead1->kubernetes[dra]]% labelsets
[bcmhead1->kubernetes[dra]->labelsets]% use worker
[bcmhead1->kubernetes[dra]->labelsets[worker]]% append overlays kube-dra-worker-cpuonly
[bcmhead1->kubernetes*[dra*]->labelsets*[worker*]]% commit
```

and finally move  the CPU worker nodes to the new ConfigurationOverlay:
```
[bcmhead1->configurationoverlay]% removefrom kube-dra-worker categories runai-control-plane
[bcmhead1->configurationoverlay*]% append kube-dra-worker-cpuonly categories runai-control-plane
[bcmhead1->configurationoverlay*]% commit
```

The syntax is as follows:

```
`[append | removefrom]  <ConfigurationOverlay name>  [categories | nodes] <BCM category or node name>`
```