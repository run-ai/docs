# Description

Display details of a training job

# Synopsis

<pre>runai get &lt;job-name&gt;<br/>[--output &lt;value&gt; | -o &lt;value&gt;]<br/><br/>[--backward-compatibility | -b]<br/>[--loglevel &lt;value&gt;]<br/>[--project &lt;string&gt; | -p &lt;string&gt;]<br/>[--help | -h]</pre>

&nbsp;

# Options

&lt;job-name&gt; the name of the job to run the command in&nbsp;

-o | --output

>  Output format. One of: json|yaml|wide

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

The command will show the job properties and status as well as lifecycle events and list of pods

# See Also