## Description

Resume a suspended jobs

This will create the pods for the job which will enter the scheduling queues

## Synopsis

``` shell
runai resume <job-name>
    [--all | -A]

    [--loglevel value]
    [--project string | -p string]
    [--help | -h]
```

## Options

<job-name\> - The name of the Job to run the command with. Mandatory.

--all | -A
>  Delete all Jobs.

### Global Flags

--loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

--project | -p (string)
>  Specify the Project to which the command applies. By default, commands apply to the default Project. To change the default Project use ``runai config project <project-name>``.

--help | -h
>  Show help text.

## Output

* The job will be suspended and its status changed in the command _runai list jobs_.

* New pods will be created for the job.

## See Also

*   Suspending Jobs: [Suspend](./runai-suspend.md).
