---
title: Create a new workspace
summary: This article describes how to create new workspaces.
authors:
    - Jason Novich
date: 2024-Jan-7
---

A Workspace is assigned to a project and is affected by the project’s quota just like any other workload. A workspace is shared with all project members for collaboration.

!!! Note
      * You must have at least one project configured in the system. To configure a project, see [Creating a project](../../../../admin/admin-ui-setup/project-setup.md#create-a-project).
      * You must have at least 1 researcher assigned to the project.

Use the *Jobs form* below if you have not enabled the *Workloads* feature.

=== "Jobs enabled"
    To create a new workspace:

      1. Press **Workspaces** on left menu, then press *New workspace*.
      2. Select a project from the project tiles. If your project is not listed, use the *Search projects* box to find a project.
      3. Select a template from the template tiles. If your template is not listed, use the *Search templates* box to find a template. Choose *Start from scratch* if you do not have, or want to use a template.

          A template contains a set of predefined building blocks as well as additional configurations which allow the user to immediately create a templated-based workspace.

      4. Enter a name for your workspace and press *Continue*.
      5. Select an environment from the tiles. If your environment is not listed, use the *Search environments* box to find it or press [*New environment*](../create/create-env.md) to create a new environment. Press  to create an environment if needed. In the *Set the connection for your tool(s)*, enter the URL of the tool if a custom URL has been enabled in the selected environment. Use the *Private* toggle to lock access to the tool to only the creator of the environment.
 
         In the *Runtime Settings*:

         1. Press *Commands and Arguments* to add special commands and arguments to your environment selection.
         2. Press *Environment variable* to add an environment variable. Press again if you need more environment variables.

      6. Select a compute resource from the tiles. If your compute resource is not listed, use the *Search compute resources* box to find it. Press *New compute resource* to create a compute resource if needed.
      7. Open the *Volume* pane, and press *Volume* to add a volume to your workspace.

         1. Select the *Storage class* from the dropdown.
         2. Select the *Access mode* from the dropdown.
         3. Enter a claim size, and select the units.
         4. Select a *Volume system*, mode from the dropdown.
         5. Enter the *Container path* for volume target location.
         6. Select a *Volume persistency*. Choose from *Persistent* or *Ephemeral*.

      8. Select a data source from the tiles. If your data source is not listed, use the *Search compute resources* box to find it. Press *New data source* to create a new data source if needed.
      9. In the *General* pane, add special settings for your workspace:
    
         1.  Press *Auto-deletion* to delete the workspace automatically when it either completes or fails. You can configure the timeframe in days, hours, minutes, and seconds. If the timeframe is set to 0, the workspace will be deleted immediately after it completes or fails.
         2.  Press *Annotation* to a name and value to annotate the workspace. Repeat this step to add multiple annotations.
         3.  Press *Label* to a name and value to label the workspace. Repeat this step to add multiple labels.
    
      10. Press *Create workspace*

=== "Workloads enabled"
    To create a new workspace:

      1. Press **Workloads** on left menu, then press *New workload*, then choose *Workspace*.
      2. Select a project from the project tiles. If your project is not listed, use the *Search projects* box to find a project.
      3. Select a template from the template tiles. If your template is not listed, use the *Search templates* box to find a template. Choose *Start from scratch* if you do not have, or want to use a template.

          A template contains a set of predefined building blocks as well as additional configurations which allow the user to immediately create a templated-based workspace.

      4. Enter a name for your workspace and press *Continue*.
      5. Select an environment from the tiles. If your environment is not listed, use the *Search environments* box to find it. Press *New environment* to create an environment if needed. In the *Set the connection for your tool(s)*, enter the URL of the tool if a custom URL has been enabled in the selected environment. Use the *Private* toggle to lock access to the tool to only the creator of the environment.
 
         In the *Runtime Settings*:

         1. Press *Commands and Arguments* to add special commands and arguments to your environment selection.
         2. Press *Environment variable* to add an environment variable. Press again if you need more environment variables.

      6. Select a compute resource from the tiles. If your compute resource is not listed, use the *Search compute resources* box to find it. Press *New compute resource* to create a compute resource if needed.
      7. Open the *Volume* pane, and press *Volume* to add a volume to your workspace.

         1. Select the *Storage class* from the dropdown.
         2. Select the *Access mode* from the dropdown.
         3. Enter a claim size, and select the units.
         4. Select a *Volume system*, mode from the dropdown.
         5. Enter the *Container path* for volume target location.
         6. Select a *Volume persistency*. Choose from *Persistent* or *Ephemeral*.

8. Select a data source from the tiles. If your data source is not listed, use the *Search data resources* box to find it. Press *New data source* to create a new data source if needed.
9. In the *General* pane, add special settings for your workspace:

      1. Press *Auto-deletion* to delete the workspace automatically when it either completes or fails. You can configure the timeframe in days, hours, minuets, and seconds. If the timeframe is set to 0, the workspace will be deleted immediately after it completes or fails.
      2. Press *Annotation* to a name and value to annotate the workspace. Repeat this step to add multiple annotations.
      3. Press *Label* to a name and value to label the workspace. Repeat this step to add multiple labels.

10. Press *Create workspace*
