# Working with a Local Certificate Authority

Run:ai can be installed in an isolated network. In this [air-gapped](../installation-types.md#self-hosted-installation) configuration, the organization will not be using an established [root certificate authority](https://csrc.nist.gov/glossary/term/root_certificate_authority){target=_blank}. Instead, the organization creates a local certificate which serves as the root certificate for the organization. The certificate is installed in all browsers within the organization. 

In the context of Run:ai, the cluster and control-plane need to be aware of this certificate for consumers to be able to connect to the system.

## Preparation

You will need to have the public key of the local certificate authority. 
<!-- 
## Control-Plane Installation

* Add the public key to the `runai-backend` namespace

```
kubectl -n runai-backend create secret generic runai-ca-cert   --from-file=runai-ca.pem=./runai-ca.pem
```

* When installing the control plane add a reference to the public key as follows

```
helm upgrade -i runai-backend ...... --set xxxxx
```

## Cluster Installation -->



