# Setup Project-based Researcher Access Control

## Introduction

By default, Run:AI is configured to allow all Researchers access to all Jobs and Projects.  This document provides step-by-step instructions on how to enable access control. Run:AI access control is at the __Project__ level. When you assign Users to Projects - only these users are allowed to submit Jobs and access Jobs details. 

## Configuration Options

This document relates to several separate configuration flows: 

1. Classic (SaaS) installation of Run:AI 
2. Self-hosted installation of Run:AI
3. Single sign-on (or SSO). Both SaaS and Self-hosted are covered under this flow. To enable SSO you should start by following the [single-sign on](sso.md) instructions.

Additional notes are available below for  __Rancher Kubernetes Engine (RKE)__


## How it works

The Run:AI command-line interface uses a Kubernetes configuration file residing on a client machine. The configuration file contains information on how to access the Kubernetes cluster and hence the Run:AI 

Authentication setup works as follows:

* __Administration User Interface Setup__. Enable the feature.
* __Assign Users to Projects__ using the Run:AI Administration UI. See [here](../../admin-ui-setup/project-setup/#assign-users-to-project)
* __Client-side:__ Modify the Kubernetes configuration file to prompt for credentials.
* __Server-side:__ Modify the Kubernetes cluster to validate credentials against the Run:AI Authentication authority. 


## Administration User Interface Setup

### Enable Researcher Authentication

=== "SaaS" 
    Go to [app.run.ai/general-settings](https://app.run.ai/general-settings){target=_blank}.

=== "Self-hosted"
    Go to `runai.<company-name>/general-settings`.


* Enable the flag _Researcher Authentication_.
* Copy the values for `Client ID` and `Realm` which appear on the screen. Use them as below. 

### Enable Researcher Authentication on Researcher Service

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

=== "Self-hosted"

### Assign Users to Projects

Assign Researchers to Projects:

=== "SaaS" 
    * Under [Users](https://app.run.ai/permissions) add a Researcher and assign it with a _Researcher_ role.
    * Under [Projects](https://app.run.ai/projects), edit or create a Project. Use the _Users_ tab to assign the Researcher to the Project. 

=== "Self-hosted"
    * Under `runai.<company-name>/permissions` add a Researcher and assign it with a _Researcher_ role.
    * Under `runai.<company-name>/projects`, edit or create a Project. Use the _Users_ tab to assign the Researcher to the Project. 

## Client-Side

To control access to Run:AI (and Kubernetes) resources, you must modify the Kubernetes configuration file. The file is distributed to users as part of the [Command-line interface installation](../../../researcher-setup/cli-install#kubernetes-configuration). 

When making changes to the file, keep a copy of the original file to be used for cluster administration. After making the modifications, distribute the modified file to Researchers. 

Under the `~/.kube` directory edit the `config` file, remove the administrative user and replace with the following:

=== "SaaS" 
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

=== "Self-hosted"
    ``` YAML
    - name: runai-authenticated-user
      user:
        auth-provider:
          config:
            airgapped: "true"
            auth-flow: cli
            realm: runai
            client-id: runai
            idp-issuer-url: https://<COMPANY-URL>/auth/realms/runai
          name: oidc
    ```

=== "SSO SaaS" 
    ``` YAML
    - name: runai-authenticated-user
      user:
        auth-provider:
          config:
            airgapped: "true"
            auth-flow: remote-browser
            realm: <REALM>
            client-id: runai-cli-sso
            subject-claim-field: email
            idp-issuer-url: https://app.run.ai/auth/realms/<REALM>
            redirect-uri: https://app.run.ai/oauth-code
          name: oidc
    ```

=== "SSO Self-hosted" 
    ``` YAML
    - name: runai-authenticated-user
      user:
        auth-provider:
          config:
            airgapped: "true"
            auth-flow: remote-browser
            realm: <REALM>
            client-id: runai-cli-sso
            subject-claim-field: email
            idp-issuer-url: https://<COMPANY-URL>/auth/realms/runai
            redirect-uri: https://<COMPANY-URL>/oauth-code
          name: oidc
    ```


Under `contexts | context | user` change the user to `runai-authenticated-user`


## Server-Side

Locate the Kubernetes API Server configuration file. The file's location may defer between different Kubernetes distributions. The default location is `/etc/kubernetes/manifests/kube-apiserver.yaml`

Edit the document to add the following parameters at the end of the existing command list:


=== "SaaS" 
    ``` YAML
    spec:
      containers:
      - command:
        ... 
        - --oidc-client-id=<CLIENT_ID>
        - --oidc-issuer-url=https://runai-prod.auth0.com/
        - --oidc-username-prefix=-
    ```


=== "Self-hosted"
    ``` YAML
    spec:
        containers:
        - command:
        ... 
        - --oidc-client-id=runai
        - --oidc-issuer-url=https://<COMPANY-URL>/auth/realms/runai
        - --oidc-username-prefix=-
    ```
 
    
=== "SSO SaaS" 
    ``` YAML
    spec:
      containers:
      - command:
        ... 
        - --oidc-client-id=runai-cli-sso
        - --oidc-issuer-url=https://app.run.ai/auth/realms/<REALM>
        - --oidc-username-prefix=-
        - --oidc-username-claim=email
    ``` 

=== "SSO Self-hosted" 
    ``` YAML
    spec:
      containers:
      - command:
        ... 
        - --oidc-client-id=runai-cli-sso
        - --oidc-issuer-url=https://<COMPANY-URL>/auth/realms/runai
        - --oidc-username-prefix=-
        - --oidc-username-claim=email
    ``` 


Verify that the `kube-apiserver-<master-node-name>` pod in the `kube-system` namespace has been restarted and that changes have been incorporated. Run:

```
kubectl get pods -n kube-system kube-apiserver-<master-node-name> -o yaml
```

And search for the above _oidc_ flags. 

### Rancher-specific instructions:


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

These flags relate to the _SaaS_ installation. For _SSO_ or _Self-hosted_, adapt the flags from the relevant option above. 

You can verify that the flags have been incorporated into the RKE cluster by following the instructions [here](https://rancher.com/docs/rancher/v2.x/en/troubleshooting/kubernetes-components/controlplane/) and running `docker inspect <kube-api-server-container-id>`, where `<kube-api-server-container-id>` is the container ID of _api-server_ via obtained in the Rancher document. 


## Test

* Run: `runai login` (in OpenShift enviroments use `oc login` rather than `runai login`)
* You will be prompted for a username and password. In an SSO flow, you will be asked to copy a link to a browser, log in and return a code. 
* Once login is successful, submit a Job.
* If the Job was submitted with a Project for which you have no access, your access will be denied. 
* If the Job was submitted with a Project for which you have access, your access will be granted.

 
