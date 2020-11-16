## Introduction

Researchers who work with containers sometimes need to expose ports to access the container from remote. Some examples:

*   Using a _Jupyter_ _notebook_ that runs within the container
*   Using _PyCharm_ to run python commands remotely.
*   Using _TensorBoard_ to view machine learning visualizations

When using docker, the way researchers expose ports is by <a href="https://docs.docker.com/engine/reference/commandline/run/" target="_self">declaring</a> them when starting the container. Run:AI has similar syntax.

Run:AI is based on Kubernetes. Kubernetes offers an abstraction of the container's location. This complicates the exposure of ports. Kubernetes offers a number of alternative ways to expose ports. With Run:AI you can use all of these options (see the [Alternatives](#alternatives) section below), however, Run:AI comes built-in with ingress.


## Ingress

Ingress allows access to Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services. More information about ingress can be found <a href="https://kubernetes.io/docs/concepts/services-networking/ingress/" target="_self">here</a>.

## Setup

Before installing ingress, you must obtain an IP Address or an IP address range which is external to the cluster.

A Run:AI cluster is installed by:

* Accessing the Administrator User Interface Clusters area at [https://app.run.ai/clusters](https://app.run.ai/clusters){target=_blank} 
* Downloading a YAML file `runai-operator.yaml` and then 
* Applying it to Kubernetes. You must edit the YAML file. Search for _localLoadBalancer_

``` yaml
localLoadBalancer
    enabled: true
    ipRangeFrom: 10.0.2.1
    ipRangeTo: 10.0.2.2
```

Set _enabled_ to true and set the IP range appropriately.

## Usage

The researcher uses the Run:AI CLI to set the method type and the ports when submitting the Workload. Example:

    runai submit test-ingress -i jupyter/base-notebook -g 1 -p team-ny \
      --interactive --service-type=ingress --port 8888:8888 \ 
      --command -- start-notebook.sh --NotebookApp.base_url=test-ingress

After submitting a job through the Run:AI CLI, run:

    runai list jobs

You will see the service URL with which to access the Jupyter notebook

![mceclip0.png](img/mceclip0.png)

The URL will be composed of the ingress end-point, the job name and the port (e.g. <a href="https://10.255.174.13/test-ingress-8888" target="_self">https://10.255.174.13/test-ingress-8888</a>.

For further details see CLI command [runai submit](../../Researcher/cli-reference/runai-submit.md) and [Launch an Interactive Workload Quickstart ](../../Researcher/Walkthroughs/walkthrough-build-ports.md).

## Alternatives 

 Run:AI is based on Kubernetes. Kubernetes offers an abstraction of the container's location. This complicates the exposure of ports. Kubernetes offers a number of alternative  ways to expose ports: 

*    NodePort - Exposes the Service on each Node’s IP at a static port (the NodePort). You’ll be able to contact the NodePort Service, from outside the cluster, by requesting &lt;NodeIP&gt;:&lt;NodePort&gt; regardless of which node the container actually resides.  
*   LoadBalancer - Useful for cloud environments. Exposes the Service externally using a cloud provider’s load balancer.
*   Ingress - Allows access to Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services. More information about ingress can be found [here](https://kubernetes.io/docs/concepts/services-networking/ingress/){target=_blank}. 
*   Port Forwarding - Simple port forwarding allows access to the container via localhost:&lt;Port&gt;.

 See [https://kubernetes.io/docs/concepts/services-networking/service](https://kubernetes.io/docs/concepts/services-networking/service/){target=_blank} for further details.

 

## See Also

To learn how to use port forwarding see Quickstart document:  [Launch an Interactive Build Workload with Connected Ports](../../Researcher/Walkthroughs/walkthrough-build-ports.md).