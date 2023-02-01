# Run:ai Version 2.9

## Release Date
February 2023 

## Release Content
<!-- 
* Now supporting _spread_ scheduling strategy as well. For more information see [scheduling strategies](../Researcher/scheduling/strategies.md). -->

### Cluster Installation Enhancements

#### Cluster Prerequisites 
* Prometheus is no longer installed together with Run:ai. You must install the [Prometheus stack](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#prometheus) before installing Run:ai. This helps install Run:ai for organizations that already have Prometheus installed as the monitoring tool of choice in the cluster. The Run:ai installation configures the existing Prometheus with a custom set of rules designed to extract metrics from the cluster. 
* NGINX is no longer installed together with Run:ai. You must install an [Ingress controller](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#ingress-controller) before installing Run:ai. This helps install Run:ai for organizations that already have an ingress controller installed. The Run:ai installation creates NGINX rules to work with the controller. 
* A full list of Prerequisites can be found [here](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#prerequisites-in-a-nutshell).
* The Run:ai installation now performs a series of checks to verify the validity of the installation. Post-installation you can review this [verififcation](../admin/runai-setup/cluster-setup/cluster-install.md#verify-your-installation) by describing a `configMap` file. List of checks: 
    * Are all mandatory prerequisites met? 
    * Are optional prerequisites met?
    * Does the cluster have connectivity to the Run:ai control plane?
    * Does Run:ai support the underlying Kubernetes version?

#### Control plane Prerequisites

* Run:ai control plane installation no longer installs NGINX. Instead, the customer must pre-install an ingress controller. 
* The default persistent storage is now a default storage class preconfigured in Kubernetes rather than the older NFS assumptions. NFS flags in `runai-adm generate-values` still exist for backward compatibility. 

#### Other

* The cluster wizard, in a self-hosted configuration, now provides an option to select cluster location: `Same as Control Plane` or `Remote to control plane`. This allows for multiple clusters to be more easily configured.
* The SaaS version of Run:ai can now be installed from the RedHat [catalog](https://catalog.redhat.com/software/operators/detail/60be3acc3308418324b5e9d8){target=_blank}.

---
### need to think
API deprecation?

### Authentication
Openshift groups

SSO Logout

GID/UID for SSO users

SSO: block access to Run:ai

SSO: timeout

* SSO Logout URL. It is possible to configure the redirect URL when the [user session ends](../admin/runai-setup/authentication/sso.md#logout-url). This can be done via Customer support. 

-----


DRF incl nodepools + drf

Workspaces

RedHat Marketplace

Multi Nodepools

New nodes Screen

Consumption Report

Audit Log (ui)

Idle jobs timeout

New nodes (and nodepools) screen Y (for nodepools addition to nodes screen)

Dashboard: new nodes metrics

Per node GPU metrics

Matlab support

Integrations and external tools support (WS)


### Newly Supported Software
* Run:ai now supports Kubernetes 1.25 and 1.26. 
* Run:ai now supports Openshift 4.11
* Run:ai now supports Dynamic MIG with NVIDIA H100 hardware
* The Run:ai command-line interface now supports Microsoft Windows. See [here](../admin/researcher-setup/cli-install.md#install-runai-cli).



## Known Issues

|Internal ID| Description  | Workaround   |
|-----------|--------------|--------------|



## Fixed Issues

|Internal ID | Description   |
|------------|---------------|


