## Introduction

There are a number of cases where you want to expose services running on the cluster. A few of them are:

*   Allow Researchers who work with containers to expose ports to access the container from remote using tools such as a _Jupyter notebook_ or _PyCharm_
*   Integrate a Researcher authentication mechanism such as an organizational user directory. 

The Kubernetes mechanism for exposing services is called _Ingress._

## Ingress

Ingress allows access to Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services. More information about ingress can be found <a href="https://kubernetes.io/docs/concepts/services-networking/ingress/" rel="noopener" target="_blank">here</a>

## Requirements

Before installing ingress, you must obtain an IP Address or an IP address range which is external to the cluster.

## Ingress Configuration

A Run:AI cluster is installed by accessing the Administrator User Interface at [app.run.ai](https://app.run.ai) downloading a yaml file runai-operator.yaml and then applying it to Kubernetes. You must edit the yaml file. Search for _localLoadBalancer_

    localLoadBalancer
        enabled: true
        ipRangeFrom: 10.0.2.1
        ipRangeTo: 10.0.2.2

Set _enabled_ to true and set the IP range appropriately.
