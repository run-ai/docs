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

Use the search feature to find a specific workload in the list.

Use the columns button to change the columns that are displayed in the table.

Use the More button to download the table and the displayed columns to a CSV file.

Manage *Workloads* by selecting a workload from the table. Once selected, you can:

* Delete a workload
* Connect
* Stop a workload
* Activate a workload
* Show details

The *Show details* button provides in-depth information about the selected workload including:

* Event history&mdash;workload status over time. Use the filter to search through the history for specific events.
* Metrics&mdash;metric for GPU utilization, CPU usage, GPU memory usage, and CPU memory usage. Use the date selector to choose the time period for the metrics.
* Logs&mdash;logs of the current status. Use the *Download* button to download the logs.

## Values

A Workload will typically have a list of *values* (sometimes called *flags*), such as name, image, and resources. A full list of values is available in the [runai-submit](../../Researcher/cli-reference/runai-submit.md) Command-line reference.

## How to Submit

A Workload can be submitted via in the following ways:

* The Run:ai [user interface](../../admin/admin-ui-setup/jobs.md).
* The Run:ai command-line interface, via the [runai submit](../../Researcher/cli-reference/runai-submit.md) command.
* The Run:ai [Cluster API](../../developer/cluster-api/workload-overview-dev.md).
* The Run:ai *Workloads* page.

### Submit a Workload Using the UI

!!! Important
    Make sure you have the `Workloads` view enabled. To enable this view, see [Workloads toggle](../admin-ui-setup/jobs.md#workloads-toggle)

To submit a workload using the UI:

1. In the left menu press *Workloads*.
2. Press *New Workload*, and select `Workspace` or `Training`.

For `Workspace`:

1. In the *Projects* pane, select a project. Use the search box to find projects that are not listed. If you can't find the project, see your system administrator.
2. In the *Templates* pane, select a template from the list. Use the search box to find templates that are not listed. If you can't find the specific template you need, create a new one, or see your system administrator.
3. Enter a `Workspace` name, and press continue.
4. In the *Environment* pane select or [create a new environment](workspaces/create/create-env.md). Use the search box to find environments that are not listed.
5. In the *Compute resource* pane, select resources for your tranings or [create a new compute resource](workspaces/create/create-compute.md). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.
6. Open the *Volume* pane, and press *Volume* to add a volume to your training.

      1. Select the *Storage class* from the dropdown.
      2. Select the *Access mode* from the dropdown.
      3. Enter a claim size, and select the units.
      4. Select a *Volume system*, mode from the dropdown.
      5. Enter the *Container path* for volume target location.
      6. Select a *Volume persistency.

7. In the *Data sources* pane, press *add a new data source*. For more information, see [Creating a new data source](workspaces/create/create-ds.md) When complete press, *Create Data Source*.
8. In the *General* pane, add special settings for your training (optional):

      1. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minuets, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails.
      2. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
      3. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.

9. When complete, press *Create workspace.

For `Training`:

## Workload Policies

As an administrator, you can set *Policies* on Workloads.  Policies allow administrators to *impose restrictions* and set *default values* for Researcher Workloads. For more information see [Workload Policies](policies.md).
