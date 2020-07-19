## Introduction

Jobs can be started via Kubeflow, Run:AI CLI, Rancher or via direct Kubernetes API. When jobs are finished (successfully or failing), their resource allocation is taken away, but they remain in the system. You can see old jobs by running the command:

<pre>runai list</pre>

![mceclip0.png](https://support.run.ai/hc/article_attachments/360008430740/mceclip0.png)

You can delete the job manually by running:

<pre>runai delete run3</pre>

But this may not be scalable for a production system.

It is possible to flag a job for automatic deletion some period of time after its finish.

__Important note__: Deleting a job, deletes the container behind it, and with it all related information such as job logs. Data that was saved by the researcher on a shared drive is not affected. The Job is also __not__ deleted from the Run:AI user interface

## Enable Automatic Deletion in Cluster (Admin only)

In order for automatic deletion to work, the On-premise Kubernetes cluster needs to be modified. The feature relies on a Kubernetes feature gate "<span><a href="https://kubernetes.io/docs/concepts/workloads/controllers/ttlafterfinished/" target="_self">TTLAfterFinished</a>"</span>

__Note__: different Kubernetes distributions have different locations and methods to add feature flags. The instructions below are an example based on _Kubespray_&nbsp;<https://github.com/kubernetes-sigs/kubespray>). Refer to the documentation of your Kubernetes distribution.&nbsp;

*   Open a shell on the Kubernetes __master__
*   cd to&nbsp;/etc/kubernetes/manifests
*   vi kube-apiserver.yaml
*   add&nbsp;&nbsp;<span>--feature-gates=TTLAfterFinished=true to the following location:</span>

<pre>spec:<br/> containers:<br/> - command:<br/>   - kube-apiserver<br/>     .....<br/><strong>   - --feature-gates=TTLAfterFinished=true</strong></pre>

&nbsp;

*   vi kube-controller-manager.yaml
*   add&nbsp;&nbsp;<span>--feature-gates=TTLAfterFinished=true to the following location:</span>

<pre>spec:<br/> containers:<br/> - command:<br/>   - kube-controller-manager<br/>     .....<br/><strong>   - --feature-gates=TTLAfterFinished=true</strong></pre>

&nbsp;

## Automatic Deletion

When starting the job, add the flag --ttl-after-finish &lt;duration&gt;. &lt;duration&gt; is the&nbsp;duration, post job finish, after which the job is automatically deleted. Example durations are:5s, 2m, 3h, 4d etc. For example, the following call will delete the job 2 hours after job finish:

<pre>runai submit myjob1 --ttl-after-finish 2h</pre>

## Using Templates to set Automatic Deletion as Default

You can use Run:AI templates to set auto-delete to be the default. See&nbsp;<https://support.run.ai/hc/en-us/articles/360011548039-runai-template>&nbsp;for more.&nbsp;<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">&nbsp;</span>