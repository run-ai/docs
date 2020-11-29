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

.... add here...  HOW to get it...  

Client ID

Client Secret


## Client-Side

* Install [kubelogin](https://github.com/int128/kubelogin) 
* Under the `~/.kube` directory edit the `config` file, and add the following:

``` YAML
users:
- name: <USER_NAME>
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - oidc-login
      - get-token
      - --oidc-issuer-url=https://runai-prod.auth0.com/
      - --oidc-client-id=<CLIENT_ID>
      - --oidc-client-secret=<CLIENT_SECRET>
      command: kubectl
      env: null
```

Where `<USER_NAME>` is an arbitrary name which is also referred to under `contexts | context | user` in the same file.

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
     - --oidc-issuer-url=https://runai-test.auth0.com/
     - --oidc-username-prefix=-
```

Restart API Server (is this needed or does it happen automatically? )

```
kubectl delete pod kube-apiserver-master -n kube-system
```

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


## INTERNAL STUFF, SHOULD BE DONE/AUtomated and REMOVED from here. 

auth0 setup:

* add localhost:8000 to callbacks
* Something about web application, but probably not interesting
* Style the Login page. 
 