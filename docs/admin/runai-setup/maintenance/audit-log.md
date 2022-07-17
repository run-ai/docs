
## Introduction

The Run:ai control plane provides audit-log API. The API can be used to retrieve:

* All changes to business objects
* All logins to the control plane.

Since the amount of data is not trivial, the API is based on _paging_ in the sense that it will retrieve a specified number of items for each API call. You can get more data by using subsequent calls. 

## Retrieve Audit Log data

To retrieve the Audit log you need to call an API. You can do this via code or by using the Audit function via a [user interface for calling APIs](https://yaron.runailabs.net/api/docs/#/Audit/get_v1_k8s_audit){target=_blank}.


### Retrieve via Code

Create an Application and generate a bearer token by following the [API Authentication](../../../developer/rest-auth.md) document.  

To get the first 40 records of the audit log starting January 1st, 2022, run:

``` bash 
curl -X 'GET' \
  'https://<COMPANY-URL>/v1/k8s/audit?start=2022-1-1' \  # (1)
  -H 'accept: application/json' \
  -H 'Authorization: Bearer <ACCESS-TOKEN>' # (2)
```

1.  `<COMPANY-URL>` is `app.run.ai` for SaaS installations (not `<company>.run.ai`) or the Run:ai user interface URL for Self-hosted installations.
2. To obtain a Bearer token see [API authentication](../../../developer/rest-auth.md).



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

### Paging

Use the `limit` and `offset` properties to retrieve all audit log entries.


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





