# Workspace Statuses

The Workspace’s status mechanism displays state of the workspace by aggregating various kubernetes statuses to the following list:


1. Pending – indicates that the workspace is waiting in queue and does not consume any resources. 
2. Initializing – indicates that  the workspace has been scheduled and it is consuming resources.
3. Active – indicates that the workspace is ready to be used and allows the data scientist to connect to its tools.
4. Stopped – indicates that the workspace is currently unused and does not consume any resources unless it is activated again.
5. Failed – indicates that something went wrong and the workspace is not usable.

This allows the data scientist to quickly understand whether the workspace is ready to use and if resources are allocated to it. When you hover over the status column more details a balloon will show more details about the workspace status.


![](img/exrra.png)


## Pending workspace
This indicates that the workspace is waiting in queue and does not consume any resources. The workspace will always end up in this state if the workspace was successfully activated but the relevant resources are unavailable.

## Initializing workspace
This indicates that the workspace has been scheduled and it is consuming resources. However, it is not active yet as its container is still initializing (so it is not possible to connect to the tools). This step can take several minutes or a few seconds depending on several factors like the image size to be pulled. The workspace always goes through this state before the workspace turns active.


## Active workspace
This indicates that the workspace is ready to be used and allows the data scientist to connect to its tools. At this status, it is consuming resources and affecting the project’s quota. The workspace will turn to active status once the “active” button is pressed (see also [Activating a workspace](#xxxx)), the activation process ends up successfully and relevant resources are available and vacant.

## Stopped workspace
This indicates that the workspace is currently unused and should not consume any resources unless it is activated again. A workspace can be stopped either manually (see [Stopping a workspace](#xxx)) or automatically if triggered by idleness criteria set by the admin (see [Setting a time limit](#ddd)).

## Failed workspace

This indicates that something went wrong and the workspace is not usable. At this point, it is needed to recreate the workspace.
Transitioning states
When the user attempts to delete, stop, or activate a workspace, the status column indicates a transition state which will either be successful or will fail. If the action fails, the workspace will stay in its original status. For example, if the user tries to delete an active workspace and fails, the workspace is left in active status. Transitioning states are only visible in the browser of the user who performed the action.


## Transitioning workspaces

When the user attempts to delete, stop, or activate a workspace, the status column indicates a transition state which will either be successful or will fail. If the action fails, the workspace will stay in its original status. For example, if the user tries to delete an active workspace and fails, the workspace is left in active status. Transitioning states are only visible in the browser of the user who performed the action.

![](img/transitioning.png)
