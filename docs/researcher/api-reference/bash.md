# Description

Get a bash session inside a running job

This command is a shortcut to runai exec (_runai exec -it <job-name> bash_). See [https://support.run.ai/hc/en-us/articles/360011544099-runai-bash](https://support.run.ai/hc/en-us/articles/360011544099-runai-bash) <span class="wysiwyg-color-red"> </span><span class="wysiwyg-color-black">for full documentation of the exec command. </span>

# Synopsis

<pre>runai bash <job-name>  
[--backward-compatibility | -b]  
[--loglevel <value>]  
[--project <string> | -p <string>]  
[--help | -h]</pre>

# Options

## Global Flags

--backward-compatibility | -b

> Backward compatibility mode to provide support for Jobs created with older versions of the CLI. See [here](https://support.run.ai/hc/en-us/articles/360013546920-Migrating-to-Permission-Aware-CLI) for further information

--loglevel (string)

> Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)

> Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use 'runai project set <project name>'.

--help | -h

> Show help text

# Output

The command will access the container that should be currently running in the current cluster and attempt to create a command line shell based on bash.

The command will return an error if the container does not exist or has not been in running state yet.

# See also

Build Workloads: [https://support.run.ai/hc/en-us/articles/360010894959-Walkthrough-Start-and-Use-Interactive-Build-Workloads-](https://support.run.ai/hc/en-us/articles/360010894959-Walkthrough-Start-and-Use-Interactive-Build-Workloads-)