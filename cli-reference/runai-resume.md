## Description

Resume a suspended Job

Resuming a previously suspended Job will return it to the queue for scheduling. The Job may or may not start immediately, depending on available resources. 


Suspend and resume do not work with _mpi_ Jobs. 


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

#### --all | -A
>  Resume all suspended Jobs in the current Project.

### Global Flags

#### --loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

#### --project | -p (string)
>  Specify the Project to which the command applies. By default, commands apply to the default Project. To change the default Project use ``runai config project <project-name>``.

#### --help | -h
>  Show help text.

## Output

* The Job will be resumed. When running _runai list jobs_ the Job status will no longer by _Suspended_.

## See Also

*   Suspending Jobs: [Suspend](./runai-suspend.md).