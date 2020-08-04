## Introduction

In docker, as well as in Kubernetes, the default for running containers is running as 'root'. The implications of running as root is that the process within the container has enough permissions to change anything on the machine. 

This gives a lot of power to containers, but does not sit well with modern security standards. Specifically enterprise security. 

It is possible to start a container without root access. See the flag ``--run-as-user`` under [runai submit](../../Researcher/Command-Line-Interface-API-Reference/runai-submit.md). However, this flag is voluntary and is not enforced by the system

The purpose of this document is to set a cluster-wide default for the Run:AI CLI, such that all CLI users will be limited to non-root containers

## Setting a Cluster-Wide Default

Save the following in a file (cluster-config.yaml)

    apiVersion: v1
    data:
    config: |
        enforceRunAsUser: true
    kind: ConfigMap
    metadata:
    name: cluster-config
    namespace: runai
    labels:
        runai/cluster-config: "true"

Run:

    kubectl apply -f cluster-config.yaml

## Limitations

This configuration limits non-root for all Run:AI __CLI__ users. However, it does not prevent users or malicious actors from starting containers directly via Kubernetes API (e.g. via YAML files). There are third party enterprise tools that can provide this level of security. 
 