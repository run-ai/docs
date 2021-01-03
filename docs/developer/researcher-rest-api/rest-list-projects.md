Get a list of all Run:AI Projects

## General

__URL__:  `http://<service-url>/api/v1/projects`

__Method__: `GET`

## Request


## Response 
```
{
    "data": Array<Project>
}
```

Project:

``` json


{
    "name": "<Project Name>",
    "createdAt": "<Project creation time>",
    "deservedGpus": "<GPUs>",
    "interactiveJobTimeLimitSecs": "<TTL for Interactive Jobs>",
    "trainNodeAffinity": "Array<Affinity Group>",
    "interactiveNodeAffinity": "Array<Affinity Group>",
    "departmentName": "default"
}

```

* `deservedGpus` GPU _deserved_ quota for this project.
* `'createdAt` Project Creation time in a UNIX timestamp format (in milliseconds).
* `trainNodeAffinity` Scheduler training Jobs only on these node groups.
* `interactiveNodeAffinity`  - Scheduler interactive Jobs only on these node groups.


For more information see [Working with Projects](../../Administrator/Admin-User-Interface-Setup/Working-with-Projects.md).

## Example

Request:

``` bash
curl --location --request GET 'http://www.example.com/api/v1/projects' 
```

Response:

``` json
{
    "data": [
        {
            "name": "team-a",
            "createdAt": 1609183432000,
            "deservedGpus": 2,
            "interactiveJobTimeLimitSecs": 0,
            "trainNodeAffinity": null,
            "interactiveNodeAffinity": null,
            "departmentName": "default"
        },
        {
            "name": "team-b",
            "createdAt": 1609183432000,
            "deservedGpus": 2,
            "interactiveJobTimeLimitSecs": 0,
            "trainNodeAffinity": [
                "gpu2",
                "gpu1"
            ],
            "interactiveNodeAffinity": null,
            "departmentName": "default"
        }
    ]
}
```

