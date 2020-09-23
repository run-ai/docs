## Description

Delete a training job and its associated pods.

Note that once you delete a job, its entire data will be gone:

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

<job-name\> the name of the job to run the command in

--loglevel (string)
>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)
>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ``runai project set <project-name>``.

--help | -h
>  Show help text

## Output

The job will be deleted and not available via the command _runai list_

The job will __not__ be deleted from the Run:AI user interface Job list

## See Also

*   Build Workloads: [Walk-through Start and Use Interactive Build Workloads](../Walkthroughs/walkthrough-build.md).
*   Training Workloads: [Walk-through Start and Use Unattended Training Workloads](../Walkthroughs/walkthrough-train.md).

