# Setup Project-based Researcher Access Control

## Introduction

By default, Run:AI is configured to allow all Researchers access to all Jobs and Projects.  This document provides step-by-step instructions on how to enable access control. Run:AI access control is at the __Project__ level. When you assign Users to Projects - only these users are allowed to submit Jobs and access Jobs details. 

## How it works

The Run:AI command-line interface uses a Kubernetes configuration file residing on a client machine. The configuration file contains information on how to access the Kubernetes cluster and hence the Run:AI 

Authentication setup works as follows:

* __Administration User Interface Setup__. Enable the feature.
* __Client-side:__ Modify the Kubernetes configuration file to prompt for credentials.
* __Server-side:__ Modify the Kubernetes cluster to validate credentials against the Run:AI Authentication authority. 
* __Assign Users to Projects__ using the Run:AI Administration UI. See [here](../../admin-ui-setup/project-setup/#assign-users-to-project)


## Administration User Interface Setup

### Enable Researcher Authentication

Under [app.run.ai](https://app.run.ai/general-settings) settings:

* Enable the flag _Researcher Authentication_.
* Copy the values for `Client ID` and `Realm` which appear on the screen. 

### Assign Users to Projects

Assign Researchers to Projects:

* Under [Users](https://app.run.ai/users) add a Researcher and assign it with a _Researcher_ role.
* Under [Projects](https://app.run.ai/projects), edit or create a Project. Use the _Users_ tab to assign the Researcher to the Project. 


## Client-Side

To control access to Run:AI (and Kubernetes) resources, you must modify the Kubernetes certificate. The certificate is distributed to users as part of the [Comnand-line interface installation](../../Researcher-Setup/cli-install#kubernetes-configuration). 

When making changes to the certificate, keep a copy of the original certificate to be used for cluster administration. After making the modifications, distribute the modified certificate to Researchers. 

Under the `~/.kube` directory edit the `config` file, and add the following:

``` YAML
- name: runai-authenticated-user
  user:
    auth-provider:
      config:
        auth-flow: cli
        realm: <REALM>
        client-id: <CLIENT_ID>
        idp-issuer-url: https://runai-prod.auth0.com/
      name: oidc
```

Under `contexts | context | user` change the user to `runai-authenticated-user`


You must distribute the modified certificate to Researchers. 


## Server-Side

Locate the Kubernetes API Server configuration file. The file's location may defer between different Kubernetes distributions. The default location is `/etc/kubernetes/manifests/kube-apiserver.yaml`

Edit the document to add the following parameters at the end of the existing command list:


=== "Kubernetes"
    ``` YAML
    spec:
      containers:
      - command:
        ... 
        - --oidc-client-id=<CLIENT_ID>
        - --oidc-issuer-url=https://runai-prod.auth0.com/
        - --oidc-username-prefix=-
        - --oidc-groups-claim=email
    ```

    Verify that the `kube-apiserver-<master-node-name>` pod in the `kube-system` namespace has been restarted and that changes have been incorporated. Run:

    ```
    kubectl get pods -n kube-system kube-apiserver-<master-node-name> -o yaml
    ```

    And search for the above _oidc_ flags. 

=== "RKE"
    Edit Rancher `cluster.yml` (with Rancher UI, follow [this](https://rancher.com/docs/rancher/v2.x/en/cluster-admin/editing-clusters/#editing-clusters-in-the-rancher-ui){target=_blank}). Add the following:

    ``` YAML
        kube-api:
          always_pull_images: false
          extra_args:
            oidc-client-id: <CLIENT_ID>
            oidc-groups-claim: email
            oidc-issuer-url: 'https://runai-prod.auth0.com/'
            oidc-username-prefix: '-'
    ```

    You can verify that the flags have been incorporated into the RKE cluster by following the instructions [here](https://rancher.com/docs/rancher/v2.x/en/troubleshooting/kubernetes-components/controlplane/) and running `docker inspect <kube-api-server-container-id>`, where `<kube-api-server-container-id>` is the container ID of _api-server_ via obtained in the Rancher document. 


## Test

* Submit a Job.
* You will be redirected to a browser page that requires authentication. If you are using a machine without a browser, you will be prompted with a URL to run elsewhere and return a resulting token. 
* If the Job was submitted with a Project for which you have no access, your access will be denied. 
* If the Job was submitted with a Project for which you have access, your access will be granted.
* Existing Jobs in Projects you do __not__ have access to, will show when you run `runai job list -p <project-name>` but you will not be able to view logs, get further info, bash into or delete. 

 
