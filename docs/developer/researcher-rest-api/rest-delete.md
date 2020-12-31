
Deletes a list of Run:AI jobs.

## General

**URL**:  `http://<Run:AI Server URL>/api/job`

**Method**: `DELETE`

## Request 

Following JSON:

```
[<Job Identifier 1>, .... ,<Job Identifier n>]
```

Job Identifier definition:

``` json
{
    "name": "<job-name>", 
    "project": "<job-project>"
}
```

    
## Examples

``` bash
curl --location --request DELETE 'http://example.com/api/job' \
--header 'Content-Type: application/json' \
--data-raw '[
    {"name" : "job-name-0", "project" : "team-a"}, 
    {"name" : "job-name-0", "project" : "team-b"}
]'
```