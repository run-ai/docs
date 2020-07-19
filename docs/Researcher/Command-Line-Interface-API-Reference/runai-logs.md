## Description

Show logs of training job

<span style="font-size: 2.1em; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Synopsis</span>

<pre>runai logs &lt;job-name&gt;<br/>[--follow | -f]<br/>[--pod &lt;string&gt; | -p &lt;string&gt;]<br/>[--since &lt;duration&gt;]<br/>[--since-time &lt;date-time&gt;]<br/>[--tail &lt;int&gt; | -t&nbsp;&lt;int&gt;]<br/>[--timestamps]<br/><br/>[--backward-compatibility | -b]<br/>[--loglevel &lt;value&gt;]<br/>[--project &lt;string&gt; | -p &lt;string&gt;]<br/>[--help | -h]</pre>

## Options

--follow | -f&nbsp;

>  Specify if the logs should be streamed.

--pod | -p

>  Specify a specific pod name. When a Job fails, it may start a couple of times in an attempt to succeed. The flag allows you to see the logs of a specific instance (called 'pod'). Get the name of the pod by running&nbsp;__runai get &lt;job-name&gt;__

--instance (string) | -i (string)

>  <span class="wysiwyg-color-black60">show logs for a specific instance in cases where a job contains multiple pods</span>

--since (duration)&nbsp;

>  Return logs newer than a relative duration like 5s, 2m, or 3h. Defaults to all logs. The flags since and since-time cannot be used together

--since-time (date-time)&nbsp;

>  Return logs after specified date. Date format should be&nbsp;RFC3339, example:&nbsp;<span>2020-01-26T15:00:00Z</span>

--tail (int) | -t (int)

>  \# of lines of recent log file to display.&nbsp;

--timestamps

>  Include timestamps on each line in the log output.

### Global Flags

--backward-compatibility | -b

>  Backward compatibility mode to provide support for Jobs created with older versions of the CLI. See <a href="https://support.run.ai/hc/en-us/articles/360013546920-Migrating-to-Permission-Aware-CLI" target="_self">here</a> for further information

--loglevel (string)

>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)

>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use 'runai project set &lt;project name&gt;'.

--help | -h

>  Show help text

## Output

The jobs log will show

## See Also

*   Training Workloads: <https://support.run.ai/hc/en-us/articles/360010706360-Walkthrough-Launch-Unattended-Training-Workloads->&nbsp;

&nbsp;