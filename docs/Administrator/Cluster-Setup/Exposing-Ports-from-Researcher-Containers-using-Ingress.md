## Introduction

Researchers who work with containers sometimes need to expose ports to access the container from remote. Some examples:

*   Using a _Jupyter notebook_ that runs within the container
*   Using _PyCharm_ to run python commands remotely.
*   Using _TensorBoard_ to view machine learning visualizations

When using docker, the way researchers expose ports is by <a href="https://docs.docker.com/engine/reference/commandline/run/" target="_self">declaring</a> them when starting the container. Run:AI has similar syntax

Run:AI is based on Kubernetes. Kubernetes offers an abstraction of the container's location. This complicates the exposure of ports. Kubernetes offers a number of alternative <span>ways to expose ports. With Run:AI you can use all of these options (see the&nbsp;_Alternatives_&nbsp;section below), however, Run:AI comes built-in with&nbsp;_ingress_</span>

## <span>Ingress</span>

Ingress allows access to Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services. More information about ingress can be found <a href="https://kubernetes.io/docs/concepts/services-networking/ingress/" target="_self">here</a>

To configure ingress see:&nbsp;<https://support.run.ai/hc/en-us/articles/360013847900-Exposing-Cluster-Services-via-Ingress>&nbsp;

## Usage

The researcher uses the Run:AI CLI to set the method type and the ports when submitting the Workload. Example:

<pre>runai submit <strong>test-ingress</strong> -i jupyter/base-notebook -g 1 -p team-ny \<br/> --interactive <strong>--service-type=ingress</strong> <strong>--port 8888:8888</strong> \<br/> --args="--NotebookApp.base_url=test-ingress" --command=start-notebook.sh</pre>

After submitting a job through the Run:AI CLI, run:

<pre>runai list</pre>

You will see the service URL with which to access the Jupyter notebook

![mceclip0.png](https://support.run.ai/hc/article_attachments/360012894900/mceclip0.png)

The URL will be composed of the ingress end-point, the job name and the port (e.g. <a href="https://10.255.174.13/test-ingress-8888" target="_self">https://10.255.174.13/test-ingress-8888</a>

For further details see CLI <a href="https://support.run.ai/hc/en-us/articles/360011436120-runai-submit" target="_self">reference</a> and <a href="https://support.run.ai/hc/en-us/articles/360011131919-Walkthrough-Launch-an-Interactive-Build-Workload-with-Connected-Ports" target="_self">walkthrough</a>.

## Alternatives

&nbsp;Run:AI is based on Kubernetes. Kubernetes offers an abstraction of the container's location. This complicates the exposure of ports. Kubernetes offers a number of alternative <span>ways to expose ports:</span>

*   <span>NodePort - Exposes the Service on each Node’s IP at a static port (the NodePort). You’ll be able to contact the NodePort Service, from outside the cluster, by requesting &lt;NodeIP&gt;:&lt;NodePort&gt; regardless of which node the container actually resides.&nbsp;</span>
*   LoadBalancer - Useful for cloud environments.&nbsp;Exposes the Service externally using a cloud provider’s load balancer.
*   Ingress - Allows access to Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services. More information about ingress can be found <a href="https://kubernetes.io/docs/concepts/services-networking/ingress/" target="_self">here</a>.&nbsp;
*   Port Forwarding - Simple port forwarding allows access to the container via localhost:&lt;Port&gt;

<span>See <https://kubernetes.io/docs/concepts/services-networking/service/>&nbsp; for further details</span>

&nbsp;

## See Also

To learn how to use port forwarding see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011131919-Walkthrough-Launch-an-Interactive-Build-Workload-with-Connected-Ports>