# System Requirements


## Pre-installation Checklist

The following checklist is provided for convenience and can be seen as part of an expanded site survey for Run:ai deployments on SuperPOD. This information needs to be collected and validated (as per the steps Chapter 2), before the actual Run:ai deployment begins.

| **Component** | **Type** | 
| --- | --- |
| [SSL] Full-chain SSL certificate | <*.p7b, *.der or *.pem file> | 
| [SSL] SSL Private Key | Private certificate (e.g. *.key) | 
| [SSL] CA trust chain public certificate | X509 PEM file | 
| [Networking] FQDN name/ Reserved IP address | DNS A or CNAME record pointing to the BCM headnode shared/floating IP or Load Balancer reserved IP | 
| [Networking]  Load Balancer IP address range | Additional IP address space (8 or more) for the Kubernetes LoadBalancer (Inference, DataMover workloads) | 
| [Storage] Lustre filesystem* | String (FS path) | 
| [Storage] Lustre MGS NIDs | String (Lustre NIDs) | 

## Installer Machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space
* Docker installed
* [Helm](https://helm.sh/) 3.14 or later

The configuration of BCM as well the deployment of Run:ai can be performed through SSH access on the BCM headnodes, TBD: Oz

## Hardware Requirements

The following hardware requirements are for the system and worker nodes. By default, all NVIDIA Run:ai  services run on all available nodes.

### NVIDIA Run:ai - System Nodes

This configuration is the minimum requirement you need to install and use NVIDIA Run:ai.

| Component  | Required Capacity |
| ---------- | ----------------- |
| CPU        | 20 cores          |
| Memory     | 42GB              |
| Disk space | 160GB             |


!!! Note
    To designate nodes to NVIDIA Run:ai system services, follow the instructions as described in [System nodes](../../../config/node-roles.md#system-nodes).

### NVIDIA Run:ai - Worker Nodes

NVIDIA Run:ai supports NVIDIA SuperPods built on the A100, H100, H200, and B200 GPU architectures. These systems are optimized for high-performance AI workloads at scale.

The following configuration represents the minimum hardware requirements for installing and operating the NVIDIA Run:ai on worker nodes. Each node must meet these specifications:

| Component | Required Capacity |
| --------- | ----------------- |
| CPU       | 2 cores           |
| Memory    | 4GB               |


!!! Note
    To designate nodes to NVIDIA Run:ai workloads, follow the instructions as described in [Worker nodes](../../../config/node-roles.md#worker-nodes).

### Node Categories

The following three BCM node categories and software images need to be present:

* A node category for the DGX H100 nodes with a DGX Base OS software image (DGX OS 6.1 tested). TBD: Oz do we want to keep these secific versions?
* A node category for the Kubernetes master nodes (3 DGX SuperPOD management nodes - Dell R760 tested) with an Ubuntu 22.04 software image.
* A node category for the Run:ai control plane nodes (2 DGX SuperPOD management nodes - Dell R760 tested) with an Ubuntu 22.04 software image. runai-control-plane TBD: Oz


### Default Storage Class

NVIDIA Run:ai requires a default storage class, local path, to create persistent volume claims for NVIDIA Run:ai storage. 
TBD: Oz

## Fully Qualified Domain Name (FQDN)

You must have a Fully Qualified Domain Name (FQDN) to install NVIDIA Run:ai control plane (ex: `runai.mycorp.local`). This cannot be an IP. The domain name must be accessible inside the organization's private network.

The DNS record needs to point to the IP address (A record) of the shared, alias interface that is active on the active BCM headnode (<NIC device name>:cmha i.e. eth0:cmha) or be a CNAME alias to a host DNS record pointing to that same IP address.

## TLS Certificate

You must have a TLS certificate that is associated with the FQDN for HTTPS access. The certificate will be installed on the Kubernetes control plane nodes as well as a [Kubernetes secret](#create-a-kubernetes-secret) for the Run:ai backend and the [NCM Kubernetes Ingress controller](#configure-the-nginx-proxy-tls-certificates).

* The certificate CN name needs to be equal to the [FQDN](#fully-qualified-domain-name-fqdn) name.
* The certificate needs to include at least one Subject Alternative Name DNS entry (SAN) for the same FQDN.
* The certificate needs to include the full trust chain (signing CA public keys).


## Software Requirements

The following software requirements must be fulfilled.

## Operating System

DGX OS is supported on your SuperPod and optimized for NVIDIA infrastructure.


### Kernel Parameters 

To enable SR-IOV in the DGX image, ensure the following kernel parameter is included: `intel_iommu=on`. Once configured, enable SR-IOV, set the number of Virtual Functions (VFs) to the desired amount, and reboot the DGX nodes. For example:

```
root@bcmhead1:~# cmsh
[bcmhead1]% softwareimage use dgx-os-6.3-h100-image
[bcmhead1->softwareimage[dgx-os-6.3-h100-image]]% append kernelparameters  " intel_iommu=on"
[bcmhead1->softwareimage*[dgx-os-6.3-h100-image*]]% commit
```

Note the leading whitespace in “ `intel_iommu=on`” above.


## Kubernetes 

1. From the active BCM headnode, run the `cm-kubernetes-setup` command. 

2. The following screen will pop up. Select **Deploy** and then click **Ok**:

    ![alt text](images/image.png)

    !!! Note
        The number of entries in the above menu may vary.

2. Select **Kubernetes v1.31** and then click **Ok**:

    ![alt text](images/image-1.png)

3. If you are reinstalling Kubernetes, the following screen will be shown. In this case, click **Ok** to proceed:

    ![alt text](images/image-2.png)

4. Optional: Provide a DockerHub container registry mirror if required and then click **Ok**. Otherwise, leave blank and click **Ok** to proceed:

    ![alt text](images/image-3.png)

5. Set the Kubernetes networks and then click **Ok**. The subnets need to be in a private address space (per RFC 1918). Use the default values and only modify if necessary or in case of conflict with other internal subnets within the network:

    ![alt text](images/image-4.png)

    !!! Note
        Make sure the domain names of the networks are configured correctly and modify as required to match the “Kubernetes External FQDN” using the same domain set in [FQDN](#fully-qualified-domain-name-fqdn).

6. Select **yes** to expose the Kubernetes API servers to the cluster’s external network and then click **Ok**:

    ![alt text](images/image-5.png)

    The external network is defined in the BCM’s base partition:
    ```
    cmsh -c "partition get base externalnetwork"
    ```
7. Select the internal network that will be used by the Kubernetes nodes and then click **Ok**:

    ![alt text](images/image-6.png)

8. Select at least 3 Kubernetes master nodes and then click **Ok**:

    ![alt text](images/image-7.png)

    !!! Note
        To ensure high availability and prevent a single point of failure, it is recommended to configure at least three system nodes in your cluster.

9. Select the BCM node categories for the Kubernetes worker nodes and then click **Ok**:

    ![alt text](images/image-8.png)

    !!! Note
        You need to choose both the DGX node and Run:ai control plane node categories outlined in [Node Categories](#node-categories).

10. Optional - “Choose individual Kubernetes worker nodes”  TUI screen - **DO NOT **make any selections in this step and instead hit the OK button to proceed to the next step. TBD: Oz so they should skip?

    ![alt text](images/image-9.png)

11. Select the Etcd nodes and then click **Ok**. Make sure to select the same three nodes as the Kubernetes master nodes (Step 8):

    ![alt text](images/image-10.png)

    Ignore the following message if it appears and click **Ok**:

    ![alt text](images/image-11.png)

12. Set the ports as shown below and then click **Ok**. Do not modify the Etcd spool directory:

    ![alt text](images/image-12.png)

13. Select **Calico** as the Kubernetes network plugin and then click **Ok**:

    ![alt text](images/image-13.png)

14. Do not install Kyverno during the initial deployment. It can always be enabled at a later stage. Select **no** and then click **Ok**:

    ![alt text](images/image-14.png)

### Operators

Select the following Operators and then click **Ok**:

![alt text](images/image-15.png)

!!! Note
    DO NOT select the Run:ai deployment operator in BCM10 at this stage as it is only relevant for Run:ai SaaS deployments.

#### NVIDIA GPU Operator

1. Select NVIDIA GPU Operator **v24.9.1** and then click **Ok**:
    ![alt text](images/image-16.png)


2. Leave the yaml configuration file path empty and then click **Ok**:
    ![alt text](images/image-18.png)


3. Configure the NVIDIA GPU Operator by selecting the following configuration parameters and then click **Ok**:
    ![alt text](images/image-19.png)

#### Network Operator

1. Select Network Operator **v24.7.0** and then click **Ok**:

    ![alt text](images/image-17.png)


2. Provide the following [Helm values YAML](https://gitlab-master.nvidia.com/kuberpod/runai-deployment-assets/-/raw/main/NetworkOperator/helm-values-sriov-nvipam.yaml?ref_type=heads): TBD: Oz

    ![alt text](images/image-40.png)


    !!! Note
        Do not add any MetalLB address pools at this point. Click **Ok** to proceed:
        ![alt text](images/image-20.png)

### Kubernetes Ingress Controller

1. Select **Ingress Controller (Nginx)** and then click **Ok**:
    ![alt text](images/image-21.png)

2. Select **yes** when asked to exposed the Ingress service over port 443 and then click **Ok**:
    ![alt text](images/image-22.png)

2. Keep the Ingress HTTPS port to 30443 (default value) and then click **Ok**:

    ![alt text](images/image-23.png)

### Permissions Manager

Click **yes** to install the BCM Kubernetes permissions manager and then click **Ok**:

![alt text](images/image-24.png)

### Storage Class


1. Select **Local path** as the Kubernetes StorageClass and then click **Ok**:

    ![alt text](images/image-25.png)


2. Put the storage class on the shared storage (/cm/shared – keep defaults) and then click **Ok**:

    ![alt text](images/image-26.png)

### Save your Configuration

Select **Save config & deploy** and then click **Ok**:

![alt text](images/image-27.png)

![alt text](images/image-28.png)

### Start Deployment

At this point the deployment will start. Half way through the deployment all nodes that are members of the Kubernetes cluster will be rebooted and the installer will wait up to 60 minutes for all nodes to come back online.


## NVIDIA Run:ai Namespaces

Create the following Kubernetes namespaces:

```
kubectl create ns runai-backend
kubectl create ns runai
```

!!! Note
    If you cannot use kubectl, load the Kubernetes Lmod module using `module load kubernetes`.

## Configure Kubernetes Ingress Controller

### Scale up the Ingress Deployment

For high availability, increase the number of replicas from 1 to 3:

```
# cmsh
[bcmhead1->device]% kubernetes
[bcmhead1->kubernetes[dra]]% appgroups
[bcmhead1->kubernetes[dra]->appgroups]% use system
[bcmhead1->kubernetes[dra]->appgroups[system]]% applications
[bcmhead1->kubernetes[dra]->appgroups[system]->applications]% use ingress_controller
[bcmhead1->kubernetes[dra]->appgroups[system]->applications[ingress_controller]]% environment
[bcmhead1->kubernetes[dra]->appgroups[system]->applications[ingress_controller]->environment]% set replicas  value 3
[bcmhead1->kubernetes*[dra*]->appgroups*[system*]->applications*[ingress_controller*]->environment*]% commit
```

### Configure the NGINX proxy TLS certificates

1. From the active BCM headnode, run the `cm-kubernetes-setup` command. 

2. The following screen will pop up. Select **Configure Ingress** and then click **Ok**:

    ![alt text](images/image-30.png)

2. Select the Kubernetes cluster and then click **Ok**:

    ![alt text](images/image-31.png)

3. Select **yes** when asked to provide signed certificates and then click **Ok**:

    ![alt text](images/image-32.png)

4. Enter the path to the private key and PEM certificate and then click **Ok**. See [TLS Certificate](#tls-certificate) for more details:

    ![alt text](images/image-33.png)


### Expose the Run:ai endpoint through MetalLB

NVIDIA Run:ai can be exposed either through a reverse HTTPS proxy from the two BCM headnodes or through the MetalLB Load Balancer/Route Advertiser. In the latter, additional configuration is needed to expose the Kubernetes Ingress. The following prerequisites must be met:

* MetalLB is deployed as part of the Kubernetes installation.
* A reserved range of IP addresses is available for the Load Balancer.
 
    * The IP addresses need to be routable from your corporate network.
    * The DNS record needs to point to one of the IP addresses from that range. That address will be reserved and allocated to the Kubernetes NGINX Ingress.
    * Ensure that no firewall is blocking connectivity to that IP address range.
    * Ensure that there are no conflicts.

1. Make sure the Kubernetes API proxy is configured with strict ARP validation:

    ```
    kubectl get configmap kube-proxy -n kube-system -o yaml | \
    sed -e "s/strictARP: false/strictARP: true/" | \
    kubectl apply -f - -n kube-system
    ```

2. Create a new appGroup application in BCM:

    ```
    root@bcmhead1:~# cmsh
    [bcmhead1]% kubernetes
    [bcmhead1->kubernetes[dra]]% appgroups
    [bcmhead1->kubernetes[dra]->appgroups]% use system
    [bcmhead1->kubernetes[dra]->appgroups[system]]% applications
    [bcmhead1->kubernetes[dra]->appgroups[system]->applications]% add ingress-metallb
    [bcmhead1->kubernetes*[dra*]->appgroups*[system*]->applications*[ingress-metallb*]]% set config /root/ingress-metallb.yaml
    [bcmhead1->kubernetes*[dra*]->appgroups*[system*]->applications*[ingress-metallb*]]% commit
    [bcmhead1->kubernetes[dra]->appgroups[system]->applications[ingress-metallb]]%
    ```
You will need to substitute the IP address with the reserved IP address. TBD: Oz substitute it where?
What the above does, is that it creates the MetalLB IP address pool and L2 advertisement CRDs:

```
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: l2-ingress
  namespace: metallb-system
spec:
  ipAddressPools:
  - ingress-pool
  nodeSelectors:
  - matchLabels:
   node-role.kubernetes.io/runai-system: "true"

---
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: ingress-pool
  namespace: metallb-system
spec:
  addresses:
  - <RESERVED IP>/32
  autoAssign: false
  serviceAllocation:
   priority: 50
   namespaces:
   - ingress-nginx
```

It also adds a new Ingress Kubernetes service:

```
---
apiVersion: v1
kind: Service
metadata:
  labels:
   app.kubernetes.io/component: controller
   app.kubernetes.io/instance: ingress-nginx
   app.kubernetes.io/name: ingress-nginx
   app.kubernetes.io/part-of: ingress-nginx
   app.kubernetes.io/version: 1.11.2
  name: ingress-nginx-controller-lb1
  namespace: ingress-nginx
spec:
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - appProtocol: http
   name: http
   port: 80
   protocol: TCP
   targetPort: http
  - appProtocol: https
   name: https
   port: 443
   protocol: TCP
   targetPort: https
  selector:
   app.kubernetes.io/component: controller
   app.kubernetes.io/instance: ingress-nginx
   app.kubernetes.io/name: ingress-nginx
  type: LoadBalancer
  loadBalancerIP: <RESERVED IP>
```

## Configure the Network Operator

The default deployment of the Network Operator installs the boiler-plate services, but does not initialize the SR-IOV and secondary network plugins. To that the following CRD resources have to be created in that exact order:

* SR-IOV Network Policies for each NVIDIA InfiniBand NIC
* An nvIPAM IP address pool
* SR-IOV InfiniBand networks

The new Network Operator YAML specs will work on Ampere, Hopper and Blackwell-based DGX systems. The above CRD YAML specs can be downloaded from the following Gitlab repo: https://gitlab-master.nvidia.com/kuberpod/runai-deployment-assets

1. Increase the number of simultaneous updates by the Network operator:
    ```
    kubectl patch sriovoperatorconfigs.sriovnetwork.openshift.io -n network-operator default --patch '{ "spec": { "maxParallelNodeConfiguration": 0 } }' --type='merge'
    ```
    and

    ```
    kubectl patch sriovoperatorconfigs.sriovnetwork.openshift.io -n network-operator default --patch '{ "spec": { "featureGates": { "parallelNicConfig": true  } } }' --type='merge'
    ```
2. Create the SR-IOV Network node policies:
    ```
    kubectl apply -f sriov-network-node-policy.yaml
    ```

    Adjust the number of Virtual Function (numVfs) as needed.

3. Create an IPAM IP Pool:
    ```
    kubectl apply -f nvipam-ip-pool.yaml
    ```

4. Create the SR-IOV IB networks:
    ```
    kubectl apply -f sriov-ib-network.yaml
    ```

!!! Note
    The e Network Operator will restart the DGX nodes if the number of Virtual Functions in the SR-IOV Network Policy file does not match the NVIDIA/Mellanox firmware configuration. TBD: Oz


## Additional Software Requirements

Additional NVIDIA Run:ai capabilities, Distributed Training and Inference require additional Kubernetes applications (frameworks) to be installed.

### Distributed Training

Distributed training enables training of AI models over multiple nodes. This requires installing a distributed training framework on the cluster. The following frameworks are supported:

* [TensorFlow](https://www.tensorflow.org/)
* [PyTorch](https://pytorch.org/)
* [XGBoost](https://xgboost.readthedocs.io/)
* [MPI](https://docs.open-mpi.org/)

All are part of the Kubeflow Training Operator. Run:ai supports Training Operator version 1.7. The Kubeflow Training Operator gets installed as part of the BCM Kubernetes Deployment.

The Kubeflow Training Operator is packaged with MPI version 1.0 which is not supported by Run:ai. You need to separately install MPI v2beta1:

1. Run the below to install MPI v2beta:
    ```
    kubectl create -f https://raw.githubusercontent.com/kubeflow/mpi-operator/v0.6.0/deploy/v2beta1/mpi-operator.yaml
    ```
2. Disable MPI in the Training operator by running:
    ```
    kubectl patch deployment training-operator -n kubeflow --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args", "value": ["--enable-scheme=tfjob", "--enable-scheme=pytorchjob", "--enable-scheme=xgboostjob"]}]'
    ``` 

3. Run: 
    ```
    kubectl delete crd mpijobs.kubeflow.org
    ```

4. Install MPI v2beta1 again:
    ```
    kubectl create -f https://raw.githubusercontent.com/kubeflow/mpi-operator/v0.6.0/deploy/v2beta1/mpi-operator.yaml
    # Ignore any errors in the above command
    kubectl replace -f https://raw.githubusercontent.com/kubeflow/mpi-operator/v0.6.0/deploy/v2beta1/mpi-operator.yaml
    ```


### Inference

Inference enables serving of AI models. This requires the [Knative Serving](https://knative.dev/docs/serving/) framework to be installed on the cluster and supports Knative versions 1.10 to 1.15.

Follow the [Installing Knative](https://knative.dev/docs/install/) instructions. After installation, configure Knative to use the NVIDIA Run:ai scheduler and features, by running:

1. Install the Knative CRDs:
    ```
    kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.15.0/serving-crds.yaml
    ```
2. Install Knative-serving:
    ```
    kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.15.0/serving-core.yaml
    ```
3. Deploy the Koerier Ingress:
    ```
    kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.15.0/kourier.yaml
    ```
4. Patch the Knative deployment:
    ```
    kubectl patch configmap/config-autoscaler   --namespace knative-serving   --type merge   --patch '{"data":{"enable-scale-to-zero":"true"}}'
    kubectl patch configmap/config-features   --namespace knative-serving   --type merge   --patch '{"data":{"kubernetes.podspec-schedulername":"enabled","kubernetes.podspec-affinity":"enabled","kubernetes.podspec-tolerations":"enabled","kubernetes.podspec-volumes-emptydir":"enabled","kubernetes.podspec-securitycontext":"enabled","kubernetes.podspec-persistent-volume-claim":"enabled","kubernetes.podspec-persistent-volume-write":"enabled","multi-container":"enabled","kubernetes.podspec-init-containers":"enabled"}}'
    kubectl patch configmap/config-network   --namespace knative-serving   --type merge   --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'
    ```

5. The Koerier Ingress IP will be assigned by MetalLB and can be retrieved with:
    ```
    kubectl --namespace kourier-system get service kourier
    ```

## Create a Kubernetes Secret

Create a [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/) named `runai-cluster-domain-tls-secret` in the `runai` namespace and include the path to the TLS `--cert` and its corresponding private `--key` by running the following:

```bash
kubectl create secret tls runai-cluster-domain-tls-secret -n runai \    
  --cert /path/to/fullchain.pem  \ # Replace /path/to/fullchain.pem with the actual path to your TLS certificate    
  --key /path/to/private.pem # Replace /path/to/private.pem with the actual path to your private key
```

## Local Certificate Authority

A local certificate authority serves as the root certificate for organizations that cannot use publicly trusted certificate authority if external connections or standard HTTPS authentication is required.

1. Add the public key to the required namespace:

```
kubectl -n runai create secret generic runai-ca-cert \
    --from-file=runai-ca.pem=<ca_bundle_path>
kubectl label secret runai-ca-cert -n runai run.ai/cluster-wide=true run.ai/name=runai-ca-cert --overwrite
```

2. When installing the cluster, make sure the following flag is added to the helm command --set global.customCA.enabled=true. See Install using Helm. TBD: Sherin

TBD: Oz both namespaces? 


## Label the NVIDIA Run:ai Control Plane Nodes 

Label the nodes using CMSH. For example:

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
    The above names of the categories are arbitrary names and are used as an example only. Make sure that you label the correct category. Mixing labels will result in pods running on incorrect nodes or not being scheduled at all.


## Create the CPU Worker Node ConfigurationOverlay  

The default Kubernetes worker ConfigurationOverlay initializes containerd with the NVIDIA Container Toolkit plugin runtime. This is not desirable on nodes with GPU resources and can lead to problems when certain workloads deploy (minimal containers that cannot handle the Toolkit’s CRI initialization. For that reason, it is recommended to create a separate configuration overlay for those nodes:

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
[append | removefrom]  <ConfigurationOverlay name>  [categories | nodes] <BCM category or node name>
```