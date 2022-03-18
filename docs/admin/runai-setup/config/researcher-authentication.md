# Setup Project-based Researcher Access Control

## Introduction

The following instructions explain how to complete the configuration of access control for Researchers. Run:AI access control is at the __Project__ level. When you assign Users to Projects - only these users are allowed to submit Jobs and access Jobs details. 

This requires a number of steps:

* Assigning users to their Projects
* (Command-line Interface access only) Modify the Kubernetes profile so as to prompt the Researcher for credentials when running `runai login` (or `oc login` for OpenShift). 
* Modify the Kubernetes entry point (called the `Kubernetes API server`) to validate credentials of incoming requests against the Run:AI Authentication authority.

## Administration User Interface Setup

### Enable Researcher Authentication

* Open the Run:AI user interface and navigate to `General | Settings`. 
* Enable the flag _Researcher Authentication_ (should be enabled by default for new tenants).
* There are values for `Realm`, `client configuration`, and `server configuration` which appear on the screen. Use them as below. 


### Assign Users to Projects

Assign Researchers to Projects:

* Open the Run:AI user interface and navigate to `Users`. Add a Researcher and assign it with a _Researcher_ role.
* Navigate to `Projects`, edit or create a Project. Use the `Access Control` tab to assign the Researcher to the Project. 
* If you are using Single Sign-on, you can also assign _Groups_. For more information see the [Single Sign-on](sso.md) documentation.

## Command-line Interface Access

To control access to Run:AI (and Kubernetes) resources, you must modify the Kubernetes configuration file. The file is distributed to users as part of the [Command-line interface installation](../../../researcher-setup/cli-install#kubernetes-configuration). 

When making changes to the file, keep a copy of the original file to be used for cluster administration. After making the modifications, distribute the modified file to Researchers. 

* Under the `~/.kube` directory edit the `config` file, remove the administrative user and replace with the __client__ configration text from `General | Settings | Researcher Authentication` described above. 
* Under `contexts | context | user` change the user to `runai-authenticated-user`


## (Mandatory) Kubernetes Configuration

* Locate the Kubernetes API Server configuration file. The file's location may defer between different Kubernetes distributions. The location for vanilla Kubernetes is `/etc/kubernetes/manifests/kube-apiserver.yaml`
* Edit the document, under the `command` tag, add the __server__ configration text from `General | Settings | Researcher Authentication` described above.   
* Verify that the `kube-apiserver-<master-node-name>` pod in the `kube-system` namespace has been restarted and that changes have been incorporated. Run the below and verify that the _oidc_ flags you have added:

```
kubectl get pods -n kube-system kube-apiserver-<master-node-name> -o yaml
```


### Special Instructions for other Kubernetes Distributions 

The method for adding API server flags differs between different Kubernetes distributions. Descriptions for Rancher and OpenShift can be found below. Other distributions and specifically managed Kubernetes (e.g. GKE, AKS, EKS) have specialized instructions. 

### OpenShift

With OpenShift, the above configuration is not needed. Instead, Run:AI assumes that an Identity Provider has been defined at the OpenShift level and that the Run:AI Cluster installation has set the `OpenshiftIdp` flag to true. For more information see the Run:AI OpenShift control-plane setup.
### Rancher

Edit Rancher `cluster.yml` (with Rancher UI, follow [this](https://rancher.com/docs/rancher/v2.x/en/cluster-admin/editing-clusters/#editing-clusters-in-the-rancher-ui){target=_blank}). Add the following:

``` YAML
    kube-api:
        always_pull_images: false
        extra_args:
          <parameters copied from server configuration section>
```

You can verify that the flags have been incorporated into the RKE cluster by following the instructions [here](https://rancher.com/docs/rancher/v2.x/en/troubleshooting/kubernetes-components/controlplane/) and running `docker inspect <kube-api-server-container-id>`, where `<kube-api-server-container-id>` is the container ID of _api-server_ via obtained in the Rancher document. 


## Test

* Run: `runai login` (in OpenShift enviroments use `oc login` rather than `runai login`)
* You will be prompted for a username and password. In a single sign-on flow, you will be asked to copy a link to a browser, log in and return a code. 
* Once login is successful, submit a Job.
* If the Job was submitted with a Project for which you have no access, your access will be denied. 
* If the Job was submitted with a Project for which you have access, your access will be granted.

You can also submit a Job from the Run:AI User interface and verify that the new job shows on the job list with your user name. 

 
<!-- ### Enable Researcher Authentication on Researcher Service

=== "SaaS" 
    The researcher service is used for the [Run:AI Researcher User interface](../../../researcher-setup/researcher-ui-setup/) and [Researcher REST API](../../../../developer/researcher-rest-api/overview/). To enable, you must edit the cluster installation values file:

    * When installing the Run:AI cluster, edit the [values file](/admin/runai-setup/cluster-setup/cluster-install/#step-3-install-runai).
    * On an existing installation, use the [upgrade](/admin/runai-setup/cluster-setup/cluster-upgrade) cluster instructions to modify the values file.

    Update:

    ``` yaml
    runai-operator:
       config:
          researcher-service:
            args:
              authEnabled : true
    ```

=== "Self-hosted" -->