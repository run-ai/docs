## Description

Get a bash session inside a running job

This command is a shortcut to runai exec (``runai exec -it job-name bash``). See [runai exec](runai-exec) for full documentation of the exec command.

## Synopsis

    runai bash job-name 
        [--backward-compatibility | -b] 
        [--loglevel value] 
        [--project string | -p string] 
        [--help | -h]

## Options

### Global Flags

--backward-compatibility | -b

>  Backward compatibility mode to provide support for Jobs created with older versions of the CLI. See [Migrating to Permission Aware CLI](../Command-Line-Interface/Migrating-to-Permission-Aware-CLI.md) for further information

--loglevel (string)

>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)

>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ``runai project set <project-name>``.

--help | -h

>  Show help text

## Output

The command will access the container that should be currently running in the current cluster and attempt to create a command line shell based on bash.

The command will return an error if the container does not exist or has not been in running state yet.

## See also

Build Workloads: [Walkthrough Start and Use Interactive Build Workloads](../Walkthroughs/Walkthrough-Start-and-Use-Interactive-Build-Workloads-.md).

