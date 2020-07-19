# Cluster Setup: Start Here
<span>Following is a step by step guide for setting up a new Run:AI cluster.</span>

# Prerequisites

## Kubernetes Cluster Prerequisites

Run:AI is running on top of Kubernetes. For a list of prerequisites, see [GPU Cluster Prerquisites](Run-AI-GPU-Cluster-Prerequisites.md)

# Installation

See here for a step by step installation instructions:&nbsp;<https://support.run.ai/hc/en-us/articles/360010280179-Installing-Run-AI-on-an-on-premise-Kubernetes-Cluster>&nbsp;

Troubleshooting tips can be found here:&nbsp;<https://support.run.ai/hc/en-us/articles/360010569960-Troubleshooting-a-Run-AI-installation>

# Advanced Topics

## Setting up the Cluster to expose ports from containers

There are various ways to allow researchers to expose ports from containers. Typical use cases are: Use a Jupyter Notebook, Work remotely with PyCharm, Use TensorBoard, and more. Exposing ports requires a pre-configuration of the Kubernetes Cluster. For more details see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011813620-Exposing-Ports-from-Researcher-Containers>&nbsp;

## Settings up Admin UI Authentication and Authorization

You may want to set up authentication (user login) and authorization (granular access control). Without which, any researcher can access and change the workloads of others. For further details on how to set up researcher authentication and authorization see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011912339-Use-OpenID-Connect-LDAP-or-SAML-for-Authentication-and-Authorization->&nbsp;

## Setting up a Run:AI to work with an Internet Proxy Server

<span>In some organizations, outbound connectivity is proxied. Traffic originating from servers and browsers within the organizations flows through a gateway that inspects the traffic, calls the destination and returns the contents. To setup Run:AI to work with a proxy server see:&nbsp;</span><a href="https://support.run.ai/hc/en-us/articles/360014226400-Installing-Run-AI-with-an-Internet-Proxy-Server-" target="_self">https://support.run.ai/hc/en-us/articles/360014226400-Installing-Run-AI-with-an-Internet-Proxy-Server-</a>

# Next Steps

After setting up the cluster, you may want to start setting up researchers. See:&nbsp;<https://support.run.ai/hc/en-us/articles/360012060639-Researcher-Setup-Start-Here>&nbsp;

&nbsp;
&nbsp;