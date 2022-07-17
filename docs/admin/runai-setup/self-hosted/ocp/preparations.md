---
title: Self Hosted installation over OpenShift - Preparations
---
# Preparing for a Run:ai OpenShift Installation

The following section provides IT with the information needed to prepare for a Run:ai installation. This includes Third-party dependencies which must be met as well as access control that must be granted for Run:ai components. 




## Create OpenShift Projects

Run:ai uses three projects. One for the control plane (`runai-backend`) and two for the cluster itself (`runai`, `runai-reservation`). 
The project `gpu-operator` is used by the _GPU Operator_ dependency described above. 

```
oc new-project runai
oc new-project runai-reservation
oc new-project runai-backend
oc new-project gpu-operator-resources
```

## Prepare Run:ai Installation Artifacts

### Run:ai Software Files

SSH into a node with `oc` access (`oc` is the OpenShift command-line) to the cluster and `Docker` installed.


=== "Connected"
    Run the following to enable image download from the Run:ai Container Registry on Google cloud:

    ```
    oc apply -f runai-gcr-secret.yaml -n runai-backend
    oc apply -f runai-gcr-secret.yaml -n gpu-operator-resources
    ```

=== "Airgapped" 

    To extract Run:ai files, replace `<VERSION>` in the command below and run: 

    ```
    tar xvf runai-<version>.tar.gz
    cd deploy
    ```

    Upload images to Docker Registry. Set the Docker Registry address in the form of `NAME:PORT` (do not add `https`):

    ```
    export REGISTRY_URL=<Docker Registry address>
    ```
    
    Run the following script (you must have at least 20GB of free disk space to run): 

    ```  
    sudo -E ./prepare_installation.sh
    ```

    (If docker is configured to [run as non-root](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user){target=_blank} then `sudo` is not required).

### Run:ai Administration CLI

=== "Connected"
    Install the Run:ai Administrator Command-line Interface by following the steps [here](../../config/cli-admin-install.md).

=== "Airgapped" 
    Install the Run:ai Administrator Command-line Interface by following the steps [here](../../config/cli-admin-install.md). Use the image under `deploy/runai-admin-cli-<version>-linux-amd64.tar.gz`

## Install Helm

If helm v3 does not yet exist on the machine, install it now:

=== "Connected"
    See [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank} on how to install Helm. Run:ai works with Helm version 3 only (not helm 2).

=== "Airgapped"
    ```
    tar xvf helm-<version>-linux-amd64.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/
    ```  

## Mark Run:ai System Workers

The Run:ai Control plane should be installed on a set of dedicated Run:ai system worker nodes rather than GPU worker nodes. To set system worker nodes run:

```
oc label node <NODE-NAME> node-role.kubernetes.io/runai-system=true
```

To avoid single-point-of-failure issues, we recommend assigning more than one node in production environments. 


## Install NVIDIA Dependencies


!!! Note
    You must have Cluster Administrator rights to install these dependencies. 

Before installing Run:ai, you must install NVIDIA software on your OpenShift cluster to enable GPUs. 
NVIDIA has provided [detailed documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/openshift/introduction.html){target=_blank}. 
Follow the instructions to install the two operators `Node Feature Discovery` and `NVIDIA GPU Operator` from the OpenShift web console. 

When done, verify that the GPU Operator is installed by running:

```
oc get pods -n gpu-operator
```


??? "Run:ai 2.3 or earlier"

    __Disable the NVIDIA Device Plugin and DCGM Exporter__

    After successful verification, 

    (1) Disable the GPU Operator by running:

    ```
    oc scale --replicas=0 -n openshift-operators deployment gpu-operator
    ```

    (1) Disable the NVIDIA DCGM exporter by running:

    ```
    oc -n gpu-operator-resources patch daemonset nvidia-dcgm-exporter \
      -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
    ```

    (2) Replace the NVIDIA Device Plug-in with the Run:ai version:

    ```
    oc patch daemonsets.apps -n gpu-operator-resources nvidia-device-plugin-daemonset \
      -p '{"spec":{"template":{"spec":{"containers":[{"name":"nvidia-device-plugin-ctr","image":"gcr.io/run-ai-prod/nvidia-device-plugin:1.0.11"}]}}}}'
    oc create clusterrolebinding --clusterrole=admin \
      --serviceaccount=gpu-operator-resources:nvidia-device-plugin nvidia-device-plugin-crb
    ```
    <!-- oc -n gpu-operator-resources patch daemonset nvidia-device-plugin-daemonset \
      -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}' -->



## Additional Permissions

As part of the installation, you will be required to install the [Control plane](backend.md) and [Cluster](cluster.md) Helm [Charts](https://helm.sh/){target=_blank}. The Helm Charts require Kubernetes administrator permissions. You can review the exact permissions provided by using the `--dry-run` on both helm charts. 

## Next Steps

Continue with installing the [Run:ai Control Plane](backend.md).
