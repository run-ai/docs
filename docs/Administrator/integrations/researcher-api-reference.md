
# Submit Endpoint

Create a new Run:AI Job. 

## General

**URL**:  `http://<Run:AI Server URL>/api/job`

**Method**: `POST`

**Headers**

- `RA-USER` : `<user name>`


## Request Definition


Following JSON:

``` json
{
    "job": {
        <Job Parameters. See below>
    }
}
```

## Job Parameters

Below is a list of available parameters a full documentation of each parameter can be found in [runai-submit](../../Researcher/cli-reference/runai-submit.md)

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
    'arguments' :  ['-e', '-f']
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
    'storageClass' : 'my-storage',
    'size' :  '3GB',
    'path' :   '/tmp/john'
    'readOnly' :  true
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

    {
      "name":<new job name>
    }


## Examples

**Basic job with auto-generated name**


``` bash
curl -X POST 'http://<IP>:<PORT>/api/job' \
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









    

