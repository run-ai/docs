# What's New for the Run:ai SaaS Platform

The release notes are aimed to provide transparency into the latest changes and improvements to Run:ai’s SaaS platform. The updates include new features, optimizations, and fixes aimed at improving performance and user experience. 

Latest GA release notes ([https://docs.run.ai/latest/home/whats-new-2-19/](https://docs.run.ai/latest/home/whats-new-2-19/)) 

##  Gradual Rollout

SaaS features are gradually rolled out to customers over the course of a week to ensure a smooth transition and minimize any potential disruption. 

## December Release 

### Resolved Bugs 

| ID | Description |
| :---- | :---- |
| RUN-23583 | Fixed a bug where navigating through the context menu in the new UI could cause some pages to incorrectly appear as active |
| RUN-23471 | Resolved a bug where deleting an environment variable from an environment asset prevented it from being re-added |
| RUN-23446 | Fixed a bug where the node pool in quota management could display incorrectly when creating a new project | 
| RUN-23926 | Resolved an issue where the EULA page appeared blank for part of the users |
| RUN-24303 | Fixed a bug where Application admin did not have a CRUD permission |


## November Release 

### Product Enhancements

- The display of the default GPU quota for the default department has been updated. Previously, the GPU quota was shown as __-1__. It has now been changed to display as "-" for better clarity.  <!-- (RUN-22906)   -->
- New permissions have been added for the Application Administrator role, enabling full CRUD (Create, Read, Update, Delete) capabilities for managing applications. <!-- (RUN-23441) -->


### Resolved Bugs 

| ID | Description |
| :---- | :---- |
| RUN-23778 | Resolved an issue where SAML mappers were displayed as null in the UI upon editing an Identity Provider (IdP). The mapper values now persist as expected, and associated attributes remain unchanged. |
| RUN-23762 | Fixed a bug that caused some customers to receive the incorrect version of the dashboard. This issue led to inconsistencies in the user interface and functionality, impacting affected users' ability to access the appropriate dashboard features. |
| RUN-23735 | Fixed an issue where the `limit` parameter on the Users page did not enforce the minimum value constraint. This allowed invalid values to be processed, potentially causing errors in pagination |
| RUN-23669 | Consumption report: The Inspect feature in Grafana, which allows users to export consumption data from the portal, has been re-enabled |
| RUN-23664 | An issue has been resolved where the GPU quota numbers displayed on the Department Overview page did not match the values shown on the Department Edit page. |
| RUN-20116 | An issue has been resolved where searching for certain pages in the UI only applied the search filter to the current page. Relevant tables are: Users, Applications, Workloads, Projects, departments, Node pools.  |
| RUN-23575 | The dynamic refresh was not properly preserving the user’s widget settings, causing them to reset to default values after each refresh cycle.  |
| RUN-23376 | CLI v2: An issue was resolved where the runai logs command failed with a 401 Unauthorized error after a period of inactivity |
| RUN-23373 | An issue where AWS storage classes were not appearing when creating a new data source within a new workload has been resolved. Previously, AWS storage classes were only visible when creating a data source directly from the Data Sources tab.  |

