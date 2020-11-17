## Description

Delete a Job and its associated Pods.

Note that once you delete a Job, its entire data will be gone:

* You will no longer be able to enter it via bash.
* You will no longer be able access logs.
* Any data saved on the container and not stored on a shared location will be lost.

## Synopsis

``` shell
runai delete <job-name> 
    [--loglevel value] 
    [--project string | -p string] 
    [--help | -h]
```

## Options

<job-name\> the name of the Job to run the command with, Mandatory.

--loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

--project | -p (string)
>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ``runai project set <project-name>``.

--help | -h
>  Show help text.

## Output

* The Job will be deleted and not available via the command _runai list jobs_.

* The Job will __not__ be deleted from the Run:AI user interface Job list.

## See Also

*   Build Workloads. See Quickstart document: [Launch Interactive Build Workloads](../Walkthroughs/walkthrough-build.md).

*   Training Workloads. See Quickstart document:  [Launch Unattended Training Workloads](../Walkthroughs/walkthrough-train.md).

