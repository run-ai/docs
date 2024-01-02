---
title: Templates
summary: This article describes the templates form. This form allows explains what a template is, and where it is used..
authors:
    - Jason Novich
date: 2023-oct-22
---

A template is a pre-set configuration that is used to quickly configure and submit workloads using existing assets.
A template consists of all the assets a workload needs, allowing researchers to submit a workload in a single click, or make subtle adjustments to differentiate them from each other.

## Creating Templates

To create a template:

1. In the left menu, press *Templates*, then press *New Template*.
2. In the *Scope* pane, select a *Scope*.
3. In the *Template Name* pane, enter a name for the template.
3. Select an environment from the tiles. If your environment is not listed, use the *Search environments* box to find it or press [*New environment*](workspaces/create/create-env.md) to create a new environment. Press  to create an environment if needed. In the *Set the connection for your tool(s)*, enter the URL of the tool if a custom URL has been enabled in the selected environment. Use the *Private* toggle to lock access to the tool to only the creator of the environment.

       In the *Runtime Settings*:
    
       1. Press *Commands and Arguments* to add special commands and arguments to your environment selection.
       2. Press *Environment variable* to add an environment variable. Press again if you need more environment variables.
   
4. In the *Compute resource* pane, select a compute resource. Use the *Search compute resources* if you do not see your resource listed. Press *New compute resource* to add a new compute resource to the system. Press *More settings* to add a node type (node affinity) to the compute resource selected.
5. (Optional) In the *Volume* pane, press *+volume* to add a new volume to the template.

    From the drop down menus select:
    * Storage class
    * Access mode
    * Claim size and units
    * Volume mode

    Set the *Volume target location*, then select from either a *Persistent* volume or an *Ephemeral* volume.

6. In the *Data sources* pane, select a data source. Press *New data source* to add a new data source to the system.
7. In the *General* pane, choose to add the following:

    * Auto-deletion&mdash;the time after which a workload that has completed or failed will be deleted. Press *+Auto-deletion* then configure the time in days, hours, minutes, and seconds.
    * Annotation&mdash;press *+Annottion* then enter a name and a value. You can add multiple annotations by pressing the *+Annottion*.
    * Label&mdash;press *+Label* then enter a name and a value. You can add multiple labels by pressing the *+Label*.

8. Press *Create template* when your configuration is complete.
