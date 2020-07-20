## Description

Execute a command inside a running job

Note: to execute a bash command, you can also use the shorthand [runai bash](runai-bash)

## Synopsis

    runai exec job-name command 
        [--stdin | -i] 
        [--tty | -t]

        [--backward-compatibility | -b] 
        [--loglevel value] 
        [--project string | -p string] 
        [--help | -h]



## Options

<job-name\> the name of the job to run the command in

<command\> the command itself (e.g. _bash_)

--stdin | -i

>  Keep STDIN open even if not attached

--tty | -t

>  Allocate a pseudo-TTY

### Global Flags

--backward-compatibility | -b

>   Backward compatibility mode to provide support for Jobs created with older versions of the CLI. See [Migrating to Permission Aware CLI](../Command-Line-Interface/Migrating-to-Permission-Aware-CLI.md) for further information

--loglevel (string)

>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)

>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ``runai project set <project-name>``.

--help | -h

>  Show help text

## Output

The command will run in the context of the container

## See Also

