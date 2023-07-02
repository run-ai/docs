# Installing additional Clusters

The first Run:ai cluster is typically installed on the same OpenShift cluster as the Run:ai control plane. Run:ai supports multiple clusters per single control plane. This document is about installing additional clusters on different OpenShift clusters.

The instructions are for Run:ai version __2.13__ and up.

!!! Limitation
    When you log in, you do so in the context of a specific cluster. When you switch to a different cluster, you will be prompted to log in to that cluster. 

## Configuration
The exact configuration details must be worked together with Run:ai customer support. 

## Additional Cluster Installation

Create a new cluster, then:

* Select a target platform `OpenShift` 
* Select a Cluster location `Remote to Control Plane`.
* You must enter a specific cluster URL with the format `https://runai.apps.<BASE_DOMAIN>`. To get the base Domain run `oc get dns cluster -oyaml | grep baseDomain`
* Ignore the instructions for creating a secret.

## Login

When configured, you will see an option to choose a cluster at the bottom of the login screen:

![](img/ocp-multi-cluster-login.png)
