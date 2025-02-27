# Setup Researcher Access Control


## Introduction

The following instructions explain how to complete the configuration of access control for Researchers. This requires several steps:

* (Mandatory) Modify the Kubernetes entry point (called the `Kubernetes API server`) to validate the credentials of incoming requests against the Run:ai Authentication authority.
* (Command-line Interface usage only) Modify the Kubernetes profile to prompt the Researcher for credentials when running `runai login` (or `oc login` for OpenShift).



!!! Important
    * As of Run:ai version 2.16, you only need to perform these steps when accessing Run:ai from the [command-line interface](../researcher-setup/cli-install.md).
    * As of Run:ai version 2.18, you only need to perform these steps when if using the older command-line interface.


## Kubernetes Configuration

You must direct the Kubernetes API server to authenticate via Run:ai. This requires adding flags to the Kubernetes API Server. The flags show in the Run:ai user interface under `Settings` | `General` | `Researcher Authentication` | `Server configuration`.

Modifying the API Server configuration differs between Kubernetes distributions:

=== "Vanilla Kubernetes"

    * Locate the Kubernetes API Server configuration file. The file's location may differ between different Kubernetes distributions. The location for vanilla Kubernetes is `/etc/kubernetes/manifests/kube-apiserver.yaml`
    * Edit the document, under the `command` tag, add the __server__ configuration text described above.
    * Verify that the `kube-apiserver-<master-node-name>` pod in the `kube-system` namespace has been restarted and that changes have been incorporated. Run the below and verify that the _oidc_ flags you have added:

    ```
    kubectl get pods -n kube-system kube-apiserver-<master-node-name> -o yaml
    ```

=== "OpenShift"
    No configuration is needed. Instead, Run:ai assumes that an Identity Provider has been defined at the OpenShift level and that the Run:ai Cluster installation has set the `OpenshiftIdp` flag to true. For more information see the Run:ai OpenShift control-plane setup.

=== "RKE"
    Edit Rancher `cluster.yml` (with Rancher UI, follow [this](https://rancher.com/docs/rancher/v2.x/en/cluster-admin/editing-clusters/#editing-clusters-in-the-rancher-ui){target=_blank}). Add the following:

    ``` YAML title="cluster.yml"
    kube-api:
        always_pull_images: false
        extra_args:
            oidc-client-id: runai  # (1)
            ...
            
    ```

    1. These are example parameters. Copy the actual parameters from `Settings | General | Researcher Authentication` as described above.

    You can verify that the flags have been incorporated into the RKE cluster by following the instructions [here](https://rancher.com/docs/rancher/v2.x/en/troubleshooting/kubernetes-components/controlplane/) and running `docker inspect <kube-api-server-container-id>`, where `<kube-api-server-container-id>` is the container ID of _api-server_ via obtained in the Rancher document. 

=== "RKE2"
    If working via the [RKE2 Quickstart](https://docs.rke2.io/install/quickstart/){target=_blank}, edit `/etc/rancher/rke2/config.yaml`. Add the parameters provided in the server configuration section as described above in the following fashion:

    ``` YAML title="/etc/rancher/rke2/config.yaml"
    kube-apiserver-arg:
    - "oidc-client-id=runai" # (1)
    ...
    ```
    
    1. These are example parameters. Copy the actual parameters from `Settings | General | Researcher Authentication` as described above.

    If working via Rancher UI, need to add the flag as part of the cluster provisioning. 
    
    Under `Cluster Management | Create`, turn on RKE2 and select a platform. Under `Cluster Configuration | Advanced | Additional API Server Args`. Add the Run:ai flags as `<key>=<value>` (e.g. `oidc-username-prefix=-`).

=== "GKE"
    Install [Anthos identity service](https://cloud.google.com/kubernetes-engine/docs/how-to/oidc#enable-oidc){target=_blank} by running:

    ```
    gcloud container clusters update <gke-cluster-name> \
        --enable-identity-service --project=<gcp-project-name> --zone=<gcp-zone-name>
    ```

    Install the [yq](https://github.com/mikefarah/yq){target=_blank} utility and run:

    For username-password authentication, run:

    ```
    kubectl get clientconfig default -n kube-public -o yaml > login-config.yaml
    yq -i e ".spec +={\"authentication\":[{\"name\":\"oidc\",\"oidc\":{\"clientID\":\"runai\",\"issuerURI\":\"$OIDC_ISSUER_URL\",\"kubectlRedirectURI\":\"http://localhost:8000/callback\",\"userClaim\":\"sub\",\"userPrefix\":\"-\"}}]}" login-config.yaml
    kubectl apply -f login-config.yaml
    ```

    For single-sign-on, run:

    ```
    kubectl get clientconfig default -n kube-public -o yaml > login-config.yaml
    yq -i e ".spec +={\"authentication\":[{\"name\":\"oidc\",\"oidc\":{\"clientID\":\"runai\",\"issuerURI\":\"$OIDC_ISSUER_URL\",\"groupsClaim\":\"groups\",\"kubectlRedirectURI\":\"http://localhost:8000/callback\",\"userClaim\":\"email\",\"userPrefix\":\"-\"}}]}" login-config.yaml
    kubectl apply -f login-config.yaml
    ```

    Where the `OIDC` flags are provided in the Run:ai server configuration section as described above. 

    Then update runaiconfig with  the Anthos endpoint - gke-oidc-envoy.
    Get the externel IP of the service in the Anthos namespace.

    ```
    kubectl get svc -n anthos-identity-service
    NAME               TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)              AGE
    gke-oidc-envoy     LoadBalancer   10.37.3.111   39.201.319.10   443:31545/TCP        12h
    ```

    Add the IP to runaiconfig 

    ```
    kubectl -n runai patch runaiconfig runai -p '{"spec": {"researcher-service": {"args": {"gkeOidcEnvoyHost": "35.236.229.19"}}}}'  --type="merge"
    ```

    To create a kubeconfig profile for Researchers run:

    ```
    kubectl oidc login --cluster=CLUSTER_NAME --login-config=login-config.yaml \
        --kubeconfig=developer-kubeconfig
    ```

    (this will require installing the kubectl oidc plug-in as described in the Anthos document above `gcloud components install kubectl-oidc`)
    
    Then modify the `developer-kubeconfig` file as described in the [Command-line Inteface Access](researcher-authentication.md#command-line-interface-access) section below.

=== "EKS"

    * In the AWS Console, under EKS, find your cluster.
    * Go to `Configuration` and then to `Authentication`.
    * Associate a new `identity provider`. Use the parameters provided in the server configuration section as described above. The process can take up to 30 minutes.

=== "BCM"

    Please follow the "Vanilla Kubernetes" instructions
    
=== "AKS"
    Please contact Run:ai customer support.

=== "Other"
    See specific instructions in the documentation of the Kubernetes distribution.  

## Command-line Interface Access

To control access to Run:ai (and Kubernetes) resources, you must modify the Kubernetes configuration file. The file is distributed to users as part of the [Command-line interface installation](../researcher-setup/cli-install.md#kubernetes-configuration).

When making changes to the file, keep a copy of the original file to be used for cluster administration. After making the modifications, distribute the modified file to Researchers.

* Under the `~/.kube` directory edit the `config` file, remove the administrative user, and replace it with text from `Settings | General | Researcher Authentication` | `Client Configuration`.
* Under `contexts | context | user` change the user to `runai-authenticated-user`.

!!! Important Security Note
    * After adding the new user, **ensure to delete the following fields from the kubeconfig file** to prevent unauthorized access: - **Delete**: `client-certificate-data`- **Delete**: `client-key-data`- **Remove**: Any references to the `admin` user.

## Test via Command-line interface

* Run: `runai login` (in OpenShift environments use `oc login` rather than `runai login`).
* You will be prompted for a username and password. In a single sign-on flow, you will be asked to copy a link to a browser, log in and return a code.
* Once login is successful, submit a Job.
* If the Job was submitted with a Project to which you have no access, your access will be denied.
* If the Job was submitted with a Project to which you have access, your access will be granted.

You can also submit a Job from the Run:ai User interface and verify that the new job shows on the job list with your user name.

## Test via User Interface

* Open the Run:ai user interface, go to `Workloads`.
* On the top-right, select `Submit Workload`.

