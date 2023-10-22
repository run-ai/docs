---
title: Templates
summary: This article describes the templates form. This form allows explains what a template is, and where it is used..
authors:
    - Jason Novich
date: 2023-oct-22
---

# Templates

A template is a pre-set configuration that is used help quickly configure assets in the system.

## Creating Tempplates

To create a template:

1. In the left menu, press *Templates*, then press *New Template*.
2. In the *Scope* pane, select a *Scope*.
3. In the *Template name* pane, enter a name.
4. In the *Environment* pane, select an environment from the list. Use the *Search environments* if you do not see your environment listed. Press *New environment* to add a new environment to the system. Press *More settings* to add an `Environment variable` or to edit the *Command* and *Arguments* field for the environment you selected.
5. In the *Compute resource* pane, select a compute resource. Use the *Search compute resources* if you do not see your resource listed. Press *New compute resource* to add a new compute resource to the system. Press *More settings* to add a node type (node affinity) to the compute resource selected.
6. (Optional) In the *Volume* pane, press *+volume* to add a new volume to the template.

    From the drop down menus select:
    * Storage class
    * Access mode
    * Claim size and units
    * Volume mode

    Set the *Volume target location*, then select from either a *Persistent* volume or an *Ephemeral* volume.

7. In the *Data sources* pane, select a data source. Press *New data source* to add a new data source to the system.
8. In the *General* pane, choose to add the following:

    * Auto-deletion&mdash;the time after which a workload that has completed or failed will be deleted. Press *+Auto-deletion* then configure the time in days, hours, minutes, and seconds.
    * Annotation&mdash;press *+Annottion* then enter a name and a value. You can add multiple annotations by pressing the *+Annottion*.
    * Label&mdash;press *+Label* then enter a name and a value. You can add multiple labels by pressing the *+Label*.

9. Press *Create template* when your configuration is complete.
