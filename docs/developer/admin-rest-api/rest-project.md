# Projects

Create, Update Delete, Get and List Run:AI Projects.

Researchers are submitting Jobs via The Run:AI CLI, Kubeflow or similar. To streamline resource allocation and  prioritize work, Run:AI introduces the concept of __Projects__. Projects are quota entities that associate a Project name with GPU allocation and allocation preferences. 

A Researcher submitting a Job needs to associate a Project name with the request. The Run:AI scheduler will compare the request against the current allocations and the Project and determine whether the workload can be allocated resources or whether it should remain in the queue for future allocation.




## ****  INTERNAL API ISSUES 

Json object: 

* allowOverQuota default is false. Should be true.
* selectedTypes - Not conforming to standard array of IDs [20, 21] but rather [{id: 20}], through all the APIs
* Low priority: departmentId is mandatory even if departments is off for the tenant. Its annoying as you have to get the id of the department

General:

* Do we use Cluster to identify the project or not? E.g. for deletion. 

Get Project API 
* API does not exist or is not working. 

Project update

* Project update request and response trainNodeAffinity in two separate formats. 
* What is "maxAllowedGpus" ? Is it allowOverQuota
* Cannot reconstruct, but its there...: Department is referenced by ID but in one example I saw it referenced by name.
* Why is the name mandatory (the id already identifies it)
* I think that read-only fields such as clusterUuid should not be mandatory unless they are used for verifying that the project is in the right cluster...

Project create

* maxAllowedGpus appears in response
* Low priority: Perhaps permissions can be optional when authentication not enabled. 


Project delete 

* ...


## JSON Format
Projects are represented as JSON objects with the following properties. All properties are mandatory.

| Name                        | Type                     | Mandatory | Read Only| Description  |  
| :-------------              |:------------------------ | :-------- | :------- | :----------- |
| id                          | integer                  | false     | true     | Project Id  |
| tenantId                    | integer                  | false     | true     | true      |
| name                        | string                   | true      | false    | The name of the Project. |
| departmentId                | integer, object id       | true      | false    | Id of __Department__ object  |
| deservedGpus                | double                   | true      | false    | GPU Quota for the Project |
| clusterUuid                 | string, , object id      | true      | false    | An ID for a __Cluster__ object. |
| nodeAffinity                | object                   | false     | false    | Node Affinity Object. Default is no affinity | 
| permissions                 | array of User ID strings | true      | false    | An array of IDs of __User__ objects. Requires Researcher authentication to be enabled | 
| interactiveJobTimeLimitSecs | integer                  | false     | false    | Timeout for interactive sessions. Default is none | 
| allowOverQuota              | boolean                  | false     | false    | Allow the Project to go over-quota with Training Job. Default is false  | 


Node Affinity:

| Name                        | Type                | Mandatory | Description  |  
| :-------------              |:------------------- | :-------- | :----------- |
| train                       | Affinity Type       | false     | Scheduling training Jobs to specific Node Group Types |
| interactive                 | Affinity Type       | false     | Scheduling interactive Jobs to specific Node Group Types |


Node Affinity Type:

| Name                        | Type                | Mandatory | Description  |  
| :-------------              |:------------------- | :-------- | :----------- |
| affinityType                | string              | true      | "only_selected" \| "no_limit"  |
| selectedTypes               | Array of ("id" : `Node Group Types object id` XXX ) pairs    | true | Node Group Types to use |


__Example__

``` json
{
  "name": "team-c",
  "id": 386,
  "tenantId": 3,
  "clusterUuid": "9e110487-6973-4058-7c95-e07f26b835a8",
  "departmentId": 123,
  "deservedGpus": 1,
  "nodeAffinity": {
    "train": {
      "affinityType": "only_selected",
      "selectedTypes": [
        {
          "id": 21
        },
        {
          "id": 22
        }
      ]
    },
    "interactive": {
      "affinityType": "no_limit",
      "selectedTypes": []
    }
  },
  "permissions": {
    "users": [
      "auth0|5f0c50524085060013038db4"
    ]
  },
  "interactiveJobTimeLimitSecs": null,
  "allowOverQuota": true
}
```



## Create Project

`POST  https://app.run.ai/v1/k8s/project/{project_id}`

Create a new Project in a Cluster.

__Example__ (verified)

``` shell
curl -X POST https://app.run.ai/v1/k8s/project/ \
-H 'content-type: application/json' \
-H 'authorization: Bearer <Bearer>' \
--data '{
    "name":"team-i",
    "departmentId":123,
    "deservedGpus":1,
    "clusterUuid":"9e110487-6973-4058-9c95-f07f26b835a8",
    "permissions":{"users":[]}}'
```

__Example Response__

``` json
{
  "name": "team-i",
  "id": 386,
  "tenantId": 3,
  "clusterUuid": "9e110487-6973-4058-9c95-f07f26b835a8",
  "createdAt": "2021-01-05T13:59:29.814Z",
  "departmentId": 123,
  "deservedGpus": 1,
  "permissions": {
    "users": []
  },
  "maxAllowedGpus": 1 XXX
}
```



## Get Project [NOT WORKING]

`GET https://app.run.ai/v1/k8s/project/{project_id}`

Returns a Project object. 


___Example___

``` shell
curl 'https://app.run.ai/v1/k8s//project/383' \
  -H 'authorization: Bearer <Bearer>' \
  -H 'content-type: application/json' 
```

__Example Response__

``` JSON
{   

}
```

## Update Project


`PUT https://app.run.ai/v1/k8s/project/{project_id}`

Update an existing Project.

!!! Important
    The Update API expects all Project fields. Fields that are ommited will be removed from the object.

__Example__ (verified)

``` json
curl -X PUT 'https://app.run.ai/v1/k8s/project/376' \
-H 'content-type: application/json' \
-H 'authorization: Bearer <bearer>' \
 --data '{
  "name":"team-c",
  "clusterUuid":"9e110487-6973-4058-9c95-f07f26b835a8",
  "deservedGpus": 2,
  "departmentId":123,
  "permissions":{"users":["auth0|5f0c50524085060013038db4"]}
}' 
```

__Example Response__

``` json
{
  "tenantId": 3,
  "id": "376",
  "name": "team-c",
  "clusterUuid": "9e110487-6973-4058-9c95-f07f26b835a8",
  "deservedGpus": 2,
  "departmentId": 123,
  "permissions": {
    "users": [
      "auth0|5f0c50524085060013038db4"
    ]
  },
  "maxAllowedGpus": 10 XXX
}
```



## Delete Project


`DELETE https://app.run.ai/v1/k8s/project/{project_id}`



__Example__ (verified)

``` shell
curl -X 'DELETE' 'https://app.run.ai/v1/k8s/project/389' \
  -H 'authorization: Bearer <bearer>' 
```

__Example Response__

```
Project with id 389 is deleted
```


## Get List of Projects

` GET https://app.run.ai/v1/k8s/clusters/{cluster_uuid}/projects`

__Example__

``` shell
curl 'https://app.run.ai/v1/k8s/clusters/9e110487-6973-4058-9c95-f07f26b835a8/projects' \
  -H 'authorization: Bearer <bearer>' \
  -H 'content-type: application/json' 
  ```

  __Example Response__

``` json
[
  {
    "clusterUuid": "9e110487-6973-4058-9c95-f07f26b845a8",
    "createdAt": "2021-01-05T12:00:25.550Z",
    "deservedGpus": 1,
    "maxAllowedGpus": -1,
    "id": 383,
    "name": "team-f",
    "tenantId": 3,
    "departmentId": 123,
    "interactiveJobTimeLimitSecs": null,
    "nodeAffinity": {
      "train": {
        "affinityType": "no_limit",
        "selectedTypes": []
      },
      "interactive": {
        "affinityType": "no_limit",
        "selectedTypes": []
      }
    },
    "departmentName": "default",
    "permissions": {
      "users": []
    },
    "allowOverQuota": true
  },
  {
    "clusterUuid": "9e110487-6973-4058-9c95-f07f26b835a6",
    "createdAt": "2021-01-05T11:51:29.953Z",
    "deservedGpus": 1,
    "maxAllowedGpus": -1,
    "id": 377,
    "name": "team-b",
    "tenantId": 3,
    "departmentId": 123,
    "interactiveJobTimeLimitSecs": null,
    "nodeAffinity": {
      "train": {
        "affinityType": "only_selected",
        "selectedTypes": [
          {
            "id": 22,
            "name": "gpu2"
          },
          {
            "id": 21,
            "name": "gpu1"
          }
        ]
      },
      "interactive": {
        "affinityType": "no_limit",
        "selectedTypes": []
      }
    },
    "departmentName": "default",
    "permissions": {
      "users": []
    },
    "allowOverQuota": true
  }
]
```