Following is a step by step guide for setting up a new Run:AI cluster.

## Prerequisites

### Kubernetes Cluster Prerequisites

Run:AI is running on top of Kubernetes. For a list of prerequisites, see [GPU Cluster Prerequisites](Run-AI-GPU-Cluster-Prerequisites.md).

## Installation

For step by step installation instructions see: [Installing Run:AI on an on-premise Kubernetes-Cluster](Installing-Run-AI-on-an-on-premise-Kubernetes-Cluster.md).

Troubleshooting tips can be found here: [Troubleshooting a Run AI Cluster installation](Troubleshooting-a-Run-AI-Cluster-Installation.md).


## Advanced Topics

### Setting up the Cluster to expose ports from containers

There are various ways to allow researchers to expose ports from containers. Typical use cases are: Use a Jupyter Notebook, Work remotely with PyCharm, Use TensorBoard, and more. Exposing ports requires a pre-configuration of the Kubernetes Cluster. For more details see: [Exposing Ports from Researcher Containers](Exposing-Ports-from-Researcher-Containers-using-Ingress.md).

### Settings up Admin UI Authentication and Authorization

You may want to set up authentication (user login) and authorization (granular access control). Without which, any researcher can access and change the workloads of others. For further details on how to set up researcher authentication and authorization see: [Use OpenID Connect LDAP or SAML for Authentication and Authorization](Use-OpenID-Connect-LDAP-or-SAML-for-Authentication-and-Authorization-.md).

### Setting up a Run:AI to work with an Internet Proxy Server

In some organizations, outbound connectivity is proxied. Traffic originating from servers and browsers within the organizations flows through a gateway that inspects the traffic, calls the destination and returns the contents. To setup Run:AI to work with a proxy server see: [Installing Run AI with an Internet Proxy Server](Installing-Run-AI-with-an-Internet-Proxy-Server-.md).

## Next Steps

After setting up the cluster, you may want to start setting up researchers. See: [Researcher Setup](../Researcher-Setup/Researcher-Setup-Start-Here.md).

