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
| Ingress |  Allows access to Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services. | Requires an Ingress controller to be installed. See below | 

See [https://kubernetes.io/docs/concepts/services-networking/service](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types){target=_blank} for further details on these four options.


## Ingress

Ingress allows access to Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services. More information about ingress can be found [here](https://kubernetes.io/docs/concepts/services-networking/ingress/){target=_blank}.

### Setup

To submit jobs via ingress, You must install an _Ingress controller_ in your Kubernetes cluster. The prevalent Ingress controller is [ingress-nginx](https://kubernetes.github.io/ingress-nginx/deploy/){target=_blank}. 


### Usage

The Researcher uses the Run:ai CLI to set the method type and the ports when submitting the Workload. Example:

```
runai config project team-a
runai submit test-ingress -i jupyter/base-notebook -g 1  --interactive \ 
   --service-type=ingress --port 8888:8888 --command  \
   -- start-notebook.sh --NotebookApp.base_url=team-a-test-ingress
```

Then run:

```
runai list workloads
```

You will see the service URL with which to access the Jupyter notebook

![mceclip0.png](img/mceclip0.png)

The URL will be composed of the ingress end-point, the Project name and the Job name (e.g. <a href="https://10.255.174.13/team-a-test-ingress" target="_self">https://10.255.174.13/team-a-test-ingress</a>.

Alternatively run:

```
kubectl get ingress -n runai-team-a test-ingress -o yaml
```

And find the IP, port and full path from there. 

## See Also

* To learn how to use port forwarding see Quickstart document:  [Launch an Interactive Build Workload with Connected Ports](../../../Researcher/Walkthroughs/walkthrough-build-ports.md).
* See CLI command [runai submit](../../../Researcher/cli-reference/runai-submit.md).
