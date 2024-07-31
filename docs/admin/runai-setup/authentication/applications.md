This article explains the procedure to manage applications and it’s permissions.

Applications are used for API integrations with Run:ai. An application contains a secret key. Using the secret key you can obtain a token and use it within subsequent API calls.

Applications are managed locally and assigned with Access Rules to manage its permissions.

For example, application **ci-pipeline-prod** assigned with a **Researcher** role in **Cluster: A**.

## Applications table

The Applications table can be found under **Tools & Settings** in the Run:ai platform.

The Applications table provides a list of all the applications defined in the platform, and allows you to manage them.

![](img/appstable.png)


The Applications table consists of the following columns:

| Column | Description |
| :---- | :---- |
| Application | The name of the application |
| Status | The status of the application |
| Access rule(s) | The access rules assigned to the application |
| Last login | The timestamp for the last time the user signed in |
| Created by | The user who created the application |
| Creation time | The timestamp for when the application was created |
| Last updated | The last time the application was updated |

### Customizing the table view

* Filter \- Click ADD FILTER, select the column to filter by, and enter the filter values  
* Search \- Click SEARCH and type the value to search by  
* Sort \- Click each column header to sort by  
* Column selection \- Click COLUMNS and select the columns to display in the table  
* Download table \- Click MORE and then Click Download as CSV

## Creating an application

To create an application:

1. Click **\+NEW APPLICATION**  
1. Enter the application’s **Name**  
1. Click **CREATE**  
1. Copy the credentials and store it securely:  
    * **Application name**  
    * **Secret key**  
1. Click **DONE**

!!!Note
    The secret key is visible only at the time of creation, it cannot be recovered but can be regenerated.

## Adding an access rule to an application

To create an access rule:

1. Select the application you want to add an access rule for  
1. Click **ACCESS RULES**  
1. Click **\+ACCESS RULE**  
1. Select a role  
1. Select a scope  
1. Click **SAVE RULE**  
1. Click **CLOSE**

## Deleting an access rule from an application

To delete an access rule:

1. Select the application you want to remove an access rule from  
1. Click **ACCESS RULES**  
1. Find the access rule assigned to the user you would like to delete  
1. Click on the trash icon  
1. Click **CLOSE**

## Regenerating key

To regenerate an application’s key:

1. Select the application you want to regenerate it’s secret key  
1. Click **REGENERATE KEY**  
1. Click **REGENERATE**  
1. Review the user’s credentials and store it securely:  
    * **Application** name  
    * **Secret key**  
1. Click **DONE**

!!!Warning
    Regenerating an application key revokes its previous key.

## Deleting an application

1. Select the application you want to delete  
1. Click **DELETE**  
1. On the dialog, click **DELETE** to confirm the deletion

## Using API

Go to the [Applications](https://app.run.ai/api/docs\#tag/Applications), [Access rules](https://app.run.ai/api/docs\#tag/Access-rules) API reference to view the available actions

