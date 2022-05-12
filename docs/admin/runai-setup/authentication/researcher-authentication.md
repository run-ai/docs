# Setup Researcher Access Control

## Introduction

The following instructions explain how to complete the configuration of access control for Researchers. Run:ai access control is at the __Project__ level. When you assign Users to Projects - only these users are allowed to submit Jobs and access Jobs details. 

This requires several steps:

* Assign users to their Projects
* (Mandatory) Modify the Kubernetes entry point (called the `Kubernetes API server`) to validate credentials of incoming requests against the Run:ai Authentication authority.
* (Command-line Interface usage only) Modify the Kubernetes profile to prompt the Researcher for credentials when running `runai login` (or `oc login` for OpenShift). 


## Administration User Interface Setup

### Enable Researcher Authentication

* Open the Run:ai user interface and navigate to `General | Settings`. 
* Enable the flag _Researcher Authentication_ (should be enabled by default for new tenants).
* There are values for `Realm`, `client configuration`, and `server configuration` which appear on the screen. Use them as below. 


### Assign Users to Projects

Assign Researchers to Projects:

* Open the Run:ai user interface and navigate to `Users`. Add a Researcher and assign it with a _Researcher_ role.
* Navigate to `Projects`. Edit or create a Project. Use the `Access Control` tab to assign the Researcher to the Project. 
* If you are using Single Sign-on, you can also assign _Groups_. For more information see the [Single Sign-on](sso.md) documentation.

## (Mandatory) Kubernetes Configuration

As described in [authentication overview](authentication-overview.md), you must direct the Kubernetes API server to authenticate via Run:ai. This requires adding flags to the Kubernetes API Server. Modfiying the API Server configuration differs between Kubernetes distributions:


=== "Native Kubernetes"
    * Locate the Kubernetes API Server configuration file. The file's location may defer between different Kubernetes distributions. The location for vanilla Kubernetes is `/etc/kubernetes/manifests/kube-apiserver.yaml`
    * Edit the document, under the `command` tag, add the __server__ configuration text from `General | Settings | Researcher Authentication` described above.   
    * Verify that the `kube-apiserver-<master-node-name>` pod in the `kube-system` namespace has been restarted and that changes have been incorporated. Run the below and verify that the _oidc_ flags you have added:

    ```
    kubectl get pods -n kube-system kube-apiserver-<master-node-name> -o yaml
    ```

=== "OpenShift"
    No configuration is needed. Instead, Run:ai assumes that an Identity Provider has been defined at the OpenShift level and that the Run:ai Cluster installation has set the `OpenshiftIdp` flag to true. For more information see the Run:ai OpenShift control-plane setup.

=== "Rancher"
    Edit Rancher `cluster.yml` (with Rancher UI, follow [this](https://rancher.com/docs/rancher/v2.x/en/cluster-admin/editing-clusters/#editing-clusters-in-the-rancher-ui){target=_blank}). Add the following:

    ``` YAML
        kube-api:
            always_pull_images: false
            extra_args:
              <parameters copied from server configuration section>
    ```

    You can verify that the flags have been incorporated into the RKE cluster by following the instructions [here](https://rancher.com/docs/rancher/v2.x/en/troubleshooting/kubernetes-components/controlplane/) and running `docker inspect <kube-api-server-container-id>`, where `<kube-api-server-container-id>` is the container ID of _api-server_ via obtained in the Rancher document. 

=== "GKE"
    See [Enable Identity Service for GKE](https://cloud.google.com/kubernetes-engine/docs/how-to/oidc#enable-oidc){target=_blank}. Use the parameters provided in the server configuration section as described above. 

=== "EKS"
    * In the AWS Console, under EKS, find your cluster.
    * Go to `Configuration` and then to `Authentication`.
    * Associate a new `identity provider`. Use the parameters provided in the server configuration section as described above. The process can take up to 30 minutes. 

=== "Other"
    See specific instructions in the documentation of the Kubernetes distribution.  


## Command-line Interface Access

To control access to Run:ai (and Kubernetes) resources, you must modify the Kubernetes configuration file. The file is distributed to users as part of the [Command-line interface installation](../../../researcher-setup/cli-install#kubernetes-configuration). 

When making changes to the file, keep a copy of the original file to be used for cluster administration. After making the modifications, distribute the modified file to Researchers. 

* Under the `~/.kube` directory edit the `config` file, remove the administrative user, and replace it with the __client__ configuration text from `General | Settings | Researcher Authentication` described above. 
* Under `contexts | context | user` change the user to `runai-authenticated-user`


## Test via Command-line interface

* Run: `runai login` (in OpenShift enviroments use `oc login` rather than `runai login`)
* You will be prompted for a username and password. In a single sign-on flow, you will be asked to copy a link to a browser, log in and return a code. 
* Once login is successful, submit a Job.
* If the Job was submitted with a Project for which you have no access, your access will be denied. 
* If the Job was submitted with a Project for which you have access, your access will be granted.

You can also submit a Job from the Run:ai User interface and verify that the new job shows on the job list with your user name. 

## Test via User Interface

* Open the Run:ai user interface. Go to `Jobs`
* On the top-right, select `Submit Job`. 

!!! Tip
    If you do not see the button or it is disabled, then you either do not have `Researcher` access or the cluster has not been set up correctly. For more information, refer to [user interface overview](../../admin-ui-setup/overview.md).

