---
title: Trainings
summary: This article describes the trainings feature. This feature provides a wizard like experience to submit training jobs.
authors:
    - Jason Novich
date: 2022-May-30
---
# Trainings

The **Trainings** interface provides a wizard to make submitting jobs easy.

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
2. In the *Projects* pane, select the destination project. Use the search box to find projects that are not listed. If you can't find the project, see your system administrator.
3. In the *Templates* pane, select a template from the list. Use the search box to find templates that are not listed. If you can't find the specific template you need, see your system administrator.
4. In the *Training name* pane, enter a name for the *Traninng*, then press continue.
5. In the *Environment* pane select or [create a new environment](workspaces/create/create-env.md). Use the search box to find environments that are not listed.
6. In the *Compute resource* pane, select resources for your tranings or [create a new compute resource](workspaces/create/create-compute.md). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.
7. Open the *Volume* pane, and press *Volume* to add a volume to your training.
   1. Select the *Storage class* from the dropdown.
   2. Select the *Access mode* from the dropdown.
   3. Enter a claim size, and select the units.
   4. Select a *Volume system*, mode from the dropdown.
   5. Enter the *Container path* for volume target location.
   6. Select a *Volume persistency.
8. In the *Data sources* pane, press *add a new data source*. For more information, see [Creating a new data source](workspaces/create/create-ds.md) When complete press, *Create Data Source*.
9. In the *General* pane, add special settings for your training (optional):
   1. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minuets, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails.
   2. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
   3. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.
10. When complete, press *Create training*.

## Managing Trainings

The *Trainings* list contains a list of training jobs that you have created or have access to.

To manage your trainings:

1. Press the 1. Press **Tranings** in the menu.
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

* **Event hostory**&mdash;a graph of the job's status over time along with a list of events found in the log.
* **Metrics**&mdash;a graph of available metrics for the job. Use the drop down select a date and a time slice. Metrics include:

    * GPU utilization
    * GPU memory useage
    * CPU useage
    * CPU memory useage

* **Logs**&mdash;a log file of the current status. Use the download button to save the logs.

To hide the training details, press *Hide details*.
