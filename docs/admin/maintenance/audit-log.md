
## Introduction

The Run:ai control plane provides audit log API and audit log user interface table. Both reflect the same information:

* All changes to business objects
* All logins to the control plane.

## Event History - Audit Log User Interface

The Administrators of the system can view the audit log using the user interface. The audit log screen is under the 'Event History' section:

![Event History full screen](img/event-history-full-screen.png)

### Event History (audit log) information fields
The Administrator can choose what information fields to view within the audit log table, this is done by clicking the 'Columns' button and checking the required fields to be presented:
 
![Event History options](img/event-history-options-large.png)

![Event History columns](img/event-history-columns.png)

Here's the list of available information fields in the Event History (audit log) table:

| Field       | Type         | Description  | 
|-------------|--------------|--------------|
|User/App     | user id      | The identity of the User or Application that executed this operation.   |
| Data & Time | date         | The exact timestamp at which the event occured. <br> Format `dd/mm/yyyy` for date and `hh:mm am/pm` for time. |
| Event       | event type   | The type of the logged operation. Possible values: `Create`, `Update`, `Delete`, `Login`. |
| Event ID     | integer      | Sequanicialy incrmental number of the logged operation, lower number means older event, higher means newer event. | 
| Status      | string       | The outcome of the logged operation. <br>Possible values: `Succeeded`, `Failed`. |
| Entity type | string       | The type of the logged business object. <br>Possible values: `Project`, `Department`, `User`, `Group`, `Login`, `Settings`, `Applications`, `Node Pool`. |
| Entity name | string       | The name of logged business object. | 
| Entity ID   | string       | The system's internal id of the logged business object. |
| Cluster Name   | string    | The name of the cluster that the loged operation relates to. If the operation is not cluster specific - cluster name remains empty. |
| Cluster ID     | string    | The system internal identifier of the cluster that the loged operation relates to. If the operation is not cluster specific - cluster id remains empty. |

### Event History - Date Selector
The Event History table saves logged operations for the last 90 days. However, the table itself presents up to the last 30 days of information due to the potentially very high number of operations that might be logged during this period. To view older logged operations, or if you wish to refine your search and get more specific results or fewer results, you should use the time selector and change the period you search for. You can also refine your search by using filters as explained below.  


![Event History date selector](img/event-history-date-selector.png)

### Event History - Filters
The administrator can choose to filter the table using a list of predefined filters. The filter's value is a free text keyword entered by the administrator and must be fully matched to the requested field's actual value, otherwise, the filter will not find the requested keyword.
Multiple filters can be set in parallel.

![Event History filters menu](img/event-history-filters-menu.png)

![Event History filters](img/event-history-filters.png)

### Event History - Download the Audit Log file
The event history table allows you to download the logged information in text form formatted as CSV or JSON files. The scope of the downloaded information is set by the scope of the table filters, i.e. if no filters or date selectors are used, the downloaded file includes the full scope of the information that the table holds - i.e. up to 30 days of logged information. To view older logged information (up to 90 days older, but no more than 30 days at a time), shorter periods, or narrower (filtered) scopes - use the date selector and filters.

![Event History more sub-menu](img/event-history-more-sub-menu.png)

## Audit log API

Since the amount of data is not trivial, the API is based on _paging_ in the sense that it will retrieve a specified number of items for each API call. You can get more data by using subsequent calls. 

### Retrieve Audit Log data via API

To retrieve the Audit log you need to call an API. You can do this via code or by using the Audit function via a [user interface for calling APIs](https://app.run.ai/api/docs/#/Audit/get_v1_k8s_audit){target=_blank}.

### Additional filter

You can add additional filters to the query as follows:

| Field       | Type | Description | 
|-------------|-------|--------------|
| start      | date   | Start date for audit logs retrieval. <br> Format `yyyy-MM-dd` for date or `yyyy-MM-ddThh:mm:ss` for date-time. |
| end       | date   | End date for audit logs retrieval. <br> Format `yyyy-MM-dd` for date or `yyyy-MM-ddThh:mm:ss` for date-time. |
| action      | string | The action of the logged operation. Possible values: `Create`, `Update`, `Delete`, `Login` |
| source_type | string | The initiator of the action (user or machine to machine key). Possible values: `User`, `Application` | 
| source_id   | string | The id of the source of the action. For `User`, this is the internal user id. For an `Application`, this is the internal id of the Application |
| source_name | string | The name of the source of the action. For a `User`, this is the user's email, for an `Application`, this is the Application name. |
| entity_type | string |The type of business object. Possible values: `Project`, `Department`, `User`, `Group`, `Login`, `Settings`, `Applications` | 
| entity_id   | string | The id of the business object | 
| limit | integer | Paging: the number of records to fetch at once (default is 40 record) |
| offset | integer | Paging: The offset from which to start fetching records. |
| success | string | enter true for successful audit log records and false for failures (default is all records) |
| download | string | enter true to download the logs into a file |


![](img/event-history-full-screen.png)
