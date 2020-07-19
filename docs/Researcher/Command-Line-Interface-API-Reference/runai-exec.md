# Description

Execute a command inside a running job<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;"></span>

Note: to execute a bash command, you can also use the shortcut _runai bash&nbsp;[https://support.run.ai/hc/en-us/articles/360011544859-runai-exec&nbsp;](https://support.run.ai/hc/en-us/articles/360011544099-runai-bash)_

# Synopsis

<pre>runai exec &lt;job-name&gt; &lt;command&gt;<br/>[--stdin | -i]<br/>[--tty | -t]<br/><br/>[--backward-compatibility | -b]<br/>[--loglevel &lt;value&gt;]<br/>[--project &lt;string&gt; | -p &lt;string&gt;]<br/>[--help | -h]</pre>

&nbsp;

# Options

&lt;job-name&gt; the name of the job to run the command in&nbsp;

&lt;command&gt; the command itself (e.g. _bash_)&nbsp;

--stdin | -i

>  Keep STDIN open even if not attached

--tty | -t

>  Allocate a pseudo-TTY

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

The command will run in the context of the container&nbsp;

# See Also

&nbsp;