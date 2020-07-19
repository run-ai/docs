## Introduction

There are a number of cases where you want to expose services running on the cluster. A few of them are:

*   Allow Researchers who work with containers to expose ports to access the container from remote using tools such as a Jupyter notebook or PyCharm
*   Integrate a Researcher authentication mechanism such as an organizational user directory.&nbsp;

The Kubernetes mechanism for exposing services is called&nbsp;_Ingress.&nbsp;_

## <span>Ingress</span>

Ingress allows access to Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services. More information about ingress can be found <a href="https://kubernetes.io/docs/concepts/services-networking/ingress/" rel="noopener" target="_blank">here</a>

## <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Requirements</span>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Before installing ingress, you must obtain an IP Address or an IP address range which is external to the cluster.&nbsp;</span>

## <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Ingress Configuration</span>

A Run:AI cluster is installed by accessing the Administrator User Interface at <a href="https://app.run.ai" rel="noopener" target="_blank">app.run.ai</a> downloading a yaml file _runai-operator.yaml&nbsp;_and then _applying_ it to Kubernetes. You must edit the yaml file. Search for _localLoadBalancer_

<pre>localLoadBalancer<br/>  enabled: true<br/>  ipRangeFrom: 10.0.2.1<br/>  ipRangeTo: 10.0.2.2</pre>

Set _enabled_&nbsp;to true and set the IP range appropriately.

&nbsp;

## &nbsp;