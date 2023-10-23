# Workloads Overview

## Workloads

Run:ai schedules *Workloads*. Run:ai workloads are comprised of:

* The *Kubernetes object* (Job, Deployment, etc) which is used to launch the container, inside which the data science code runs.
* A set of additional resources that are required to run the Workload. Examples: a service entry point that allows access to the Job, a persistent volume claim to access data on the network, and more.

All of these components are created together and deleted together when the Workload ends.

Run:ai currently supports the following Workloads types:

|  Workload Type | Kubernetes Name | Description |
|----------------|-----------------|-------------|
| Interactive    | `InteractiveWorkload` | Submit an interactive workload |
| Training       | `TrainingWorkload`| Submit a training workload |
| Distributed Training | `DistributedWorkload` | Submit a distributed training workload using TensorFlow, PyTorch or MPI |
| Inference      | `InferenceWorkload` | Submit an inference workload |

## Workloads View

The *Workloads* view provides a more advanced UI than the previous *Jobs* UI. The new table format provides:

* Improved views of the data
* Improved filters and search
* More information

To enable the *Workloads* view, go to the *Jobs* table and toggle the switch from `Jobs` to `Workloads`. To return, switch the toggle from `Workloads` to `Jobs`.

!!! Note
    To submit a workload, use either the *Jobs* view or the CLI.

    <!-- remove this when the feature is added -->

Use the search feature to find a specific workload in the list.

Use the columns button to change the columns that are displayed in the table.

Use the More button to download the table and the displayed columns to a CSV file.

Manage *Workloads* by selecting a workload from the table. Once selected, you can:

* Delete
* Connect
* Stop
* Activate (not enabled)
* Show details

The *Show details* button provides in-depth information about the selected workload including:

* Event history&mdash;workload status over time. Use the filter to search through the history for specific events.
* Metrics&mdash;metric for GPU utilization, CPU usage, GPU memory usage, and CPU memory usage. Use the date selector to choose the time period for the metrics.
* Logs&mdash;logs of the current status. Use the *Download* button to download the logs.

## Values

A Workload will typically have a list of *values* (sometimes called *flags*), such as name, image, and resources. A full list of values is available in the [runai-submit](../../Researcher/cli-reference/runai-submit.md) Command-line reference.

## How to Submit

A Workload can be submitted via various channels:

* The Run:ai [user interface](../../admin/admin-ui-setup/jobs.md).
* The Run:ai command-line interface, via the [runai submit](../../Researcher/cli-reference/runai-submit.md) command.
* The Run:ai [Cluster API](../../developer/cluster-api/workload-overview-dev.md).

## Workload Policies

As an administrator, you can set *Policies* on Workloads.  Policies allow administrators to *impose restrictions* and set *default values* for Researcher Workloads. For more information see [Workload Policies](policies.md).

