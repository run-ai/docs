# Description

Show list of jobs

<span style="font-size: 2.1em; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Synopsis</span>

<pre>runai list &lt;job-name&gt;<br/>[--all-projects | -A]<br/><br/>[--backward-compatibility | -b]<br/>[--loglevel &lt;value&gt;]<br/>[--project &lt;string&gt; | -p &lt;string&gt;]<br/>[--help | -h]</pre>

# Options

--all-projects | -A

>  Show jobs from all projects

## Global Flags

--backward-compatibility | -b

>  Backward compatibility mode to provide support for Jobs created with older versions of the CLI. See <a href="https://support.run.ai/hc/en-us/articles/360013546920-Migrating-to-Permission-Aware-CLI" target="_self">here</a> for further information

--loglevel (string)

>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)

>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use 'runai project set &lt;project name&gt;'.

--help | -h

>  Show help text

# Output

A list of jobs will show. To show details for a specific job see <a href="https://support.run.ai/hc/en-us/articles/360011545919-runai-get" target="_self">runai get</a>&nbsp;

# See Also

&nbsp;