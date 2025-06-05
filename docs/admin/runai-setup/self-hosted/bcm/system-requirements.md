# System Requirements


## Pre-installation Checklist

The following checklist is provided for convenience and can be seen as part of an expanded site survey for NVIDIA Run:ai deployments on SuperPOD. This information needs to be collected and validated before the NVIDIA Run:ai deployment begins.

| **Component** | **Type** | Reference |
| --- | --- | --- |
| [Networking] FQDN name/ Reserved IP address | DNS A or CNAME record pointing to the load balancer reserved IP | [Reserved IPs and Domain Configuration](#reserved-ips-and-domain-configuration) |
| [Networking] Load Balancer IP address range | Additional IP address space (minimum 2, recommended 8) for the Kubernetes LoadBalancer (Inference, DataMover workloads) | [Reserved IPs and Domain Configuration](#reserved-ips-and-domain-configuration) |
| [SSL] Full-chain SSL certificate | <`*.p7b`, `*.der` or `*.pem` file> | [TLS/SSL Certificates](#tlsssl-certificates) |
| [SSL] SSL Private Key | Private certificate (e.g. `*.key`) | [TLS/SSL Certificates](#tlsssl-certificates) |
| [SSL] CA trust chain public certificate | X509 PEM file | [Local Certificate Authority](#local-certificate-authority) |

## Installer Machine

The machine running the installation must have:

* At least 50GB of free space
* Docker installed
* [Helm](https://helm.sh/) 3.14 or later

The configuration of BCM as well as the deployment of NVIDIA Run:ai can be performed through SSH access on the BCM headnodes:

```bash
ssh root@<IP address of BCM headnode>
```

## Hardware Requirements

The following hardware requirements cover all components needed to deploy and operate NVIDIA Run:ai. By default, all NVIDIA Run:ai services run on all available nodes.

### Kubernetes

This configuration is the minimum requirement you need to deploy Kubernetes.


| Component  | Required Capacity |
| ---------- | ----------------- |
| CPU        | 2 cores           |
| Memory     | 16GB              |
| Disk space | 100GB             |

### NVIDIA Run:ai - System Nodes

This configuration is the minimum requirement you need to install and use NVIDIA Run:ai.

| Component  | Required Capacity |
| ---------- | ----------------- |
| CPU        | 20 cores          |
| Memory     | 42GB              |
| Disk space | 160GB             |


To designate nodes to NVIDIA Run:ai system services, follow the instructions as described in [Label the NVIDIA Run:ai System Nodes](#label-the-nvidia-runai-system-nodes).


### NVIDIA Run:ai - Worker Nodes

NVIDIA Run:ai supports NVIDIA SuperPods built on the A100, H100, H200, and B200 GPU architectures. These systems are optimized for high-performance AI workloads at scale.

The following configuration represents the minimum hardware requirements for installing and operating NVIDIA Run:ai on worker nodes. Each node must meet these specifications:

| Component | Required Capacity |
| --------- | ----------------- |
| CPU       | 2 cores           |
| Memory    | 4GB               |


To designate nodes to NVIDIA Run:ai workloads, follow the instructions as described in [Label the NVIDIA Run:ai Worker Nodes](#label-the-nvidia-runai-worker-nodes).


### Node Categories

In BCM, a node category is a way to group nodes that share the same hardware profile and intended role. Defining node categories allows the system to assign the appropriate software image and configurations to each group during provisioning.

Before installing NVIDIA Run:ai, make sure the necessary BCM node categories are created for:

* NVIDIA Run:ai system nodes (for example, `runai-control-plane-spod`)
* NVIDIA Run:ai GPU worker nodes (for example, `dgx-h100-spod`)
* Optional: NVIDIA Run:ai CPU worker nodes (for example, `runai-cpu-workers`)


## Reserved IPs and Domain Configuration

Before installing NVIDIA Run:ai, make sure the necessary IPs (at least 2) are reserved and the domain names are properly set up. These are critical for exposing the control plane and inference services.

### Reserved IP Addresses

Reserve at least two IP addresses from the same internal IP range:

* NVIDIA Run:ai control plane – Reserve one IP address for accessing core components such as the UI, API, and workload endpoints. This IP is not used for inference workloads.

* Inference (Knative Serving) – Reserve a second IP address specifically for serving inference workloads using Knative-based serving layer.

All reserved IPs must be reachable within your internal network and not conflict with other internal IP allocations.

### Fully Qualified Domain Name (FQDN)

A Fully Qualified Domain Name (FQDN) is required to install the NVIDIA Run:ai control plane (e.g., `runai.mycorp.local`). This cannot be an IP. The domain name must be accessible inside the organization's private network.

The FQDN must point to the control plane’s reserved IP, either:

* As a DNS (A record) pointing directly to the IP
* Or, a CNAME alias to a host DNS record pointing to that same IP address

### Wildcard FQDN for Inference

For inference workloads, configure a wildcard DNS record (`*.runai-inference.mycorp.local`) that maps to the reserved inference IP address. This ensures each inference workload is accessible at a unique subdomain.


## TLS/SSL Certificates

You must have a TLS certificates that is associated with the FQDN for HTTPS access. The certificate will be installed on the Kubernetes control plane nodes as well as a [Kubernetes secret](#tls-certificate) for the NVIDIA Run:ai backend and the [Kubernetes Ingress controller](#configure-kubernetes-ingress-controller).

* The certificate CN name needs to be equal to the [FQDN](#fully-qualified-domain-name-fqdn).
* The certificate needs to include at least one Subject Alternative Name DNS entry (SAN) for the same FQDN.
* The certificate needs to include the full trust chain (signing CA public keys).


## Operating System

DGX OS is supported on your SuperPod and optimized for NVIDIA infrastructure. 
SR-IOV enables InfiniBand support at the host level. When used together with the [NVIDIA Network Operator](#configure-the-network-operator), it allows workloads to leverage InfiniBand networking for high-performance communication.


## Deploy Kubernetes: Base Command Manager

1. From the active BCM headnode, run the following command:
    ```
    cm-kubernetes-setup
    ```

2. The following screen will pop up. Select **Deploy** and then click **Ok**:

    ![alt text](images/image.png)

    !!! Note
        The number of entries in the above menu may vary.

2. Select **Kubernetes v1.31** and then click **Ok**:

    ![alt text](images/image-1.png)

3. Optional: Provide a DockerHub container registry mirror if required and then click **Ok**. Otherwise, leave blank and click **Ok** to proceed:

    ![alt text](images/image-3.png)

4. Set the Kubernetes networks and then click **Ok**. The subnets need to be in a private address space (per RFC 1918). Use the default values and only modify if necessary or in case of conflict with other internal subnets within the network. Make sure the domain names of the networks are configured correctly and modify as required to match the “Kubernetes External FQDN” using the same domain set in the [FQDN](#fully-qualified-domain-name-fqdn) section:

    ![alt text](images/image-4.png)

5. Select **yes** to expose the Kubernetes API servers to the cluster’s external network and then click **Ok**:

    ![alt text](images/image-5.png)


6. Select the internal network that will be used by the Kubernetes nodes and then click **Ok**:

    ![alt text](images/image-6.png)

7. Select at least 3 Kubernetes master nodes and then click **Ok**:

    ![alt text](images/image-7.png)

    !!! Note
        To ensure high availability and prevent a single point of failure, it is recommended to configure at least three Kubernetes master nodes in your cluster.

8. Select both the NVIDIA Run:ai system and worker [node categories](#node-categories) to operate as the Kubernetes worker nodes and then click **Ok**:

    ![alt text](images/image-8.png)


9. Selecting individual Kubernetes nodes is not required. Click **Ok** to proceed:

    ![alt text](images/image-9.png)

10. Select the Etcd nodes and then click **Ok**. Make sure to select the same three nodes as the Kubernetes master nodes (Step 8):

    ![alt text](images/image-10.png)

11. Ignore the following message if it appears and click **Ok**:

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
    Do NOT select the Run:ai operator.

#### NVIDIA GPU Operator

NVIDIA Run:ai supports versions 22.9 to 25.3.

1. Select the required NVIDIA GPU Operator version and then click **Ok**:
    ![alt text](images/image-16.png)


2. Leave the YAML configuration file path empty and then click **Ok**:
    ![alt text](images/image-18.png)


3. Configure the NVIDIA GPU Operator by selecting the following configuration parameters and then click **Ok**:
    ![alt text](images/image-19.png)

#### Network Operator

1. Select Network Operator **v24.7.0** and then click **Ok**: 

    ![alt text](images/image-17.png)


2. Create a [YAML file](files/networkoperator.txt){target=_blank} with the required Helm values.

3. Add the path to the YAML file and then click **Ok**:

    ![alt text](images/image-40.png)


4. Do not add any MetalLB address pools at this point. Click **Ok** to proceed:
        
    ![alt text](images/image-20.png)

### Kubernetes Ingress Controller

1. Select **Ingress Controller (Nginx)** and then click **Ok**:
    ![alt text](images/image-21.png)

2. Select **yes** when asked to expose the Ingress service over port 443 and then click **Ok**:
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


## Configure BCM Kubernetes for NVIDIA Run:ai

### Label the NVIDIA Run:ai System Nodes

Label the system nodes to ensure that system services are scheduled on designated system nodes.

!!! Note 
    [Node category names](#node-categories) are user-defined and may vary. Make sure to label the correct category. Incorrect or mixed labels may result in pods being scheduled on unintended nodes or failing to schedule altogether.

```bash
cmsh
kubernetes
labelsets
add runai-control-plane
append categories runai-control-plane
append labels node-role.kubernetes.io/runai-system=true
commit
```

!!! Note
    * [Node category names](#node-categories) are user-defined and may vary. Make sure to label the correct category. Incorrect or mixed labels may result in pods being scheduled on unintended nodes or failing to schedule altogether.
    * For more information, see [System nodes](../../../config/node-roles.md#system-nodes).
    * After installation, you can configure NVIDIA Run:ai to enforce stricter scheduling rules that ensure system components are assigned to the correct nodes. See [Next Steps](next-steps.md) for more details.

### Label the NVIDIA Run:ai Worker Nodes

1. Label the nodes - GPU workers:
    ```bash
    cmsh
    kubernetes
    labelsets
    add runai-control-plane
    append categories dgx-h100-spod
    append labels 
    commit
    ```
2. Optional: Label the nodes - CPU workers:
    ```bash
    cmsh
    kubernetes
    labelsets
    add runai-cpu-worker
    append categories runai-cpu-workers
    append labels 
    node-role.kubernetes.io/runai-cpu-worker=true
    commit
    ```

!!! Note
    * [Node category names](#node-categories) are user-defined and may vary. Make sure to label the correct category. Incorrect or mixed labels may result in pods being scheduled on unintended nodes or failing to schedule altogether.
    * For more information, see [Worker nodes](../../../config/node-roles.md#worker-nodes). 
    * After installation, you can configure NVIDIA Run:ai to enforce stricter scheduling rules that ensure workloads are assigned to the correct nodes. See [Next Steps](next-steps.md) for more details.


### Create the NVIDIA Run:ai Namespaces

Create the following Kubernetes namespaces:

```bash
kubectl create ns runai-backend
kubectl create ns runai
```

!!! Note
    If you cannot use kubectl, load the Kubernetes Lmod module using `module load kubernetes`.

### Expose the NVIDIA Run:ai Endpoint - MetalLB
NVIDIA Run:ai is exposed through the MetalLB load balancer/Route Advertiser. This includes the main Kubernetes Ingress for the NVIDIA Run:ai control plane and the Kourier Ingress used for Knative Serving.
Make sure a reserved range of IP addresses is available as described in [Reserved IPs and Domain Configuration](#reserved-ips-and-domain-configuration) and MetalLB is deployed as part of the [Kubernetes installation](#deploy-kubernetes-base-command-manager).

1. Configure the Kubernetes API proxy with strict ARP validation:

    ```bash
    kubectl get configmap kube-proxy -n kube-system -o yaml | \
    sed -e "s/strictARP: false/strictARP: true/" | \
    kubectl apply -f - -n kube-system
    ```

2. Create a new appGroup application in BCM:

    ```bash
    root@bcmhead1:~# cmsh
    [bcmhead1]% kubernetes
    [bcmhead1->kubernetes[dra]]% appgroups
    [bcmhead1->kubernetes[dra]->appgroups]% use system
    [bcmhead1->kubernetes[dra]->appgroups[system]]% applications
    [bcmhead1->kubernetes[dra]->appgroups[system]->applications]% add ingress-metallb
    [bcmhead1->kubernetes*[dra*]->appgroups*[system*]->applications*[ingress-metallb*]]% set config /root/ingress-metallb.yaml
    [bcmhead1->kubernetes*[dra*]->appgroups*[system*]->applications*[ingress-metallb*]]% commit
    ```

3. Create the [YAML configuration](files/metallb.txt){target=_blank} to define the ingress IP pool and Layer 2 advertisement. You will need to substitute the IP address with the reserved IP address.


### Configure Kubernetes Ingress Controller

#### Scale up the Ingress Deployment

For high availability, increase the number of replicas from 1 to 3:

```bash
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

#### Configure the NGINX Proxy TLS Certificates

This process sets up TLS certificates for the Run:ai control plane [FQDN](#fully-qualified-domain-name-fqdn).

Follow these steps on the active BCM headnode to configure the NGINX Ingress controller with your signed TLS certificate:

1. From the active BCM headnode, run the following command:
    ```bash
    cm-kubernetes-setup
    ```

2. The following screen will pop up. Select **Configure Ingress** and then click **Ok**:

    ![alt text](images/image-30.png)

2. Select the Kubernetes cluster and then click **Ok**:

    ![alt text](images/image-31.png)

3. Select **yes** when asked to provide signed certificates and then click **Ok**:

    ![alt text](images/image-32.png)

4. Enter the path to the private key and PEM certificate and then click **Ok**. See [TLS Certificate](#tls-certificate) for more details:

    ![alt text](images/image-33.png)

#### Confifure the NGINX with reserved IP for MetalLB
Patch the ingress-nginx service. Assign the reserved control plane IP address to the ingress controller:

```bash
    kubectl -n ingress-nginx patch svc ingress-nginx-controller \
    --type='merge' \
    -p '{"spec": {"type": "LoadBalancer", "loadBalancerIP": "<RESERVED-IP>"}}'
```

### Configure the Network Operator

The default deployment of the Network Operator installs the boiler-plate services, but does not initialize the SR-IOV and secondary network plugins. The following CRD resources have to be created in the exact order as below:

* SR-IOV Network Policies for each NVIDIA InfiniBand NIC
* An nvIPAM IP address pool
* SR-IOV InfiniBand networks

The above CRD YAML specs can be downloaded from the following Gitlab repo: https://gitlab-master.nvidia.com/kuberpod/runai-deployment-assets. TBD: Should we add these yaml files 

1. Increase the number of simultaneous updates by the Network Operator:
    ```bash
    kubectl patch sriovoperatorconfigs.sriovnetwork.openshift.io -n network-operator default --patch '{ "spec": { "maxParallelNodeConfiguration": 0 } }' --type='merge'
    ```
    and

    ```bash
    kubectl patch sriovoperatorconfigs.sriovnetwork.openshift.io -n network-operator default --patch '{ "spec": { "featureGates": { "parallelNicConfig": true  } } }' --type='merge'
    ```
2. Create the SR-IOV network node policies:
    ```bash
    kubectl apply -f sriov-network-node-policy.yaml
    ```

    Adjust the number of Virtual Function (numVfs) as needed.

3. Create an IPAM IP Pool:
    ```bash
    kubectl apply -f nvipam-ip-pool.yaml
    ```

4. Create the SR-IOV IB networks:
    ```bash
    kubectl apply -f sriov-ib-network.yaml
    ```

!!! Note
    The Network Operator will restart the DGX nodes if the number of Virtual Functions in the SR-IOV Network Policy file does not match the NVIDIA/Mellanox firmware configuration. 

## Certificates Setup for NVIDIA Run:ai 

### TLS Certificate

You must have TLS certificate that is associated with the FQDN for HTTPS access. Create a [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/) named `runai-backend-tls` in the `runai-backend` namespace and include the path to the TLS `--cert` and its corresponding private `--key` by running the following:

```bash
kubectl create secret tls runai-backend-tls -n runai-backend \
  --cert /path/to/fullchain.pem  \ # Replace /path/to/fullchain.pem with the actual path to your TLS certificate 
  --key /path/to/private.pem # Replace /path/to/private.pem with the actual path to your private key
```

### Local Certificate Authority

A local certificate authority serves as the root certificate for organizations that cannot use publicly trusted certificate authority if external connections or standard HTTPS authentication is required. Follow the below steps to configure the local certificate authority. 


1. Add the public key to the `runai-backend` namespace:
    ```bash
    kubectl -n runai-backend create secret generic runai-ca-cert \ 
        --from-file=runai-ca.pem=<ca_bundle_path>
    ```

2. Add the public key to the `runai` namespace:
    ```bash
    kubectl -n runai create secret generic runai-ca-cert \
        --from-file=runai-ca.pem=<ca_bundle_path>
    kubectl label secret runai-ca-cert -n runai run.ai/cluster-wide=true run.ai/name=runai-ca-cert --overwrite
    ```

3. When installing the control plane and cluster, make sure the following flag is added to the helm command `--set global.customCA.enabled=true`.

## Additional Software Requirements

Additional NVIDIA Run:ai capabilities, Distributed Training and Inference require additional Kubernetes applications (frameworks) to be installed.

### Distributed Training

Distributed training enables training of AI models over multiple nodes. This requires installing a distributed training framework on the cluster. The following frameworks are supported:

* [TensorFlow](https://www.tensorflow.org/)
* [PyTorch](https://pytorch.org/)
* [XGBoost](https://xgboost.readthedocs.io/)
* [MPI](https://docs.open-mpi.org/)

All are part of the Kubeflow Training Operator. NVIDIA Run:ai supports Training Operator version 1.7. The Kubeflow Training Operator gets installed as part of the BCM Kubernetes Deployment.

The Kubeflow Training Operator is packaged with MPI version 1.0 which is not supported by NVIDIA Run:ai. You need to separately install MPI v2beta1:

1. Run the below to install MPI v2beta:
    ```bash
    kubectl create -f https://raw.githubusercontent.com/kubeflow/mpi-operator/v0.6.0/deploy/v2beta1/mpi-operator.yaml
    ```
2. Disable MPI in the Training operator by running:
    ```bash
    kubectl patch deployment training-operator -n kubeflow --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args", "value": ["--enable-scheme=tfjob", "--enable-scheme=pytorchjob", "--enable-scheme=xgboostjob"]}]'
    ``` 

3. Run: 
    ```bash
    kubectl delete crd mpijobs.kubeflow.org
    ```

4. Install MPI v2beta1 again:
    ```bash
    kubectl create -f https://raw.githubusercontent.com/kubeflow/mpi-operator/v0.6.0/deploy/v2beta1/mpi-operator.yaml
    # Ignore any errors in the above command
    kubectl replace -f https://raw.githubusercontent.com/kubeflow/mpi-operator/v0.6.0/deploy/v2beta1/mpi-operator.yaml
    ```


### Inference

Inference enables serving of AI models. This requires the [Knative Serving](https://knative.dev/docs/serving/) framework to be installed on the cluster and supports Knative versions 1.10 to 1.15.

Follow the [Installing Knative](https://knative.dev/docs/install/) instructions. After installation:

1. configure Knative to use the NVIDIA Run:ai Scheduler and features, by running:

```bash
kubectl patch configmap/config-autoscaler \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"enable-scale-to-zero":"true"}}' && \
kubectl patch configmap/config-features \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"kubernetes.podspec-schedulername":"enabled","kubernetes.podspec-affinity":"enabled","kubernetes.podspec-tolerations":"enabled","kubernetes.podspec-volumes-emptydir":"enabled","kubernetes.podspec-securitycontext":"enabled","kubernetes.containerspec-addcapabilities":"enabled","kubernetes.podspec-persistent-volume-claim":"enabled","kubernetes.podspec-persistent-volume-write":"enabled","multi-container":"enabled","kubernetes.podspec-init-containers":"enabled"}}'
```


2. Patch Knative Kourier service. Assign the reserved IP address and DNS for inference workloads to the Knative ingress service:
    ```bash
    # Replace knative.example.com with your FQDN for Inference (without the wildcard)
    kubectl patch configmap/config-domain --namespace knative-serving --type merge --patch '{"data":{"<knative.example.com>":""}}'

    kubectl -n kourier-system patch svc kourier \
    --type='merge' \
    -p '{"spec": {"type": "LoadBalancer", "loadBalancerIP": "<RESERVED-IP>"}}'
    ```


### Knative Autoscaling

NVIDIA Run:ai allows for autoscaling a deployment according to the below metrics:

* Latency (milliseconds)
* Throughput (requests/sec)
* Concurrency (requests)

Using a custom metric (for example, Latency) requires installing the [Kubernetes Horizontal Pod Autoscaler (HPA)](https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml/#install-optional-serving-extensions). Use the following command to install. Make sure to update the {VERSION} in the below command with a [supported Knative version](#inference).

```bash
kubectl apply -f https://github.com/knative/serving/releases/download/knative-{VERSION}/serving-hpa.yaml
```
