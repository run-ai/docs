## Description

Delete a Workload and its associated Pods.

Note that once you delete a Workload, its entire data will be gone:

* You will no longer be able to enter it via bash.
* You will no longer be able to access logs.
* Any data saved on the container and not stored in a shared location will be lost.

## Synopsis

``` shell
runai delete job <job-name> 
    [--all | -A]

    [--loglevel value] 
    [--project string | -p string] 
    [--help | -h]
```
## Options

<job-name\> - The name of the Workload to run the command with. Mandatory.

#### --all | -A
>  Delete all Workloads.

### Global Flags

#### --loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

#### --project | -p (string)
>  Specify the Project to which the command applies. By default, commands apply to the default Project. To change the default Project use ``runai config project <project-name>``.

#### --help | -h
>  Show help text.

## Output

* The Workload will be deleted and not available via the command _runai list jobs_.

* The Workloads will show as `deleted` from the Run:ai user interface Job list.

## See Also

*   Build Workloads. See Quickstart document: [Launch Interactive Build Workloads](../Walkthroughs/walkthrough-build.md).

*   Training Workloads. See Quickstart document:  [Launch Unattended Training Workloads](../Walkthroughs/walkthrough-train.md).

