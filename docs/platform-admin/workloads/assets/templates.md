  
This article explains the procedure to manage templates.

A template is a pre-set configuration that is used to quickly configure and submit workloads using existing assets. A template consists of all the assets a workload needs, allowing researchers to submit a workload in a single click, or make subtle adjustments to differentiate them from each other.

## Workspace templates table

Access to the Templates table can be found on the left-hand menu in the Run:ai platform.

The Templates table provides a list of all the templates defined in the platform, and allows you to manage them.

!!! Note "Flexible Management"
    It is also possible to manage templates directly for a specific user, application, project, or department.

![](img/template-table.png)

The Templates table consists of the following columns:

| Column | Description |
| :---- | :---- |
| Scope | The scope to which the subject has access. Click the name of the scope to see the scope and its subordinates |
| Environment | The name of the environment related to the workspace template |
| Compute resource | The name of the compute resource connected to the workspace template |
| Data source(s) | The name of the data source(s) connected to the workspace template |
| Created by | The subject that created the template |
| Creation time | The timestamp for when the template was created |
| Cluster | The cluster name containing the template |

### Customizing the table view

* Filter - Click __ADD FILTER__, select the column to filter by, and enter the filter values  
* Search - Click __SEARCH__ and type the value to search by  
* Sort - Click each column header to sort by  
* Column selection - Click __COLUMNS__ and select the columns to display in the table  
* Download table - Click __MORE__ and then Click Download as CSV  
* Refresh (optional) - Click __REFRESH__ to update the table with the latest data  
* Show/Hide details (optional) - Click to view additional information on the selected row

## Adding a new workspace template

To add a new template:

1. Click __+NEW TEMPLATE__  
2. Set the scope for the template  
3. Enter a name for the template  
4. Select the environment for your workload  
5. Select the node resources needed to run your workload  
    \- or -  
   Click __+NEW COMPUTE RESOURCE__

6. Set the volume needed for your workload  
7. Create a new data source  
8. Set auto-deletion, annotations and labels, as required  
9. Click __CREATE TEMPLATE__

## Editing a template

To edit a template:

1. Select the template from the table  
2. Click __Rename__ to provide it with a new name  
3. Click __Copy & Edit__ to make any changes to the template

## Deleting a template

To delete a template:

1. Select the template you want to delete  
2. Click __DELETE__  
3. Confirm you want to delete the template

## Using API**

Go to the [Workload template](https://app.run.ai/api/docs#tag/Template) API reference to view the available actions  
