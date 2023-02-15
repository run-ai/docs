---
title: SaaS Cluster Setup Introduction
---

This section is a step-by-step guide for setting up a Run:ai cluster. 

* A Run:ai cluster is installed on top of a Kubernetes cluster.
* A Run:ai cluster connects to the Run:ai control plane on the cloud. The control plane provides a control point as well as a monitoring and control user interface for Administrators and Researchers.
* A customer may have multiple Run:ai Clusters, all connecting to a single control plane.

For additional details see the [Run:ai system components](../../../home/components.md)

## Documents

* Review Run:ai cluster [prerequisites](cluster-prerequisites.md).
* Step-by-step [installation instructions](cluster-install.md).
* Look for [troubleshooting](../../troubleshooting/troubleshooting.md) tips if required.
* [Upgrade cluster](cluster-upgrade.md) and [delete cluster](cluster-delete.md) instructions. 


## Customization

For a list of optional customizations see [Customize Installation](customize-cluster-install.md)

## Additional Configuration

For a list of advanced configuration scenarios such as configuring researcher authentication, Single sign-on limiting the installation to specific nodes, and more, see the [Configuration Articles](../config/overview.md) section.

## Next Steps

After setting up the cluster, you may want to start setting up Researchers. See: [Researcher Setup](../../researcher-setup/researcher-setup-intro.md).

