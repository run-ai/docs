# Setup Project-based Researcher Access Control

## Introduction

By default, Run:AI is configured to allow all Researchers access to all Jobs and Projects.  This document provides step-by-step instructions on how to enable access-control. Run:AI access control is at the __Project__ level. When you assign Users to Projects - only these users are allowed to submit Jobs and access Jobs details. 

## How it works

The Run:AI command-line interface uses a Kubernetes configuration file residing on a client machine. The configuration file contains information on how to access the Kubernetes cluster and hence the Run:AI 

Authentication setup works as follows:

* __Client-side:__ Modify the Kubernetes configuration file to prompt for credentials.
* __Server-side:__ Modify the Kubernetes cluster to validate credentials against the Run:AI Authentication authority. 
* __Assign Users to Projects__ using the Run:AI Administration UI.

## What you need

You should receive the following data from Run:AI Customer support:

* Client ID
* Auth0 Realm


## Client-Side

To control access to Run:AI (and Kubernetes) resources, you must modify the Kubernetes certificate. The certificate is distributed to users as part of the [Comnand-line interface installation](../../Researcher-Setup/cli-install#kubernetes-configuration). 

When making changes to the certificate, keep a copy of the original certificate to be used for cluster administration. After making the modifications, distribute the modified certificate to Researchers. 

Under the `~/.kube` directory edit the `config` file, and add the following:

``` YAML
- name: <USER_NAME>
  user:
    auth-provider:
      config:
        auth-flow: cli
        auth0-realm: <AUTH0_REALM>
        client-id: <CLIENT_ID>
        idp-issuer-url: https://runai-prod.auth0.com/
      name: oidc
```

Where `<USER_NAME>` is an arbitrary name which is also referred to under `contexts | context | user` in the same file.


* Distribute modified certificate to Rsearechers. 
* On Researchers machine, install [kubelogin](https://github.com/int128/kubelogin){target=_blank}. Depending on the installation method, you may need to add the kubelogin installation directory to your `PATH`.


## Server-Side

Locate the Kubernetes API Server configuration file. The file's location may defer between different Kubernetes distributions. The default location is `/etc/kubernetes/manifests/kube-apiserver.yaml`

Add the following: 

``` YAML
 spec:
   containers:
   - command:
     ...
     ...
     - --oidc-client-id=<CLIENT_ID>
     - --oidc-issuer-url=https://runai-prod.auth0.com/
     - --oidc-username-prefix=-
```

Verify that the `kube-apiserver-master` pod in the `kube-system` namespace has been restarted and that changes have been incorporated. Run:

```
kubectl get pods -n kube-system kube-apiserver-master -o yaml
```

And search for the above _oidc_ flags. 


## Assigning Users to Projects

* Go to [app.run.ai/general-settings](https://app.run.ai/general-settings) and enable the flag __Allow assigning Users to Projects__.
* Assign a Researcher to a Project:
    * Under [Users](https://app.run.ai/users) add the Researcher and assign it with a _Researcher_ role.
    * Under [Projects](https://app.run.ai/projects) assign the Researcher to the right projects. 


## Testing

* Submit a Job.
* You will be redirected to a browser page that requires authentication. If you are using a machine without a browser, you will be prompted with a URL to run elsewhere and return a resulting token. 
* If the job was submitted with a Project for which you have no access, your access will be denied. 
* If the Job was submitted with a Project for which you have access, your access will be granted.
* Existing Jobs in Projects you do __not__ have access to, will show when you run `runai job list -p <project-name>` but you will not be able to view logs, get further info, bash into or delete. 

 