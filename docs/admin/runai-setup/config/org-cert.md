---
title: # Working with a Local Certificate Authority
summary: This article describes how to use a certificate in an air gapped system.
authors:
    - Jason Novich
    - Yaron Goldberg
date: 2023-1-Nov
---

Run:ai can be installed in an isolated network. In this [air-gapped](../installation-types.md#self-hosted-installation) configuration, the organization will not be using an established [root certificate authority](https://csrc.nist.gov/glossary/term/root_certificate_authority){target=_blank}. Instead, the organization creates a local certificate which serves as the root certificate for the organization. The certificate is installed in all browsers within the organization. 

In the context of Run:ai, the cluster and control-plane need to be aware of this certificate for consumers to be able to connect to the system.

## Preparation

You will need to have the public key of the local certificate authority. 

## Control-Plane Installation

* Create the `runai-backend` namespace if it does not exist. 
* Add the public key to the `runai-backend` namespace:
```
kubectl -n runai-backend create secret generic runai-ca-cert \ 
    --from-file=runai-ca.pem=<ca_bundle_path>
```

* As part of the installation instructions you need to create a secret for [runai-backend-tls](../self-hosted/k8s/backend.md#domain-certificate). Use the local certificate authority instead.
* Install the control plane, add the following flag to the helm command `--set global.customCA.enabled=true`

## Cluster Installation

=== "Non-Openshift"
    * Create the `runai` namespace if it does not exist. 
    * Add the public key to the `runai` namespace:
    ```
    kubectl -n runai create secret generic runai-ca-cert \
        --from-file=runai-ca.pem=<ca_bundle_path>
    ```
=== "Openshift"
    * Add the public key to the `openshift-monitoring` namespace:
    ```
    kubectl -n openshift-monitoring create secret generic runai-ca-cert \
        --from-file=runai-ca.pem=<ca_bundle_path>
    ```
* Install the Run:ai operator, add the following flag to the helm command `--set global.customCA.enabled=true`




