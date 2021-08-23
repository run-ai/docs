## Introduction

### Privileged Access

In docker, as well as in Kubernetes, the default for running containers is running as 'root'. The implication of running as root is that processes running within the container have enough permissions to change anything on the machine itself. 

This gives a lot of power to containers but does not sit well with modern security standards. Specifically enterprise security. To overcome that: 

* Kubernetes provides a mechanism called [PodSecurityPolicy (PSP)](https://kubernetes.io/docs/concepts/policy/pod-security-policy/) to control container access.
* OpenShift provides control over container access using [Security Context Constraints (SCC)](https://www.openshift.com/blog/understanding-service-accounts-sccs).

Run:AI supports both PSP and SCC. This support is at the [cluster installation](../cluster-setup/customize-cluster-install.md) level. 

### User Identity

The identity of the user in the container determines its access to cluster resources. For example, network file storage solutions typically use this identity to determine the container's access to network volumes. 


The Run:AI Command-line interface provides flags to control user identity within the container and to disable root access capabilities. 

## Command-Line Flags
There are two [runai submit](../../../Researcher/cli-reference/runai-submit.md) flags which control user identity at the Researcher level:

* The flag ``--run-as-user`` starts the container with a specific user. The user is the current Linux user or if connected via SAML provider, it can be the Linux UID/GID which is stored in the organization's directory. This requires exposing UID/GID as part of the SAML response. 
* The flag ``--prevent-privilege-escalation`` prevents the container from elevating its own privileges into root (e.g. running ``sudo`` or changing system files.). This flag is not relevant when using PSP or SCC. 

Note, that these flags are voluntary. They are not enforced by the system.

It is possible to set these flags as a __cluster-wide default__ for the Run:AI CLI, such that all CLI users will be limited to non-root containers.

## Setting a Cluster-Wide Default

Save the following in a file (cluster-config.yaml)

``` YAML

apiVersion: v1
data:
  config: |
    enforceRunAsUser: true
    enforcePreventPrivilegeEscalation: true
kind: ConfigMap
metadata:
  name: cluster-config
  namespace: runai
  labels:
    runai/cluster-config: "true"
```

Run:

    kubectl apply -f cluster-config.yaml

!!! Limitation
    Preventing privilege escalation at the cluster level limits non-root for all Run:AI __CLI__ users. However, it does not prevent users or malicious actors from starting containers directly via Kubernetes API (e.g. via YAML files). To fully secure the system use _PSP_ or work with _OpenShift SCC_.
 

## Creating a Temporary Home Directory

For containers to run as a specific user, the user needs to have a pre-created home directory within the image. This can be a daunting IT task. 

To overcome this, Run:AI provides an additional flag `--create-home-dir`. Adding this flag creates a temporary home directory for the user within the container.  

!!! Notes
    * Data saved in this directory will not be saved when the container exits. 
    * This flag is set by __default to true__ when the `--run-as-user` flag is used, and false if not.