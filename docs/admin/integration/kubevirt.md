# Scheduling Virtual Machines using Run:ai

Many organizations use virtual machines (VMs) to provide operating system abstraction to users. Containers are different than VMs but serve a similar purpose. Containers at a large scale are best managed by Kubernetes and Run:ai is based on Kubernetes. 

It is possible to mix and match containers and VMs to some extent using a technology called [KubeVirt]( https://kubevirt.io){target=_blank}. KubeVirt allows running VMs inside containers on top of Kubernetes. 

This article describes how to use KubeVirt to schedule VMs with GPUs.

## Limitations

Each node in the cluster will be able to support either VMs or containers - not combined.

GPU fractions are not supported. 

## Preparations

Making GPUs visible to VMs is not trivial. It requires either a license for NVIDIA software called [NVIDIA vGPU](https://www.nvidia.com/en-us/data-center/virtual-solutions/){target=_blank} or creating a GPU passthrough by the explicit mapping of GPU devices to virtual machines. This guide relates to the latter option. 

### Install KubeVirt

Install KubeVirt using the following [guide](https://kubevirt.io/quickstart_cloud/){target=_blank}.

### Dedicate specific nodes for VMs

Dedicate specific nodes within the cluster to be used for VMs and not containers - following the [guide](https://kubevirt.io/user-guide/operations/installation/#restricting-kubevirt-components-node-placement){target=_blank}.

Specifically, restrict `virt-controller`, `virt-api ` and `virt-handler` pods to only run on the nodes you want to be used for VMs.

### Assign host devices to virtual machines

For each node in the cluster that we want to use with VMs we must:

* Identify all GPU cards we want to dedicate to be used by VMs.
* Map GPU cards for KubeVirt to pick up (called _assigning host devices to a virtual machine_).

Instructions for identifying GPU cards are operating-system-specific. For Ubuntu 20.04 run:

``` bash
lspci -nnk -d 10de:
```

Search for GPU cards that are marked with the text _Kernel driver in use_. Save the PCI Address, for example: __10de:1e04__

!!! Important
    Once exposed, these GPUs cannot be used by regular pods. Only VMs. 




To expose the GPUs and map them to KubeVirt follow the instructions [here](https://kubevirt.io/user-guide/virtual_machines/host-devices/){target=_blanks}. Specifically, run:


```
kubectl edit kubevirt -n kubevirt -o yaml
```

And add all of the PCI Addresses of all GPUs of all Nodes concatenated by commas, with the resource name _kubevirt/vmgpu_:

``` YAML
spec:
  certificateRotateStrategy: {}
  configuration:
    developerConfiguration:
      featureGates:
      - GPU
      - HostDevices
    permittedHostDevices:
      pciHostDevices:
      - pciVendorSelector: <PCI-ADDRESS>,<PCI-ADDRESS>,
        resourceName: kubevirt/vmgpu
```

### Assign GPUs to VMs

You must create a CRD called _vm_ for each virtual machine. `vm` is a reference to a virtual machine and its capabilities.

The Run:ai project is matched to a Kubernetes namespace. Unless manually configured, the namespace is `runai-<PROJECT-NAME>`. __Per Run:ai Project__, create a `vm` object. See KubeVirt [documentation](https://kubevirt.io/labs/kubernetes/lab1) example. Specifically, the created YAML should look like this:


``` YAML
spec:
  running: false
  template:
    metadata:
      creationTimestamp: null
      labels:
....
        priorityClassName: <WORKLOAD-TYPE>
        project: <PROJECT-NAME>
    spec:
      schedulerName: runai-scheduler
      domain:
        devices:
          gpus:
          - deviceName: kubevirt/vmgpu # identical name to resourceName above
            name: gpu1  # name here is arbitrary and is not used. 
```

Where `<WORKLOAD-TYPE>` is `train` or `build`

### Turn on KubeVirt feature in Run:ai

* If you want to upgrade the runai cluster, use the [instructions](../../runai-setup/cluster-setup/cluster-upgrade/){target=_blank}. 
  
    * During the upgrade, customize the cluster installation by adding the following to the values.yaml file:

    ``` YAML
    global:
      kubevirtCluster:
        enabled: true
    ```

* If you don't want to upgrade the whole cluster, you can add those values to your existing values.yaml file.

    * Then, run the command:

    ```
    helm upgrade runai-cluster runai/runai-cluster -n runai -f values.yaml
    ```

* Make sure the `kubevirtCluster: enabled` flag is still turned on in `runaiconfig`:

    ```
    kubectl edit runaiconfig runai -n runai
    ```

## Start a VM

Run:

```
virtctl start testvm -n runai-test
```

You can now see the VMs pod in Run:ai.

```
runai list -A
NAME    STATUS   AGE  NODE         IMAGE                                   TYPE  PROJECT  USER  GPUs Allocated (Requested)  PODs Running (Pending)  SERVICE URL(S)
testvm  Running  0s   master-node  quay.io/kubevirt/virt-launcher:v0.47.1        test           1 (1)                       1 (0)
```




