
## Introduction

The Run:ai control-plane contains API which provides an audit log of all changes and logins to the control-plane.

## Retrieve Audit Log data

To retrieve the Audit log you need to call an API. You can do this via code or by using the Audit function via a [user interface for calling APIs](https://yaron.runailabs.net/api/docs/#/Audit/get_v1_k8s_audit){target=_blank}.


### Retrieve via Code

Create an Application and generate a bearer token by following the [API Authentication](../../../developer/rest-auth.md) document.  

To get the entire audit log run:

``` bash 
curl -X 'GET' \
  'https://<COMPANY-URL>/v1/k8s/audit' \  # (1)
  -H 'accept: application/json' \
  -H 'Authorization: Bearer <ACCESS-TOKEN>' # (2)
```

1. 
2. 


Sample result:

``` json
[
    {
        "id": 3,
        "tenantId": 1,
        "happenedAt": "2022-07-07T09:45:32.069Z",
        "action": "Update",
        "version": "1.0",
        "entityId": "1",
        "entityType": "Project",
        "entityName": "team-a",
        "sourceType": "User",
        "sourceId": "a79500fb-c452-471f-adc0-b65c972bd5c2",
        "sourceName": "test@run.ai",
        "context": {
            "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36",
            "ip_address": "10.244.0.0"
        }
    },
    {
        "id": 2,
        "tenantId": 1,
        "happenedAt": "2022-07-07T08:27:39.649Z",
        "action": "Create",
        "version": "1.0",
        "entityId": "fdc90aab-b183-4856-8337-14039063b876",
        "entityType": "App",
        "entityName": "admin",
        "sourceType": "User",
        "sourceId": "a79500fb-c452-471f-adc0-b65c972bd5c2",
        "sourceName": "test@run.ai",
        "context": {
            "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36",
            "ip_address": "10.244.0.0"
        }
    },
...
]
```


| Field       | Type | Description | 
|----------------------------------|
| before      | date   | Start date for audit logs retrieval. <br> Format yyyy-MM-dd for date or yyyy-MM-ddTHH:mm:ss for date-time. |
| after       | date   | End date for audit logs retrieval. <br> Format yyyy-MM-dd for date or yyyy-MM-ddTHH:mm:ss for date-time. |
| action      | string | The action of the logged operation. Possible values: `Create`, `Update`, `Delete` |
| source_type | string | The initiator of the action (user or machine to machine key). Possible values: `User`, `Application` | 
| source_id   | string | The id of the source of the action. For User, this is the internal user id. For an Application, this is the internal id of the Application |
| source_name | string | The name of the source of the action. For a user, this is the user's email, for an Application, this is the Application name. |
| entity_type | string |The type of business object. Possible values: `Project`, `Department`, `User`, `Login`, `Setting` |
| entity_id   | string | The id of the business object to which the action is related.  For example: a specific Project by its id...XXX | 
| limit | integer | Paging: the number of records to fetch. (Default is 40). .... |
| offset | integer | Paging: The offset from which to start fetching records. |
| success | string | enter true for success audits and false for failures (leave blank for all) |
| download | string | enter true to download the logs into logs.json file |

download


Roi Raiten
  6:06 PM
i had to get back to you re the documentation for the audit





6:06
possible entity_type values:
departments, projects, settings, users, groups, applications
possible action values:
create, update, delete, login (only successful ones)
possible source_type values:
user, app
6:08
also can set entity_type for tenants but you should probably don’t expose this in doc unless the customer can manage tenants which is not the case for now