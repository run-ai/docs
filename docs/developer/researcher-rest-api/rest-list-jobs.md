Get a list of all Run:AI Jobs for a given project

## General

__URL__:

The following endpoints are supported:

* `http://<service-url>/api/v1/jobs`
* `http://<service-url>/api/v1/jobs/<project>`
* `http://<service-url>/api/v1/jobs/<project>/<job-name>`

__Method__: `GET`

__Headers__

- `Authorization: Bearer <ACCESS-TOKEN>`

## Path Parameters

### Project

Retrieve all the jobs of the specified `project`.
If the `project` parameter is omitted, then __all__ jobs of all projects are returned. 

### Job-Name

Retrieve a specific job, identified by `project` and `job-name`. 
If `job-name` is omitted, all the jobs of the given project are
returned. If both `project` and `job-name` are omitted, then
__all__ jobs are returned.

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

* `status` will have the values: "Pending", "Running", "Succeeded", "Failed", or "Unknown".
* `type` will have the values: "Train" or "Interactive".
* `createdAt` Job Creation time in a UNIX timestamp format (in milliseconds).
* `nodes` shows the one or more nodes on which the job is running.

## Example

Request:

``` bash
curl --location --request GET 'http://www.example.com/api/v1/jobs?project=team-a' \
    --header 'Authorization: Bearer <ACCESS-TOKEN>'

```

Response:

``` json
{
    "data": [
        {
            "id": "32201782-a525-4939-9dcb-df6654b0b340",
            "project": "team-a",
            "name": "test1",
            "status": "Running",
            "type": "Train",
            "nodes": [
                "dev1-worker-cpu"
            ],
            "createdAt": 1609494983000,
            "images": "ubuntu",
            "user": "john",
            "currentAllocatedGPUs": 1
        },
        {
            "id": "f4606bb5-10f6-4800-9590-933ff1606eba",
            "project": "team-a",
            "name": "job-0",
            "status": "ImagePullBackOff",
            "type": "Train",
            "nodes": [
                "dev1-worker-cpu"
            ],
            "createdAt": 1609672319000,
            "images": "gcr.io/run-ai-demo/quickstart",
            "user": "john",
            "currentAllocatedGPUs": 0
        },
        {
            "id": "1b577b66-4ee4-440d-be13-9b732789c453",
            "project": "team-a",
            "name": "job-10",
            "status": "Succeeded",
            "type": "Train",
            "nodes": [],
            "createdAt": 1609251299000,
            "images": "ubuntu",
            "user": "jill",
            "currentAllocatedGPUs": 0
        }
    ]
}
```

