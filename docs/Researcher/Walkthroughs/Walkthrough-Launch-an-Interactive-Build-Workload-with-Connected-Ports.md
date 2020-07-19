## Introduction

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">This walkthrough is an extension of&nbsp;https://support.run.ai/hc/en-us/articles/360010894959-Walkthrough-Start-and-Use-Interactive-Build-Workloads-</span>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">When starting a container with the Run:AI Command Line Interface (CLI), it is possible to expose internal ports to the container user.&nbsp;</span>

## Exposing a Container Port

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">There are a number of alternative ways to expose ports in Kubernetes:</span>

*   <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">NodePort - Exposes the Service on each Node’s IP at a static port (the NodePort). You’ll be able to contact the NodePort service, from outside the cluster, by requesting &lt;NodeIP&gt;:&lt;NodePort&gt; regardless of which node the container actually resides.&nbsp;</span>
*   LoadBalancer - Useful for cloud environments.&nbsp;Exposes the Service externally using a cloud provider’s load balancer.
*   Ingress - Allows access to Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services.
*   Port Forwarding - Simple port forwarding allows access to the container via localhost:&lt;Port&gt;

Contact your administrator to see which methods are available in your cluster

## Port Forwarding, Step by Step Walkthrough

### Setup

*   Open the Run:AI user interface at <https://app.run.ai>
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

### Run Workload

*   At the command line run:

<pre>runai project set team-a<br/><br/>runai submit jupyter1 -i jupyter/base-notebook -g 1 \<br/> --interactive --service-type=portforward --port 8888:8888 \<br/> --args="--NotebookApp.base_url=jupyter1" --command=start-notebook.sh</pre>

*   The job is based on a generic Jupyter notebook docker image j<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;">upyter/base-notebook</span>
*   <span>We named the job _jupyter1.&nbsp; _Note that in this Jupyter implementation, the name of the job should also be copied to the Notbook base URL.&nbsp;</span>
*   Note the "interactive" flag which means the job will not have a start or end. It is the researcher's responsibility to close the job.&nbsp;
*   The job is assigned to team-a with an allocation of a single GPU.
*   In this example, we have chosen the simplest scheme to expose ports which is port forwarding. We temporarily expose port 8888 to localhost as long as the_ runai submit_ command is not stopped

### Open the Jupyter notebook

Open the following in the browser

<pre>http://localhost:8888/jupyter1</pre>

You should see a Jupyter notebook.

## Ingress, Step by Step Walkthrough

__Note:&nbsp;__Ingress must be set up by your administrator prior to usage. For more information see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011813620-Exposing-Ports-from-Researcher-Containers>

### Setup

*   Perform the setup steps for port forwarding above.&nbsp;

### Run Workload

*   At the command line run:

<pre>runai project set team-a<br/><br/>runai submit test-ingress -i jupyter/base-notebook -g 1 \<br/> --interactive --service-type=ingress --port 8888 \<br/> --args="--NotebookApp.base_url=test-ingress" --command=start-notebook.sh</pre>

*   An ingress service url&nbsp; will be created, run:

<pre>runai list</pre>

You will see the service URL with which to access the Jupyter notebook

<img alt="mceclip0.png" src="https://support.run.ai/hc/article_attachments/360007538020/mceclip0.png" style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;"/>