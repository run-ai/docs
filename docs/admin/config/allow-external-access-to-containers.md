## Introduction

Researchers working with containers may at times need to remotely access the container. Some examples:

*   Using a _Jupyter_ _notebook_ that runs within the container
*   Using _PyCharm_ to run python commands remotely.
*   Using _TensorBoard_ to view machine learning visualizations

This requires _exposing container ports_. When using docker, the way Researchers expose ports is by [declaring](https://docs.docker.com/engine/reference/commandline/run/){target=_blank} them when starting the container. Run:ai has similar syntax.

Run:ai is based on Kubernetes. Kubernetes offers an abstraction of the container's location. This complicates the exposure of ports. Kubernetes offers several options:

| Method | Description | Prerequisites |
|--------|-------------|---------------|
| Port Forwarding | Simple port forwarding allows access to the container via local and/or remote port. | None |
| NodePort | Exposes the service on each Node’s IP at a static port (the NodePort). You’ll be able to contact the NodePort service from outside the cluster by requesting `<NODE-IP>:<NODE-PORT>` regardless of which node the container actually resides in. | None |  
| LoadBalancer | Exposes the service externally using a cloud provider’s load balancer. | Only available with cloud providers | 


See [https://kubernetes.io/docs/concepts/services-networking/service](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types){target=_blank} for further details on these options.



## Workspaces configuration

[Workspaces](../../Researcher/workloads/workspaces/workspace-v2.md) allow the Researcher to build AI models interactively. 

Workspaces allow the Researcher to launch tools such as Visual Studio code, TensorFlow, TensorBoard etc. These tools require access to the container. Access is provided via URLs. 

Run:ai uses the [Cluster URL](../runai-setup/cluster-setup/cluster-prerequisites.md#domain-name-requirement) provided to dynamically create SSL-secured URLs for researchers’ workspaces in the format of `https://<CLUSTER_URL>/project-name/workspace-name`.

While this form of path-based routing conveniently works with applications like Jupyter Notebooks, it may often not be compatible with other applications. These applications assume running at the root file system, so hardcoded file paths and settings within the container may become invalid when running at a path other than the root. For instance, if the container is expecting to find a file at `/etc/config.json` but is running at `/project-name/workspace-name`, the file will not be found. This can cause the container to fail or not function as intended.

To address this issue, Run:ai provides support for __host-based routing__. When enabled, Run:ai creates workspace URLs in a subdomain format (`https://project-name-workspace-name.<CLUSTER_URL>/`), which allows all workspaces to run at the root path and function properly. 

To enable host-based routing you must perform the following steps:

!!! Note
    For OpenShift, editing the Runaiconfig command is the only step required to generate workspace URLs. Refer to the last step below.


1. Create a second DNS entry (A record) for `*.<CLUSTER_URL>`, pointing to the same IP as the cluster [Fully Qualified Domain Name (FQDN)](../runai-setup/cluster-setup/cluster-prerequisites.md#fully-qualified-domain-name-fqdn)
2. Obtain a __wildcard__ SSL certificate for this DNS.


3. Add the certificate as a secret:

```
kubectl create secret tls runai-cluster-domain-star-tls-secret -n runai \ 
    --cert /path/to/fullchain.pem --key /path/to/private.pem
```

4. Create the following ingress rule:

``` YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: runai-cluster-domain-star-ingress
  namespace: runai
spec:
  ingressClassName: nginx
  rules:
  - host: '*.<CLUSTER_URL>'
  tls:
  - hosts:
    - '*.<CLUSTER_URL>'
    secretName: runai-cluster-domain-star-tls-secret
```

Replace `<CLUSTER_URL>` as described above and run: `kubectl apply -f <filename>`.

5. Edit Runaiconfig to generate the URLs correctly:

```
kubectl patch RunaiConfig runai -n runai --type="merge" \
    -p '{"spec":{"global":{"subdomainSupport": true}}}' 
```


Once these requirements have been met, all workspaces will automatically be assigned a secured URL with a subdomain, ensuring full functionality for all researcher applications.

## See Also

* To learn how to use port forwarding see the Quickstart document:  [Launch an Interactive Build Workload with Connected Ports](../../Researcher/Walkthroughs/walkthrough-build-ports.md).
* See CLI command [runai submit](../../Researcher/cli-reference/runai-submit.md).
