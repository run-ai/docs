---
title: Trainings
summary: This article describes the trainings feature. This feature provides a wizard like experience to submit training jobs.
authors:
    - Jason Novich
date: 2022-May-30
---
# Trainings

The **Trainings** interface provides a wizard like experience to submit training jobs.

## Prerequisites

* *Workspaces* must be enabled.
* At least one *Project* must be configured.

!!! Note
    See you system administrator if the prerequisites are not enabled.

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
