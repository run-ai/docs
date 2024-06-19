# Installing additional clusters

The first Run:ai cluster is typically installed on the same OpenShift cluster as the Run:ai control plane. Run:ai supports multiple clusters per single control plane. This document is about installing additional clusters on different OpenShift clusters.

The instructions are for Run:ai version **2.13** and up.

## Configuration

The exact configuration details must be worked on together with Run:ai customer support.

## Additional cluster installation

Create a new cluster, then:

* Select a target platform `OpenShift`
* Select a Cluster location `Remote to Control Plane`.
* You must enter a specific cluster URL with the format `https://runai.apps.<BASE_DOMAIN>`. To get the base Domain run `oc get dns cluster -oyaml | grep baseDomain`
* Ignore the instructions for creating a secret.
