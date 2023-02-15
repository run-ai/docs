## Description

Execute a command inside a running Job

Note: to execute a bash command, you can also use the shorthand [runai bash](runai-bash.md)

## Synopsis

``` shell
runai exec <job-name> <command> 
    [--stdin | -i] 
    [--tty | -t]

    [--loglevel value] 
    [--project string | -p string] 
    [--help | -h]
```


## Options

<job-name\> - The name of the Job to run the command with. Mandatory.

<command\> the command itself (e.g. _bash_).

#### --stdin | -i
>  Keep STDIN open even if not attached.

#### --tty | -t
>  Allocate a pseudo-TTY.

### Global Flags

#### --loglevel (string)

>  Set the logging level. One of: debug | info | warn | error (default "info").

#### --project | -p (string)

>  Specify the Project to which the command applies. By default, commands apply to the default Project. To change the default Project use `runai config project <project-name>`.

#### --help | -h

>  Show help text.

## Output

The command will run in the context of the container.

## See Also

