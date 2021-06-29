## Description

Suspend a job

This will kill all of the pods associated with the job and stop creating new ones.

* You will no longer be able to enter it via bash.
* You will no longer be able to access logs.
* Any data saved on the container and not stored in a shared location will be lost.

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

* All of the jobs pods will be deleted.

## See Also

*   Build Workloads. See Quickstart document: [Launch Interactive Build Workloads](../Walkthroughs/walkthrough-build.md).

*   Training Workloads. See Quickstart document:  [Launch Unattended Training Workloads](../Walkthroughs/walkthrough-train.md).

*   Resuming Jobs: [Resume](./runai-resume.md).
