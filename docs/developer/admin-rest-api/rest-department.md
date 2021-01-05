# Departments

Create, Update Delete, Get and List Run:AI Departments.

XXXX



## ****  INTERNAL API ISSUES 
``` 
maxAllowedGpus
```

* ...


## JSON Format
Projects are represented as JSON objects with the following properties. All properties are mandatory.

| Name                        | Type                     | Mandatory | Read Only| Description  |  
| :-------------              |:------------------------ | :-------- | :------- | :----------- |
| id                          | integer                  | false     | true     | Department ID. Automatically assigned when the Department is created   |
| name                        | string                   | true      | false    | The name of the Project. |
| tenantId                    | integer                  | false     | true     | ID of customer Tenant  |
| clusterUuid                 | string, , object id      | true      | false    | An ID for a __Cluster__ object. |
| createdAt                   | date-time                | false     | true     | Creation Date-Time. |
| deservedGpus                | double                   | true      | false    | GPU Quota for the Depattment |
| allowOverQuota   ???           | boolean                  | false     | false    | Allow the Project to go over-quota with Training Job. Default is false  | 
| projects                    | array of Projects        | false      | true    | List of Projects in this Department and their quota. Used for display purposes only |
| projectsDeservedGpus         | double                   | false      | true    | Sum of quota of all Projects in Department. Used for display purposes only |




__Example__

``` json
{
  "id": 118,
  "name": "physics",
  "tenantId": 1,
  "clusterUuid": "b3ffb2e2-5a8c-4296-9024-e86fba6fa14d",
  "createdAt": "2020-09-11T04:17:35.589Z",
  "deservedGpus": 5,
  "maxAllowedGpus": -1,  ## What is this?
  "projectsDeservedGpus": "4.00",
  "projects": [
    {
      "id": 235,
      "name": "team-c",
      "deserved_gpus": 0
    },
    {
      "id": 190,
      "name": "team-b",
      "deserved_gpus": 2
    },
    {
      "id": 183,
      "name": "team-a",
      "deserved_gpus": 2
    }
  ]
}
```



## Create Department

`POST  https://app.run.ai/v1/k8s/department/`

Create a new Department in a Cluster.

__Example__  

``` shell
curl -X POST https://app.run.ai/v1/k8s/department/ \
-H 'content-type: application/json' \
-H 'authorization: Bearer <Bearer>' \
--data '{
  "name": "physics",
  "deservedGpus": 5,
  "allowOverQuota": true,
  "clusterUuid": "b3ffb2e2-5a8c-4296-9024-e86fba6fa14d"
}'
```

__Example Response__

``` json
{
  "tenantId": 1,
  "createdAt": "2021-01-05T18:22:07.437Z",
  "name": "physics",
  "deservedGpus": 5,
  "maxAllowedGpus": -1, XXX
  "allowOverQuota": true,
  "clusterUuid": "b3ffb2e2-5a8c-4296-9024-e86fba6fa14d",
  "id": 118
}
```



## Get Department

`GET https://app.run.ai/v1/k8s/department/{department_id}`

Returns a Department object. 

__Example__

``` shell
curl 'https://app.run.ai/v1/k8s/department/118' \
  -H 'authorization: Bearer <Bearer>' \
  -H 'content-type: application/json' 
```

__Example Response__

``` JSON
{
  "id": 118,
  "name": "physics",
  "deservedGpus": 5,
  "tenantId": 1,
  "clusterUuid": "b3ffb2e2-5a8c-4296-9024-e86fba6fa14d",
  "createdAt": "2020-09-11T04:17:35.589Z",
  "maxAllowedGpus": -1,  ## What is this?
  "projectsDeservedGpus": "4.00",
  "projects": [
    {
      "id": 235,
      "name": "team-c",
      "deserved_gpus": 0
    },
    {
      "id": 190,
      "name": "team-b",
      "deserved_gpus": 2
    },
    {
      "id": 183,
      "name": "team-a",
      "deserved_gpus": 2
    }
  ]
}
```

## Update Department

`PUT https://app.run.ai/v1/k8s/department/{department_id}`

Update an existing Department.

!!! Important
    The Update API expects editable Department fields. Fields that are omitted will be removed from the object.

__Example__ 



``` json
curl -X PUT 'https://app.run.ai/v1/k8s/department/118' \
-H 'content-type: application/json' \
-H 'authorization: Bearer <bearer>' \
 --data '{
  "id": 118,
  "name": "physics",
  "deservedGpus": 7,
  "tenantId": 1,
  "clusterUuid": "b3ffb2e2-5a8c-4296-9024-e86fba6fa14d",
  "allowOverQuota": true
}' 
```

__Example Response__

``` json
{
  "tenantId": 1,
  "id": 118,
  "name": "physics",
  "deservedGpus": 7,
  "clusterUuid": "b3ffb2e2-5a8c-4296-9024-e86fba6fa14d",
  "allowOverQuota": true,
  "maxAllowedGpus": -1 ###
}
```


## Delete Department


`DELETE https://app.run.ai/v1/k8s/department/{department_id}`



__Example__ 

``` shell
curl -X 'DELETE' 'https://app.run.ai/v1/k8s/department/118' \
  -H 'authorization: Bearer <bearer>' 
```

__Example Response__

```
Department with id 118 deleted
```


## Get List of Departments

` GET https://app.run.ai/v1/k8s/clusters/{cluster_uuid}/department`

__Example__

``` shell
curl 'https://app.run.ai/v1/k8s/clusters/fa9b7d1c-2f08-42b8-b608-7b7c1fb40ea1/departments' \
  -H 'authorization: Bearer <bearer>' 
```

__Example Response__ 

``` json
[
  {
    "id": 116,
    "name": "default",
    "deservedGpus": 0,
    "tenantId": 1,
    "clusterUuid": "fa9b7d1c-2f08-42b8-b608-7b7c1fb40ea1",
    "createdAt": "2020-12-15T21:19:01.333Z",
    "maxAllowedGpus": -1, XXX
    "projectsDeservedGpus": "1.00",
    "projects": [
      {
        "id": 237,
        "name": "team-a",
        "deserved_gpus": 1
      }
    ]
  }
]
```