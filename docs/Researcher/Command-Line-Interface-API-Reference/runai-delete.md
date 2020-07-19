# Description

Delete a training job and its associated pods

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Note that once you delete a job, its entire data will be gone:</span>

*   <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">You will no longer be able to enter it via bash&nbsp;&nbsp;</span>
*   <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">You will no longer be able access logs</span>
*   <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Any data saved on the container and not stored on a shared repository will be lost</span>

# Synopsis

<pre>runai delete &lt;job-name&gt;<br/>[--backward-compatibility | -b]<br/>[--loglevel &lt;value&gt;]<br/>[--project &lt;string&gt; | -p &lt;string&gt;]<br/>[--help | -h]</pre>

# Options

--backward-compatibility | -b

>  Backward compatibility mode to provide support for Jobs created with older versions of the CLI. See <a href="https://support.run.ai/hc/en-us/articles/360013546920-Migrating-to-Permission-Aware-CLI" target="_self">here</a> for further information

--loglevel (string)

>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)

>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use 'runai project set &lt;project name&gt;'.

--help | -h

>  Show help text

# Output

The job will be deleted and not available via the command _runai list_

The job will __not__ be deleted from the Run:AI user interface Job list

# See Also

*   Build Workloads:&nbsp;&nbsp;[https://support.run.ai/hc/en-us/articles/360010894959-Walkthrough-Start-and-Use-Interactive-Build-Workloads- ](https://support.run.ai/hc/en-us/articles/360010894959-Walkthrough-Start-and-Use-Interactive-Build-Workloads-)
*   Training Workloads: <https://support.run.ai/hc/en-us/articles/360010706360-Walkthrough-Launch-Unattended-Training-Workloads->&nbsp;

&nbsp;
&nbsp;