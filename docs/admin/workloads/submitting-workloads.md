---
title: Submitting Workloads
summary: This article describes how to submit a workload using the workloads V2 form.
authors:
    - Jason Novich
date: 2023-Dec-26
---

## How to Submit a Workload

To submit a workload using the UI:

1. In the left menu press *Workloads*.
2. Press *New Workload*, and select *Workspace* or *Training*.

=== "Workspace"

      1. In the *Projects* pane, select a project. Use the search box to find projects that are not listed. If you can't find the project, see your system administrator.
      2. In the *Templates* pane, select a template from the list. Use the search box to find templates that are not listed. If you can't find the specific template you need, create a new one, or see your system administrator.
      3. Enter a `Workspace` name, and press continue.
      4. In the *Environment* pane select or [create a new environment](../../Researcher/user-interface/workspaces/create/create-env.md). Use the search box to find environments that are not listed.
      5. In the *Compute resource* pane, select resources for your tranings or [create a new compute resource](../../Researcher/user-interface/workspaces/create/create-compute.md). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.
      6. Open the *Volume* pane, and press *Volume* to add a volume to your training.

            1. Select the *Storage class* from the dropdown.
            2. Select the *Access mode* from the dropdown.
            3. Enter a claim size, and select the units.
            4. Select a *Volume system*, mode from the dropdown.
            5. Enter the *Container path* for volume target location.
            6. Select a *Volume persistency.

      7. In the *Data sources* pane, press *add a new data source*. For more information, see [Creating a new data source](../../Researcher/user-interface/workspaces/create/create-ds.md) When complete press, *Create Data Source*.
      8. In the *General* pane, add special settings for your training (optional):

            1. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minuets, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails.
            2. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
            3. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.

      9. When complete, press *Create workspace.

=== "Training"

      1. In the *Projects* pane, select the destination project. Use the search box to find projects that are not listed. If you can't find the project, you can create your own, or see your system administrator.
      2. In the *Multi-node* pane, choose `Single node` for a single node training, or `Multi-node (distributed)` for distributed training. When you choose `Multi-node`, select a framework that is listed, then select the `multi-node` training configuration by selecting either `Workers & master` or `Workers only`.
      3. In the *Templates* pane, select a template from the list. Use the search box to find templates that are not listed. If you can't find the specific template you need, see your system administrator.
      4. In the *Training name* pane, enter a name for the *Traninng*, then press continue.
      5. In the *Environment* pane select or [create a new environment](../../Researcher/user-interface/workspaces/create/create-env.md). Use the search box to find environments that are not listed. Press *More settings* to add an `Environment variable` or to edit the *Command* and *Arguments* field for the environment you selected.
      6. In the *Compute resource* pane:

             1. Select the number of workers for your training.
             2. Select *Compute resources* for your training or [create a new compute resource](../../Researcher/user-interface/workspaces/create/create-compute.md). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.

          !!! Note
              The number of compute resources for the workers is based on the number of workers selected.

      7. (Optional) Open the *Volume* pane, and press *Volume* to add a volume to your training.

             1. Select the *Storage class* from the dropdown.
             2. Select the *Access mode* from the dropdown.
             3. Enter a claim size, and select the units.
             4. Select a *Volume system*, mode from the dropdown.
             5. Enter the *Container path* for volume target location.
             6. Select a *Volume persistency.

      8. (Optional) In the *Data sources* pane, press *add a new data source*. For more information, see [Creating a new data source](../../Researcher/user-interface/workspaces/create/create-ds.md) When complete press, *Create Data Source*.
      9. (Optional) In the *General* pane, add special settings for your training (optional):

             1. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minuets, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails.
             2. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
             3. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.

      10. If you if selected  `Workers & master` Press *Continue* to `Configure the master` and go to the next step. If not, then press *Create training*.

      11. If you do not want a different setup for the master, press *Create training*. If you would like to have a different setup for the master, toggle the switch to enable to enable a different setup.

             1. In the *Environment* pane select or [create a new environment](../../Researcher/user-interface/workspaces/create/create-env.md). Use the search box to find environments that are not listed. Press *More settings* to add an `Environment variable` or to edit the *Command* and *Arguments* field for the environment you selected.
             2. In the *Compute resource* pane, select a *Compute resources* for your training or [create a new compute resource](../../Researcher/user-interface/workspaces/create/create-compute.md). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.
             3. (Optional) Open the *Volume* pane, and press *Volume* to add a volume to your training.

                1. Select the *Storage class* from the dropdown.
                2. Select the *Access mode* from the dropdown.
                3. Enter a claim size, and select the units.
                4. Select a *Volume system*, mode from the dropdown.
                5. Enter the *Container path* for volume target location.
                6. Select a *Volume persistency.

             4. (Optional) In the *Data sources* pane, press *add a new data source*. For more information, see [Creating a new data source](../../Researcher/user-interface/workspaces/create/create-ds.md) When complete press, *Create Data Source*.
             5. (Optional) In the *General* pane, add special settings for your training (optional):

                1. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minuets, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails.
                2. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
                3. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.

      12. When your training configuration is complete. press *Create training*.

## Workload Policies

As an administrator, you can set *Policies* on Workloads.  Policies allow administrators to *impose restrictions* and set *default values* for Researcher Workloads. For more information see [Workload Policies](../workloads/policies/policies.md).
