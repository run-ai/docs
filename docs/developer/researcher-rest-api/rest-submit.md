
Create a new Run:AI Job. 

## General

__URL__:  `http://<service-url>/api/v1/jobs`

__Method__: `POST`

__Headers__

- `Authorization: Bearer <ACCESS-TOKEN>`
- `Content-Type: application/json`

The user name is used for display purposes only when Run:AI is installed in an [unauthenticated mode](../../admin/runai-setup/advanced/researcher-authentication.md).

## Request

The Request body is a JSON object of a Run:AI Job as follows:

``` json
{
    "job" : {
        "name" : "string", 
        "project" : "string (*required)",
        "interactive" : "boolean",
        "image" : "string (*required)",
        "command" : "string", 
        "arguments"  : ["-e", "-f"],
        "environment" : {
                "BATCH_SIZE" : 50, 
                "LEARNING_RATE" : 0.2,
        },
        "imagePullPolicy"  : "string", 
        "stdin"  : "boolean",     
        "tty"  : "boolean",     
        "workingDir"  : "string", 
        "createHomeDir"  : "boolean", 
        "gpu"  : "double",  
        "cpu"  : "double", 
        "cpuLimit"  : "integer",     
        "memory"  : "string", 
        "memoryLimit"  : "string",     
        "largeShm"  : "boolean", 
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
        ],
        "volume": {
            "/raid/public/john/data": "/root/data",
            "/raid/public/john/code": "/root/code"
        },
        "hostIpc"  : "boolean", 
        "hostNetwork"  : "boolean", 
        "ports" : 
            [
                { "container": 80, "external": 32188, "autoGenerate": false},
                { "container": 443, "autoGenerate": true}
            ],
        "backoffLimit" : "integer", 
        "completions"  : "integer", 
        "parallelism"   : "integer", 
        "elastic"  : "boolean", 
        "preemptible"  : "boolean", 
        "serviceType"  : "string", 
        "ttlAfterFinish"  : "string", 
        "preventPrivilegeEscalation"  : "boolean", 
        "nodeType"  : "string",     
        "jobNamePrefix"  : "string" 
    }
}
```

## Job Parameters

* Full documentation of the above parameters can be found in [runai-submit](../../Researcher/cli-reference/runai-submit.md). 
* Mandatory parameters are marked as required.

## Response

``` json
{
    "name": "<new-job-name>"
}
```

## Examples

__Basic job with an auto-generated name__


``` bash
curl -X POST 'http://www.example.com/api/v1/jobs' \
    --header 'Accept: application/json' \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer <ACCESS-TOKEN>'
--data-raw '    {
      "job": {
        "project": "team-a",
        "image": "gcr.io/run-ai-demo/quickstart",
        "gpu": 1
      }
    }'
```

