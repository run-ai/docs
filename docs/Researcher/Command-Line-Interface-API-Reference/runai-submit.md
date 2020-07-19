## Description

Submit a Run:AI job for execution<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;"></span>

## Synopsis

<pre>runai submit &lt;job-name&gt; <br/>[--always-pull-image]<br/>[--args &lt;stringArray&gt;]<br/>[--backoffLimit &lt;int&gt;]<br/>[--command &lt;stringArray&gt;]<br/>[--cpu &lt;double&gt;]<br/>[--cpu-limit &lt;double&gt;]<br/>[--elastic]<br/>[--environment &lt;stringArray&gt; | -e &lt;stringArray&gt;]<br/>[--gpu &lt;int&gt; | -g &lt;int&gt;]<br/>[--host-ipc]<br/>[--host-network]<br/>[--image &lt;string&gt; | -i &lt;string&gt;]<br/>[--interactive]<br/>[--jupyter]<br/>[--large-shm]<br/>[--local-image]<br/>[--memory &lt;string&gt;]<br/>[--memory-limit &lt;string&gt;]<br/>[--node-type &lt;string&gt;]<br/>[--port &lt;stringArray&gt;]<br/>[--preemptible]<br/>[--<span>run-as-user]</span><br/>[--service-type &lt;string&gt; | -s &lt;string&gt;]<br/>[--template &lt;string&gt;]<br/>[--ttl-after-finish &lt;duration&gt;]<br/>[--volume &lt;stringArray&gt; | -v stringArray]<br/>[<span>--working-dir]</span><br/><br/>[--loglevel &lt;string&gt;]<br/>[--project &lt;string&gt; | -p &lt;string&gt;]<br/>[--help | -h]</pre>

&nbsp; Syntax notes:

*   Options with value type of stringArray mean that you can add multiple values. You can either separate values with a comma or add the flag twice.&nbsp;

## Options

&lt;job-name&gt; the name of the job to run the command in&nbsp;

&lt;command&gt; the command itself (e.g. _bash_)&nbsp;

--always-pull-image &lt;stringArray&gt;

>  When starting a container, always pull the image from repository, even if cached on running node. This is useful when you are re-saving updates to the image using the same tag.

--args &lt;stringArray&gt;

>  Arguments to pass to the command run on container start. Use together with --command.   
> Example: --command sleep --args 10000 <span class="wysiwyg-color-red"></span><span class="wysiwyg-color-blue"></span>

--<span>backoffLimit &lt;int&gt;</span>

>  
> The number of times the job will be retried before failing. Default is 6. This flag will only work with training workloads (when the --interactive flag is not specified)
> 

--command &lt;stringArray&gt;

>  <span class="wysiwyg-color-black60">Command to run at container start. Use together with --args</span><span class="wysiwyg-color-black40">.</span><span class="wysiwyg-color-red">&nbsp;</span>

--cpu &lt;double&gt;

>  
> <span>CPU units to allocate for the job (0.5, 1, .etc). The Job will receive at least this amount of CPU. Note that the Job will __not__ be scheduled unless the system can guarantee this amount of CPUs to the job.&nbsp;</span><span></span>
> 

--cpu-limit &lt;double&gt;

<blockquote>Limitations<font face="-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif">&nbsp;of the number of CPU consumed by the job (0.5, 1, .etc). The system </font>guarantees<font face="-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif">&nbsp;that this Job will not be able to consume more than this amount of GPUs.&nbsp;</font></blockquote>

--<span>elastic</span>

>  
> Mark the job as elastic. For further information on Elasticity see&nbsp;<https://support.run.ai/hc/en-us/articles/360011347560-Elasticity-Dynamically-Stretch-Compress-Jobs-According-to-GPU-Availability>&nbsp;
> 

-e &lt;stringArray&gt; | --environment &lt;stringArray&gt;

>  Define environment variables to be set in the container. To set multiple values add the flag multiple times (-e BATCH\_SIZE=50 -e LEARNING\_RATE=0.2) or separate by a comma (-e BATCH\_SIZE:50,LEARNING\_RATE:0.2)

--gpu &lt;int&gt; | -g &lt;int&gt;

>  Number of GPUs to allocation to the Job. Default is no GPUs.

--host-ipc

>  Use the host's ipc namespace. Controls whether the pod containers can share the host IPC namespace.<span class="wysiwyg-color-red"></span>&nbsp;<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">IPC (POSIX/SysV IPC) namespace provides separation of named shared memory segments, semaphores and message queues.</span>
> Shared memory segments are used to accelerate inter-process communication at memory speed, rather than through pipes or through the network stack
> 
> For further information see docker <a href="https://docs.docker.com/engine/reference/run/" target="_self">documentation</a>&nbsp;
> 

--host-network

>  Use the host's network&nbsp;<span>stack inside the container</span>
>  <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">For further information see docker </span><a href="https://docs.docker.com/engine/reference/run/" style="background-color: #ffffff; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;" target="_self">documentation</a><span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">&nbsp;</span>

--image &lt;string&gt; | -i &lt;string&gt;

>  Image to use when creating the container for this Job

--interactive

>  Mark this Job as Interactive. Interactive jobs are not terminated automatically by the system

--jupyter

>  (Deprecated) Shortcut for running a jupyter notebook container. Uses a pre-created image and a default notebook configuration. Use the templates flag instead.

--large-shm

>  
> Mount a large /dev/shm device. shm is a shared file system mounted on RAM
> 

--local-image

>  Use a local image for this job. A local image is an image which exists on all local servers of the Kubernetes Cluster.

--memory &lt;string&gt;

>  <span class="wysiwyg-color-black70">CPU</span> memory to allocate for this job (1G, 20M, .etc).&nbsp;<span>The Job will receive at least this amount of memory. Note that the Job will __not__ be scheduled unless the system can guarantee this amount of memory to the job.&nbsp;</span>

--memory-limit &lt;string&gt;

>  <span class="wysiwyg-color-black70">CPU</span> memory to allocate for this job (1G, 20M, .etc).&nbsp;The system guarantees&nbsp;that this Job will not be able to consume more than this amount of memory. The Job will receive an error when trying to allocate more memory than this limit.

--name &lt;string&gt;

>  <span class="wysiwyg-color-black60">(Deprecated)</span>&nbsp;Job Name. Add the name without the --name flag.

--node-type &lt;string&gt;

>  Allows defining specific nodes (machines) or group of nodes on which the workload will run. To use this feature your administrator will need to label nodes as explained here:&nbsp;<https://support.run.ai/hc/en-us/articles/360011591500-Limit-a-Workload-to-a-Specific-Node-Group>&nbsp;  
> This flag can be used in conjunction&nbsp;with Project-based affinity. In this case, the flag is used to refine the list of allowable node groups set in the project. For more information see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011591300-Working-with-Projects&nbsp;>

--port &lt;stringArray&gt;

>  Expose ports from the Job container. <span class="wysiwyg-color-black60">Used together with --service-type.</span>&nbsp;  
> Examples:&nbsp;<span class="wysiwyg-color-black60">&nbsp;  
> --port 8080:80 --service-type loadbalancer</span>
>  <span class="wysiwyg-color-black60">--port 8080 --service-type ingress</span>

--preemptible

>  Mark an interactive job as preemptible. Preemptible jobs can be scheduled above guaranteed quota but may be reclaimed at any time.&nbsp;

--run-as-user

>  Run in the context of the current user running the Run:AI command rather than the root user. While the default container user is root (same as in Docker), this command allows you to submit a job running under your linux user. This would manifest itself in access to operating system resources, in the owner of new folders created under shared directories etc.

--service-type &lt;string&gt; | -s &lt;string&gt;

>  Service exposure method for interactive Job. Options are: portforward, loadbalancer, nodeport, ingress.
>  Use the command runai list to obtain the endpoint to use the service when the job is running. Different service methods have different endpoint structure

--template &lt;string&gt;

>  Use a specific template when running this job. Templates are set by the cluster administrator and provide predefined values to flags under the submit command. If a template is not set, a default template will be use if such exists

--ttl-after-finish &lt;duration&gt;

>  Define the duration, post job finish, after which the job is automatically deleted (5s, 2m, 3h, .etc).  
> Note: This setting must first be enabled at the cluster level. See&nbsp;<https://support.run.ai/hc/en-us/articles/360011623839-Automatically-Delete-Jobs-After-Job-Finish>

--volume &lt;stringArray&gt; | -v &lt;stringArray&gt;

>  Volume to mount into the container. Example&nbsp;-v /raid/public/john/data:/root/data:ro The flag may optionally be suffixed with :ro or :rw to mount the volumes in read-only or read-write mode, respectively.

--working-dir &lt;string&gt;&nbsp;

>  Starts the container with the specified directory&nbsp;

### Global Flags

--loglevel (string)

>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)

>  Specify the project to which the command applies. Run:AI Projects are used by the scheduler to calculate resource eligibility.&nbsp; By default, commands apply to the default project. To change the default project use 'runai project set &lt;project name&gt;'.

--help | -h

>  Show help text

## Examples

start an unattended training job of name run1, based on project team-ny using a quickstart image:

<pre>runai submit run1 -i gcr.io/run-ai-lab/quickstart -g 1 -p team-ny</pre>

&nbsp;

start an interactive job of name run2, based on project team-ny using a jupyter notebook image. The Notebook will be externalized via a load balancer on port 8888:

<pre>runai submit run2 -i jupyter/base-notebook -g 1 \ <br/>     -p team-ny --interactive --service-type=loadbalancer <br/>    --port 8888:8888</pre>

## Output

The command will <span class="wysiwyg-color-black">attempt to submit a job. You can follow up on the job by running _runai list_ or _runai get &lt;job-name&gt; -e_</span>

<span class="wysiwyg-color-black">Note that the submit call may use templates to provide defaults to any of the above flags.&nbsp;</span>

## See Also

*   See any of the Walkthrough documents here:&nbsp;<https://support.run.ai/hc/en-us/articles/360010773460-Run-AI-Walkthroughs>&nbsp;&nbsp;
*   See _runai template&nbsp;_<https://support.run.ai/hc/en-us/articles/360011548039-runai-template>&nbsp;for a description on how templates work

&nbsp;