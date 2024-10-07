---
title: Trainings
summary: This article describes the trainings feature. This feature provides a wizard like experience to submit training jobs.
authors:
    - Jason Novich
date: 2022-May-30
---
# Trainings

The **Trainings** interface provides a wizard to make submitting workloads easy.

## Prerequisites

You must have:

* ***Workspaces*** enabled.
* At least one ***Project*** configured.

!!! Note
    See your system administrator to ensure the prerequisites are enabled and configured.

## Adding Trainings

!!! Note
    Where there is a card gallery, use the search bar to find specific cards based on title or field values.

To add a training:

1. Press **Tranings** in the menu.
2. In the *Projects* pane, select the destination project. Use the search box to find projects that are not listed. If you can't find the project, you can create your own, or see your system administrator.
3. In the *Multi-node* pane, choose `Single node` for a single node training, or `Multi-node (distributed)` for distributed training. When you choose `Multi-node`, select a framework that is listed, then select the `multi-node` training configuration by selecting either `Workers & master` or `Workers only`.
4. In the *Templates* pane, select a template from the list. Use the search box to find templates that are not listed. If you can't find the specific template you need, see [Creating a new template](../../platform-admin/workloads/assets/templates.md#adding-a-new-workspace-template), or see your system administrator.
5. In the *Training name* pane, enter a name for the *Training*, then press continue.
6. Select an environment from the tiles. If your environment is not listed, use the *Search environments* box to find it or press [*New environment*](../workloads/assets/environments.md#adding-a-new-environment) to create a new environment. Press  to create an environment if needed. In the *Set the connection for your tool(s)*, enter the URL of the tool if a custom URL has been enabled in the selected environment. Use the *Private* toggle to lock access to the tool to only the creator of the environment.

       In the *Runtime Settings*:
    
       1. Press *Commands and Arguments* to add special commands and arguments to your environment selection.
       2. Press *Environment variable* to add an environment variable. Press again if you need more environment variables.
   
7. In the *Compute resource* pane:

       1. Select the number of workers for your training.
       2. Select *Compute resources* for your training or [create a new compute resource](). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.

    !!! Note
        The number of compute resources for the workers is based on the number of workers selected.

8. (Optional) Open the *Volume* pane, and press *Volume* to add a volume to your training.

       1. Select the *Storage class* from the dropdown.
       2. Select the *Access mode* from the dropdown.
       3. Enter a claim size, and select the units.
       4. Select a *Volume system*, mode from the dropdown.
       5. Enter the *Container path* for volume target location.
       6. Select a *Volume persistency.

9.  (Optional) In the *Data sources* pane, press *add a new data source*. For more information, see [Creating a new data source](../workloads/assets/datasources.md#create-a-new-data-source) When complete press, *Create Data Source*.
10. (Optional) In the *General* pane, add special settings for your training (optional):

       1. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minutes, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails. (default = 30 days)
       2. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
       3. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.

11. If you if selected  `Workers & master` Press *Continue* to `Configure the master` and go to the next step. If not, then press *Create training*.

12. If you do not want a different setup for the master, press *Create training*. If you would like to have a different setup for the master, toggle the switch to enable to enable a different setup.

       1. In the *Environment* pane select or [create a new environment](../workloads/assets/environments.md#adding-a-new-environment). Use the search box to find environments that are not listed. Press *More settings* to add an `Environment variable` or to edit the *Command* and *Arguments* field for the environment you selected.
       2. In the *Compute resource* pane, select a *Compute resources* for your training or [create a new compute resource](../workloads/assets/compute.md#adding-new-compute-resource). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.
       3. (Optional) Open the *Volume* pane, and press *Volume* to add a volume to your training.

          1. Select the *Storage class* from the dropdown.
          2. Select the *Access mode* from the dropdown.
          3. Enter a claim size, and select the units.
          4. Select a *Volume system*, mode from the dropdown.
          5. Enter the *Container path* for volume target location.
          6. Select a *Volume persistency.

       4. (Optional) In the *Data sources* pane, press *add a new data source*. For more information, see [Creating a new data source](../workloads/assets/datasources.md#create-a-new-data-source) When complete press, *Create Data Source*.
       5. (Optional) In the *General* pane, add special settings for your training (optional):

          1. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minutes, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails. (default = 30 days)
          2. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
          3. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.

13. When your training configuration is complete. press *Create training*.

## Managing Trainings

The *Trainings* list contains a list of training jobs that you have created or have access to.

To manage your trainings:

1. Press **Tranings** in the left menu.
2. Select a *Training* from the list.
3. Choose from the following actions:
    * **Activate**&mdash;activates the selected training job.
    * **Stop**&mdash;stops the selected training job.
    * **Connect**&mdash;connects to the training job's configured environment.
    * **Copy & edit**&mdash;copies the details of the selected training job to a new training job.
    * **Delete**&mdash;deletes the current training session.
    * **Show details**&mdash;displays details about the training job.

### Training details

Training details are displayed using the *Show details* action. The details available per training job include;

* **Event history**&mdash;a graph of the job's status over time along with a list of events found in the log.
* **Metrics**&mdash;a graph of available metrics for the job. Use the drop down select a date and a time slice. Metrics include:

  * GPU utilization
  * GPU memory usage
  * CPU usage
  * CPU memory usage

* **Logs**&mdash;a log file of the current status. Use the download button to save the logs.

To hide the training details, press *Hide details*.

## Download Trainings Table

You can download the Trainings table to a CSV file. Downloading a CSV can provide a snapshot history of your Trainings over the course of time, and help with compliance tracking. All the columns that are selected (displayed) in the table will be downloaded to the file.

To download the Trainings table to a CSV:
1. Open *Trainings*.
2. From the *Columns* icon, select the columns you would like to have displayed in the table.
3. Click on the ellipsis labeled *More*, and download the CSV.
