## Description

Show the logs of a job

## Synopsis

``` shell
runai logs <job-name> 
    [--follow | -f] 
    [--pod string | -p string] 
    [--since duration] 
    [--since-time date-time] 
    [--tail int | -t int] 
    [--timestamps]  
    
    [--loglevel value] 
    [--project string | -p string] 
    [--help | -h]
```

## Options

--follow | -f
>  Stream the logs.

--pod | -p
>  Specify a specific pod name. When a Job fails, it may start a couple of times in an attempt to succeed. The flag allows you to see the logs of a specific instance (called 'pod'). Get the name of the pod by running ``runai get job-name``.

--instance (string) | -i (string)
>  Show logs for a specific instance in cases where a job contains multiple pods.

--since (duration)
>  Return logs newer than a relative duration like 5s, 2m, or 3h. Defaults to all logs. The flags since and since-time cannot be used together.

--since-time (date-time)
>  Return logs after specified date. Date format should beRFC3339, example: ``2020-01-26T15:00:00Z``.

--tail (int) | -t (int)
>  \# of lines of recent log file to display.

--timestamps
>  Include timestamps on each line in the log output.

### Global Flags

--loglevel (string)
>  Set the logging level. One of: debug|info|warn|error (default "info").

--project | -p (string)
>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ``runai project set <project-name>``.

--help | -h
>  Show help text.

## Output

The command will show the logs of the first process in the container. For training jobs, this would be the command run at startup. For interactive jobs, the command may not show anything.

## See Also

*   Training Workloads: [Walk-through Start and Use Unattended Training Workloads](../Walkthroughs/walkthrough-train.md).

