# Workspace Statuses

The Workspace’s status mechanism displays the state of the workspace by aggregating various Kubernetes statuses into the following list:

| Status | Description |
|--------|-------------|
| Pending | The workspace is waiting in queue and does not consume any resources.  |
| Initializing | The workspace has been scheduled and it is consuming resources. |
| Active | The workspace is ready to be used and allows the researcher to connect. |
| Stopped | The workspace is currently unused and does not consume any resources |
| Failed | Something went wrong and the workspace is not usable. | 

This allows the researcher to quickly understand whether the workspace is ready to use and if resources are allocated to it. You can hover over the status column to see additional details about the workspace status.

![](img/9-hover-status.png)

## Pending workspace
The *Pending* status indicates that the workspace is waiting in queue and does not consume any resources. The workspace will always end up in this state if the workspace was successfully activated but the relevant resources are unavailable.

## Initializing workspace

The *Initializing* status indicates that the workspace has been scheduled and is consuming resources. However, it is not active yet as its container is still initializing (so it is not possible to connect to the container tools). This step can take anything from a few seconds to a couple of minutes depending on several factors such as the image size to be pulled. The workspace always goes through this state before the workspace turns active.

## Active workspace
The *Active* status indicates that the workspace is ready to be used and allows the researcher to connect to its tools. At this status, the workspace is consuming resources and affecting the project’s quota. The workspace will turn to active status once the `Active` button is pressed, the activation process ends up successfully and relevant resources are available and vacant.

## Stopped workspace
The *Stopped* status indicates that the workspace is currently unused and does not consume any resources. A workspace can be stopped either manually, or automatically if triggered by idleness criteria set by the admin (see [Limit duration of interactive Jobs](../../../admin/admin-ui-setup/project-setup.md#limit-duration-of-interactive-and-training-jobs)).

## Failed workspace

The *Failed* status indicates that something went wrong and the workspace is not usable. You must recreate the workspace and try again.

## Transitioning states

When the user attempts to delete, stop, or activate a workspace, the status column indicates a transition state which will either be successful or will fail. If the action fails, the workspace will stay in its original status. For example, if the user tries to delete an active workspace and fails, the workspace is left in active status. Transitioning states are only visible in the browser of the user.

![](img/10-transitioning-state.png)

## Download Workspaces Table

You can download the Workspaces table to a CSV file. Downloading a CSV can provide a snapshot history of your workspaces over the course of time, and help with compliance tracking. All the columns that are selected (displayed) in the table will be downloaded to the file.

To download the Workspaces table to a CSV:

1. Open *Workspaces*.
2. From the *Columns* icon, select the columns you would like to have displayed in the table.
3. Click on the ellipsis labeled *More*, and download the CSV.
