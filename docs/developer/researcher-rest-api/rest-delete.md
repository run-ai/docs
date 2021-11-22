
Delete one or more Run:AI Jobs.

## General

__URL__:  `http://<service-url>/api/v1/jobs`

__Method__: `DELETE`

__Headers__

- `Authorization: Bearer <ACCESS-TOKEN>`
## Request 

Following JSON:

```
[<Job Identifier 1>, .... ,<Job Identifier n>]
```

Job identifier definition:

``` json
{
    "name": "<job-name>", 
    "project": "<job-project>"
}
```

    
## Examples

``` bash
curl --location --request DELETE 'http://example.com/api/v1/jobs' \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer <ACCESS-TOKEN>'
--data-raw '[
    {"name" : "job-name-0", "project" : "team-a"}, 
    {"name" : "job-name-1", "project" : "team-a"}
]'
```
