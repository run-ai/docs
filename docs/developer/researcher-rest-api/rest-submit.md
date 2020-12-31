
Create a new Run:AI Job. 

## General

**URL**:  `http://<Run:AI Server URL>/api/job`

**Method**: `POST`

**Headers**

- `RA-USER: <user-name>`
- `Content-Type: application/json`


## Request

The Request body is a JSON object of a Run:AI Job as follows:

``` json
{
    "job" : {
        <Job Parameters>
    }
}
```

## Job Parameters

Below is a list of available parameters. Full documentation of each parameter can be found in [runai-submit](../../Researcher/cli-reference/runai-submit.md)

**Basic Parameters**

`name` *string*

`project`  _string_ (*required)    

`interactive` _boolean_

**Container Definition**

`image` *string* (*required) 

`command` _string_

`arguments` _Array<string\>_  

> Example:

``` json
{
    "arguments" :  ["-e", "-f"]
}

```

`environment` _Map<string\>_

> Environment variables to be set in the container. Example:

``` json
{
    "environment": {
        "BATCH_SIZE" : 50, 
        "LEARNING_RAGE" : 0.2,
    }
}
```   

`imagePullPolicy` *string*

`stdin` *boolean*    

`tty` *boolean*    

`workingDir` *string*
    

`createHomeDir` *boolean*

**Resource Allocation Parameters**

`gpu` *double* 

`cpu` *double*

`cpuLimit` *int*    

`memory` *string*

`memoryLimit` *string*    

`largeShm` *boolean*

**Storage**

`pvc`  *Array of* `PVC` objects.

> Mount a persistent volume claim of Network Attached Storage into the container. Example:

``` json
{
    "pvc" : [
        {
            "storageClass" : "my-storage1",
            "size" :  "3GB",
            "path" :   "/tmp/john",
            "readOnly" :  true
        },
        {
            "storageClass" : "my-storage2",
            "size" :  "4GB",
            "path" :   "/tmp/jill",
            "readOnly" :  false        
        }
    ]
}
```

`volume` *Map<string\>*

> Mount a volume into the container. Example:

```
{ 
    "volume": {
    "/raid/public/john/data": "/root/data",
    "/raid/public/john/code": "/root/code"

    }
}
```
**Network**
`hostIpc` *boolean*

`hostNetwork` *boolean*

`ports` *Array<PortMap> (see below)*

**Job Lifecycle**

`backoffLimit` *int*

`completions` *int*

`parallelism`  *int*

`elastic` *boolean*

`preemptible` *boolean*

`serviceType` *string*

`ttlAfterFinish` *string*

**Miscellaneous**

`preventPrivilegeEscalation` *boolean*

`nodeType` *string*    

`jobNamePrefix` *string*


## Response

Following JSON:

``` json
{
    "name": <new-job-name>
}
```

## Examples

**Basic job with an auto-generated name**


``` bash
curl -X POST 'http://www.example.com/api/job' \
--header 'RA-USER: john' \
--header 'Content-Type: application/json' \
--data-raw '    {
      "job": {
        "project": "team-a",
        "image": "gcr.io/run-ai-demo/quickstart",
        "gpu": 1
      }
    }'
```









    

