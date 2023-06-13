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

!!! note
    See your system administrator to ensure the prerequisites are enabled and configured.
## Adding Trainings

To add a training:

1. Press **Tranings** in the menu.
2. In the *Projects* pane, select the destination project. Use the search box to find projects that are not listed. If you can't find the project, see your system administrator.
3. In the *Templates* pane, select a template from the list. Use the search box to find templates that are not listed. If you can't find the specific template you need, see your system administrator.
4. In the *Training name* pane, enter a name for the *Traninng*, then press continue.
5. In the *Environment* pane select or [create a new environment](workspaces/create/create-env.md). Use the search box to find environments that are not listed.
6. In the *Compute resource* pane, select resources for your tranings or [create a new compute resource](workspaces/create/create-compute.md). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.
7. In the *Data sources* pane, press *add a new data source*. For more information, see [Creating a new data source](workspaces/create/create-ds.md) When complete press, *Create Data Source*.
8. When complete, press *Create training*.

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