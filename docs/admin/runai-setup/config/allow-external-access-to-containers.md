## Introduction

Researchers working with containers. many times need to remotely access the container. Some examples:

*   Using a _Jupyter_ _notebook_ that runs within the container
*   Using _PyCharm_ to run python commands remotely.
*   Using _TensorBoard_ to view machine learning visualizations

This requires _exposing container ports_. When using docker, the way Researchers expose ports is by <a href="https://docs.docker.com/engine/reference/commandline/run/" target="_self">declaring</a> them when starting the container. Run:ai has similar syntax.

Run:ai is based on Kubernetes. Kubernetes offers an abstraction of the container's location. This complicates the exposure of ports. Kubernetes offers several options:

| Method | Description | Prerequisites |
|--------|-------------|---------------|
| Port Forwarding | Simple port forwarding allows access to the container via local and/or remote port. | None |
| NodePort | Exposes the service on each Node’s IP at a static port (the NodePort). You’ll be able to contact the NodePort service from outside the cluster by requesting `<NODE-IP>:<NODE-PORT>` regardless of which node the container actually resides in. | None |  
| LoadBalancer | Exposes the service externally using a cloud provider’s load balancer. | Only available with cloud providers | 


See [https://kubernetes.io/docs/concepts/services-networking/service](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types){target=_blank} for further details on these four options.



## See Also

* To learn how to use port forwarding see the Quickstart document:  [Launch an Interactive Build Workload with Connected Ports](../../../Researcher/Walkthroughs/walkthrough-build-ports.md).
* See CLI command [runai submit](../../../Researcher/cli-reference/runai-submit.md).
