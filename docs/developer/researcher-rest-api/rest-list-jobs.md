Get a list of all Run:AI Jobs for a given project

## General

__URL__:  `http://<service-url>/api/v1/jobs`

__Method__: `GET`

## Request

```
project=<project-name>
```

If the `project` parameter is omitted, then __all__ jobs will be returned. 


## Response 
```
{
    "data": Array<Job>
}
```

Job:

``` json
{
    "id": "<JOB ID>",
    "project": "<Job Project>",
    "name": "<Job Name>",
    "status" : "<Job status>",
    "type" : "<Job type>",
    "nodes" : "<Node name>",
    "createdAt": "<Job creation time>",
    "images": "<Job image>",
    "user": "<User name>",
    "currentAllocatedGPUs": "<GPUs>"
}

```

* `status` will have the values: "Pending", "Running", "Succeeded", "Failed" or "Unknown".
* `type` will have the values: "Train" or "Interactive".
* `'createdAt` Job Creation time in a UNIX timestamp format (in milliseconds).
* `nodes` shows the one or more nodes on which the job is running.

## Example

Request:

``` bash
curl --location --request GET 'http://www.example.com/api/job?project=project-0'
```

Response:

``` json
{
    "data": [
        {
            "id": "b915c8ec-19b6-4135-b473-164971278fff",
            "project": "project-0",
            "name": "job-0",
            "status": "Running",
            "type": "Train",
            "nodes": "node-0",
            "createdAt": 1609340976000,
            "images": "gcr.io/run-ai-demo/quickstart",
            "user": "Jhon Smith",
            "currentAllocatedGPUs": 1
        },
        {
            "id": "b915c8ec-19b6-4135-b473-164971278fff",
            "project": "project-0",
            "name": "job-1",
            "status": "Pending",
            "type": "Train",
            "nodes": "node-0",
            "createdAt": 1609340976000,
            "images": "gcr.io/run-ai-demo/quickstart",
            "user": "Jhon Smith",
            "currentAllocatedGPUs": 1
        }
    ]
}
```

