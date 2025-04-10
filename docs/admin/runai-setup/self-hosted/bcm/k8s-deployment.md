
# Validations

TBD: Oz to decide

## Validate Kubernetes Connectivity

1. Retrieve the Kube config file (/root/.kube/config-default on a BCM headnode)  and configure kube context in order to manage the kubernetes cluster. If you want to interact with Kubernetes  from another system, copy the KUBECONFIG to the other system ($HOME/.kube/config or set the KUBECONFIG environment variable pointing to the file) and modify it as following:
    ```
    apiVersion: v1
    clusters:
    - cluster:
        insecure-skip-tls-verify: true   ### ADD THIS LINE
        server: https://bcm-runai-1.nvidia.com:10443 ### Change to the FQDN
        certificate-authority-data: ... ### DELETE THIS LINE
    name: kubernetes
    contexts:
    - context:
        cluster: kubernetes
        user: kubernetes-admin
    name: kubernetes-admin@kubernetes
    current-context: kubernetes-admin@kubernetes
    kind: Config
    preferences: {}
    users:
    - name: kubernetes-admin
    user:
        client-certificate-data:...
        client-key-data: ...
    ```

2. You can tunnel over  SSH the traffic to the K8S API server with the following command:
    ```
    ssh -fNT -L 10443:localhost:10443 root@<IP address of BCM headnode>
    ```

3. If you want to run the kubectl command directly on the BCM headnode load the module first:
    ```
    module load shared kubernetes
    ```

4. This step should have been completed in prior steps above. However, you can verify your connection with the following command:
    ```
    kubectl cluster-info
    Kubernetes control plane is running at https://localhost:8888
    CoreDNS is running at https://localhost:8888/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    ```

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'. 

## Validate the Calico CNI Discovery CIDR

```
root@headnode:~# cmsh
[headnode]% kubernetes
[headnode->kubernetes[default]]% appgroups
[headnode->kubernetes[default]->appgroups]% use system
[headnode->kubernetes[default]->appgroups[system]]% applications
[headnode->kubernetes[default]->appgroups[system]->applications]% use calico
[headnode->kubernetes[default]->appgroups[system]->applications[calico]]% environment
```
Make sure that the CIDR shown spans the network range of both the DGX and Dell worker node Ethernet networks.

## BCM Prerequisites

The items below are non-default DGX SuperPOD items which need special attention prior to proceeding with the installation of K8S and Run:ai.  Pay special attention that these are incorporated before proceeding with the installation

* BCM has been deployed and HA has been configured with shared storage as per the [DGX SuperPOD runbook](https://docs.nvidia.com/dgx-superpod-deployment-guide-dgx-a100.pdf).
* All the networks that will be used for Kubernetes nodes have the same MTU.
* The NVIDIA OFED has been installed in the **all **of the used software-images
* The VAST Multi-path or DDN EXA Lustre driver has been installed in **all **of the used the software image and the Lustre/VAST has been mounted on all DGX and K8S  nodes using a BCM FSMount
* Enable SR-IOV in the DGX H100 image by ensuring that the following kernel parameters are included: **intel_iommu=on iommu=pt (H100) **or **amd_iommu=on iommu=pt (H100). **After that, enable SR-IOV on the Mellanox HCAs, set the number of VFs to the desired number and reboot the DGX nodes.

For example:
```
root@bcmhead1:~# cmsh
[bcmhead1]% softwareimage use dgx-os-6.3-h100-image
[bcmhead1->softwareimage[dgx-os-6.3-h100-image]]% append kernelparameters  " intel_iommu=on"
[bcmhead1->softwareimage*[dgx-os-6.3-h100-image*]]% commit
```

Note the leading whitespace in `“ intel_iommu=on” above.`

* The /var filesystem of the headnodes, CPU and DGX compute nodes have **at least 100GB** of space available. **DO NOT** proceed with installing Kubernetes until  this requirement is met on the control plane nodes.

Run the following command on the headnode to verify requirement:
```
pdsh -g category=dgx-a100,k8s-control-plane,runai-control-plane df -h /var
```

* Ensure that NVME disk devices are named consistently across reboots. See [Appendix C](?tab=t.0#heading=h.afp9y7rd26kr) for instructions and example disk layouts.
* The following three BCM node categories and software images need to be present:
 
   * A node category for the DGX H100 nodes with a DGX Base OS software image (DGX OS 6.1 tested).
   * A node category for the Kubernetes master nodes (3 DGX SuperPOD management nodes - Dell R760 tested) with an Ubuntu 22.04 software image.
   * A node category for the Run:ai control plane nodes (2 DGX SuperPOD management nodes - Dell R760 tested) with an Ubuntu 22.04 software image.  We assume below (section 7.1) that this is called `runai-control-plane`

* All compute nodes have been assigned to the right category, are provisioned and are up and running.




