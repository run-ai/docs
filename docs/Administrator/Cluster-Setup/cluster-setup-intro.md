This section is a step by step guide for setting up a Run:AI cluster. 

* A Run:AI cluster is installed on top of a Kubernetes cluster.
* A Run:AI cluster connects to the Run:AI backend on the cloud. The backend provides a control point as well as a monitoring and control user interface for Administrators.
* A customer may have multiple Run:AI Clusters, all connecting to a single backend.

For additional details see the [Run:AI system components](../../home/components.md)

## Documents

* Review Run:AI cluster [prerequisites](cluster-prerequisites.md).
* Step by step [installation instructions](cluster-install.md).
* Look for [troubleshooting](cluster-troubleshooting.md) tips if required.
* [Upgrade cluster](cluster-upgrade.md) and [delete cluster](cluster-delete.md) instructions. 


## Customization

As part of the installation process, you will download a __Run:AI Operator YAML file__ and apply it to the cluster. Before applying the file, you will often need to customize the file. For a list of customization see [Cluster Install, section 3.2](../Installing-Run-AI-on-an-on-premise-Kubernetes-Cluster/#step-32-customized-installation)

## Advanced Setup

For advanced scenarios such as [limiting the installation to specific cluster nodes](limit-runai-install-to-specific-nodes.md) or [enforcing none-root containers](enforce-run-as-user.md) see the _Advanced_ section.

## Next Steps

After setting up the cluster, you may want to start setting up researchers. See: [Researcher Setup](../Researcher-Setup/researcher-setup-intro.md).

