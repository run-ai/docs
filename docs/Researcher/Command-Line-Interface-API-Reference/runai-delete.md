## Description

Delete a training job and its associated pods.

Note that once you delete a job, its entire data will be gone:

* You will no longer be able to enter it via bash.
* You will no longer be able access logs.
* Any data saved on the container and not stored on a shared repository will be lost.

## Synopsis

    runai delete job-name 
        [--backward-compatibility | -b] 
        [--loglevel value] 
        [--project string | -p string] 
        [--help | -h]

## Options

--backward-compatibility | -b

>   Backward compatibility mode to provide support for Jobs created with older versions of the CLI. See [Migrating to Permission Aware CLI](../Command-Line-Interface/Migrating-to-Permission-Aware-CLI.md) for further information

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

*   Build Workloads: [Walkthrough Start and Use Interactive Build Workloads](../Walkthroughs/Walkthrough-Start-and-Use-Interactive-Build-Workloads-.md).
*   Training Workloads: [Walkthrough Start and Use Unattended Training Workloads](../Walkthroughs/Walkthrough-Launch-Unattended-Training-Workloads-.md).

