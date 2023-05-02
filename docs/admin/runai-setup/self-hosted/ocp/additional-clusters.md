# Installing additional Clusters

The first Run:ai cluster is typically installed on the same OpenShift cluster as the Run:ai control plane. Run:ai supports multiple clusters per single control plane. This document is about installing additional clusters on __different OpenShift clusters__.

The instructions are for Run:ai version __2.11__ and up.


## Installation

Create a new cluster, then:

* Select a target platform `OpenShift` 
* Select a Cluster location `Remote to Control Plane`.
* You must enter a very specific cluster URL with the format `https://runai.apps.<BASE_DOMAIN>`. To get the base Domain run `oc get dns cluster -oyaml | grep baseDomain`
* Ignore the instructions on creating a secret.

