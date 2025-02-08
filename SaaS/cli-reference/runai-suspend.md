## Description

Suspend a Job

Suspending a Running Job will stop the Job and will not allow it to be scheduled until it is resumed using `runai resume`. This means that,

* You will no longer be able to enter it via `runai bash`.
* The Job logs will be deleted.
* Any data saved on the container and __not__ stored in a shared location will be lost.

Technically, the command deletes the _Kubernetes pods_ associated with the Job and marks the Job as suspended until it is manually released. 

Suspend and resume do not work with _MPI_ and _Inference_ 


## Synopsis

``` shell
runai suspend <job-name>
    [--all | -A]

    [--loglevel value]
    [--project string | -p string]
    [--help | -h]
```

## Options

<job-name\> - The name of the Job to run the command with. Mandatory.

#### --all | -A
>  Suspend all Jobs in the current Project.

### Global Flags

#### --loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

#### --project | -p (string)
>  Specify the Project to which the command applies. By default, commands apply to the default Project. To change the default Project use ``runai config project <project-name>``.

#### --help | -h
>  Show help text.

## Output

* The Job will be suspended. When running _runai list jobs_ the Job will be marked as _Suspended_.

## See Also

*   Resuming Jobs: [Resume](./runai-resume.md).
