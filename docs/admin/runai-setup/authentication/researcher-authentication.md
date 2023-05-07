# Setup Researcher Access Control

## Introduction

The following instructions explain how to complete the configuration of access control for Researchers. Run:ai access control is at the __Project__ level. When you assign Users to Projects - only these users are allowed to submit Jobs and access Jobs details. 

This requires several steps:

* Assign users to their Projects.
* (Mandatory) Modify the Kubernetes entry point (called the `Kubernetes API server`) to validate credentials of incoming requests against the Run:ai Authentication authority.
* (Command-line Interface usage only) Modify the Kubernetes profile to prompt the Researcher for credentials when running `runai login` (or `oc login` for OpenShift). 


## Administration User Interface Setup

<!-- ### Enable Researcher Authentication

* Open the Run:ai user interface and navigate to `General | Settings`. 
* Enable the flag _Researcher Authentication_ (should be enabled by default for new tenants).
* There are values for `Realm`, `client configuration`, and `server configuration` which appear on the screen. Use them as below.  -->


### Assign Users to Projects

Assign Researchers to Projects:

* Open the Run:ai user interface and navigate to `Users`. Add a Researcher and assign it a `Researcher` role.
* Navigate to `Projects`. Edit or create a Project. Use the `Access Control` tab to assign the Researcher to the Project. 
* If you are using Single Sign-On, you can also assign _Groups_. For more information see the [Single Sign-On](sso.md) documentation.

## (Mandatory) Kubernetes Configuration

As described in [authentication overview](authentication-overview.md), you must direct the Kubernetes API server to authenticate via Run:ai. This requires adding flags to the Kubernetes API Server. The flags show in the Run:ai user interface under `Settings` | `General` | `server configuration`.
 
Modifying the API Server configuration differs between Kubernetes distributions:


=== "Native Kubernetes"
    * Locate the Kubernetes API Server configuration file. The file's location may differ between different Kubernetes distributions. The location for vanilla Kubernetes is `/etc/kubernetes/manifests/kube-apiserver.yaml`
    * Edit the document, under the `command` tag, add the __server__ configuration text from `General | Settings | Researcher Authentication`.   
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
            oidc-issuer-url: https://example.com/auth
            oidc-username-prefix: "-"
            
    ```

    1. These are example parameters. Copy the actual parameters from from `General | Settings | Researcher Authentication` as described above.

    You can verify that the flags have been incorporated into the RKE cluster by following the instructions [here](https://rancher.com/docs/rancher/v2.x/en/troubleshooting/kubernetes-components/controlplane/) and running `docker inspect <kube-api-server-container-id>`, where `<kube-api-server-container-id>` is the container ID of _api-server_ via obtained in the Rancher document. 

=== "RKE2"
    If working via the [RKE2 Quickstart](https://docs.rke2.io/install/quickstart/){target=_blank}, edit `/etc/rancher/rke2/config.yaml`. Add the parameters provided in the server configuration section as described above in the following fashion:

    ``` YAML title="/etc/rancher/rke2/config.yaml"
    kube-apiserver-arg:
    - "oidc-client-id=<CLIENT-ID>"
    - "oidc-issuer-url=<URL>"
    - "oidc-username-prefix=-"
    ```

    If working via Rancher UI, need to add the flag as part of the cluster provisioning. 
    
    Under `Cluster Management | Create`, turn on RKE2 and select a platform. Under `Cluster Configuration | Advanced | Additional API Server Args`. Add the Run:ai flags as `<key>=<value>` (e.g. `oidc-username-prefix=-`).

    At the time of writing, the flags cannot be changed after the cluster has been provisioned due to a Rancher bug.
    
=== "GKE"
    Install [Anthos identity service](https://cloud.google.com/kubernetes-engine/docs/how-to/oidc#enable-oidc){target=_blank} by running:

    ```
    gcloud container clusters update <gke-cluster-name> \
        --enable-identity-service --project=<gcp-project-name> --zone=<gcp-zone-name>
    ```

    Install the [yq](https://github.com/mikefarah/yq){target=_blank} utility and run:

    ```
    kubectl get clientconfig default -n kube-public -o yaml > login-config.yaml
    yq -i e ".spec +={\"authentication\":[{\"name\":\"oidc\",\"oidc\":{\"clientID\":\"$OIDC_CLIENT_ID\",\"issuerURI\":\"$OIDC_ISSUER_URL\",\"kubectlRedirectURI\":\"http://localhost:8000/callback\",\"userClaim\":\"sub\",\"userPrefix\":\"$OIDC_USERNAME_PREFIX\"}}]}" login-config.yaml
    kubectl apply -f login-config.yaml
    ```

    Where the `OIDC` flags are provided in the Run:ai server configuration section as described above. 


    To create a kubeconfig profile for Researchers run:

    ```
    kubectl oidc login --cluster=CLUSTER_NAME --login-config=login-config.yaml \
        --kubeconfig=developer-kubeconfig
    ```

    Then modify the `developer-kubeconfig` file as described in the [Command-line Inteface Access](researcher-authentication.md#command-line-interface-access) section below.

=== "EKS"
    * In the AWS Console, under EKS, find your cluster.
    * Go to `Configuration` and then to `Authentication`.
    * Associate a new `identity provider`. Use the parameters provided in the server configuration section as described above. The process can take up to 30 minutes. 

=== "Bright"

    Run the following. Replace `<TENANT-NAME>` and `<REALM-NAME>` with the appropriate values:

    ``` bash
    # start cmsh
    [root@headnode ~]# cmsh

    # go to the configurationoverlay submode
    [headnode]% configurationoverlay

    [headnode->configurationoverlay]% list  # use list here to list overlays
    ...

    # go to the overlay for kube master nodes
    [headnode->configurationoverlay]% use kube-default-master

    [headnode->configurationoverlay[kube-default-master]]% show  # use show here to show the selected overlay
    ...

    # go to the kube apiserver role
    [headnode->configurationoverlay[kube-default-master]]% roles
    [headnode->configurationoverlay[kube-default-master]->roles]% list   # ... 
    [headnode->configurationoverlay[kube-default-master]->roles]% use kubernetes::apiserver

    # we can check the current value of "options"
    [headnode->configurationoverlay[kube-default-master]->roles[Kubernetes::ApiServer]]% show  # ...
    [headnode->configurationoverlay[kube-default-master]->roles[Kubernetes::ApiServer]]% get options
    --anonymous-auth=false
    --service-account-issuer=https://kubernetes.default.svc.cluster.local
    --service-account-signing-key-file=/cm/local/apps/kubernetes/var/etc/sa-default.key
    --feature-gates=LegacyServiceAccountTokenNoAutoGeneration=false

    # we can append our flags like this
    [headnode->configurationoverlay[kube-default-master]->roles[Kubernetes::ApiServer]]% append options "--oidc-client-id=runai"
    [headnode->configurationoverlay*[kube-default-master*]->roles*[Kubernetes::ApiServer*]]% append options "--oidc-issuer-url=https://app.run.ai/auth/realms/<REALM-NAME>"
    [headnode->configurationoverlay*[kube-default-master*]->roles*[Kubernetes::ApiServer*]]% append options "--oidc-username-prefix=-"

    # commit the changes
    [headnode->configurationoverlay[kube-default-master]->roles[Kubernetes::ApiServer]]% ]]% commit

    # view updated list of options
    [headnode->configurationoverlay[kube-default-master]->roles[Kubernetes::ApiServer]]% get options
    --anonymous-auth=false
    --service-account-issuer=https://kubernetes.default.svc.cluster.local
    --service-account-signing-key-file=/cm/local/apps/kubernetes/var/etc/sa-default.key
    --feature-gates=LegacyServiceAccountTokenNoAutoGeneration=false
    --cors-allowed-origins=[\"https://<TENANT-NAME>.run.ai\"]
    --oidc-client-id=runai
    --oidc-issuer-url=https://app.run.ai/auth/realms/<REALM-NAME>
    --oidc-username-prefix=-
    ```

    All nodes with the `kube api server` role will automatically restart with the new flag.

=== "AKS"
    Please contact Run:ai customer support.
    
=== "Other"
    See specific instructions in the documentation of the Kubernetes distribution.  


## Command-line Interface Access

To control access to Run:ai (and Kubernetes) resources, you must modify the Kubernetes configuration file. The file is distributed to users as part of the [Command-line interface installation](../../../researcher-setup/cli-install#kubernetes-configuration). 

When making changes to the file, keep a copy of the original file to be used for cluster administration. After making the modifications, distribute the modified file to Researchers. 

* Under the `~/.kube` directory edit the `config` file, remove the administrative user, and replace it with text from `General | Settings | Researcher Authentication` | `Client Configuration`. 
* Under `contexts | context | user` change the user to `runai-authenticated-user`.


## Test via Command-line interface

* Run: `runai login` (in OpenShift environments use `oc login` rather than `runai login`).
* You will be prompted for a username and password. In a single sign-on flow, you will be asked to copy a link to a browser, log in and return a code. 
* Once login is successful, submit a Job.
* If the Job was submitted with a Project to which you have no access, your access will be denied. 
* If the Job was submitted with a Project to which you have access, your access will be granted.

You can also submit a Job from the Run:ai User interface and verify that the new job shows on the job list with your user name. 

## Test via User Interface

* Open the Run:ai user interface, go to `Jobs`.
* On the top-right, select `Submit Job`. 

!!! Tip
    If you do not see the button or it is disabled, then you either do not have `Researcher` access or the cluster has not been set up correctly. For more information, refer to [user interface overview](../../admin-ui-setup/overview.md).

