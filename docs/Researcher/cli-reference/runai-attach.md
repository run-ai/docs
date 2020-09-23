## Description

Attach to a running Job.

The command attaches to the standard input, output, and error streams of a running Job. If the job has multiple pods the job will attach to the first pod unless otherwise set.


## Synopsis

    runai attach <job-name>
        [--no-stdin ]
        [--no-tty]   
        [--pod string]
        .
        [--loglevel value] 
        [--help | -h]


## Options

<job-name\> the name of the job to run the command in

--no-stdin    
> Do not attach STDIN.

--no-tty       
> Do not allocate a pseudo-TTY

--pod string   
> Attach to a specific pod within the job. To find the list of pods run ``runai get <job-name>`` and then use the pod name with the ``--pod`` flag.

### Global Flags

--loglevel (string)
> Set the logging level. One of: debug|info|warn|error (default "info").

--help | -h
>  Show help text.

## Output

None