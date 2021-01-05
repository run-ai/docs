# Departments

Create, Update Delete, Get and List Run:AI Departments.

XXXX



## ****  INTERNAL API ISSUES 
``` 
* Create User is not returning any response (except 200 I guess).  its inconsistent with projects, departments etc which return the object itself.  At least want the User ID returned so I can use it for further manipulation
* Not seeing a user-get

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



## Create User

`POST  https://app.run.ai/v1/k8s/department/`

Create a new Department in a Cluster.

__Example__  

``` shell
curl -X POST https://app.run.ai/v1/k8s/users/ \
-H 'content-type: application/json' \
-H 'authorization: Bearer <Bearer>' \
--data '{
  "roles": [
    "editor",
    "admin"
  ],
  "permittedClusters": [],
  "name": "",
  "password": "password123!",
  "email": "john@acme.com",
  "permitAllClusters": true,
  "needToChangePassword": true
}'
```

__Example Response__

``` json
None
```



## Get User

`GET https://app.run.ai/v1/k8s/user/{department_id}`

Returns a Department object. 

__Example__

``` shell
curl 'https://app.run.ai/v1/k8s/department/118' \
  -H 'authorization: Bearer <Bearer>' \
  -H 'content-type: application/json' 
```

__Example Response__

``` JSON
xxx
```

## Update User

`PUT https://app.run.ai/v1/k8s/department/{user_id}`

Update an existing User.

!!! Important
    The Update API expects editable User fields. Fields that are omitted will be removed from the object.

__Example__ 



``` json
curl -X PUT 'https://app.run.ai/v1/k8s/user/auth0%7C5ff4bf09f2243e0069dac63d' \
-H 'content-type: application/json' \
-H 'authorization: Bearer <bearer>' \
 --data '{
  "roles": [
    "admin",
    "editor",
    "researcher"
  ],
  "permittedClusters": [],
  "userId": "auth0|5ff4bf09f2243e0069dac63d",
  "email": "gevalt@run.ai",
  "permitAllClusters": true
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


## Get List of Users

` GET https://app.run.ai/v1/k8s/users'`

__Example__

``` shell
curl 'https://app.run.ai/v1/k8s/users' \
  -H 'authorization: Bearer <bearer>' 
```

__Example Response__ 

``` json
[
  {
    "userId": "auth0|5d5e553d4a43940c966d1b36",
    "email": "john@acme.com",
    "roles": [
      "researcher"
    ],
    "permittedClusters": [
      "2f6c8d5f-f4db-4fd5-8ac8-fa37b00ec5bc"
    ],
    "permitAllClusters": false,
    "lastLogin": "2021-01-05T17:45:53.797Z",
    "createdAt": "2019-08-22T08:41:33.382Z"
  },
  {
    "userId": "auth0|5d627ae4690ca80de78a2f6d",
    "email": "jill@acme.come",
    "roles": [
      "admin",
      "editor"
    ],
    "permittedClusters": [],
    "permitAllClusters": true,
    "lastLogin": "2021-01-05T15:09:22.729Z",
    "createdAt": "2019-08-25T12:11:16.507Z"
  }
]
```

-

GET

curl 'https://staging.run.ai/v1/k8s/users/auth0%7C5ff4bf09f2243e0069dac63c' \
-H 'authorization: Bearer eyJhbGciOiJSUzI1NiIsIpuMDFS51bUNNULPOAaaNKwURwYgvM5tWACw50rcKciDreTVXFHwsQ-pvpW3nmwiMYqw1HwMi4EjBSTddvhRAcYHTB01uPAq4tbzF6VimK01EpXht_eKmMKRakztZ0LMb8icP9g436EzfvhVGRwlfguE6MV8XHINhSEAtJNj9tcp_M-Jp9DoXrMH1NvRI4quZi34lBxbQ' \
  -H 'content-type: application/json' 

----
  

  ----
  curl 'https://staging.run.ai/v1/k8s/users/auth0%7C5ff4bf09f2243e0069dac63c' \
  -X 'PUT' \
  -H 'authority: staging.run.ai' \
  -H 'sec-ch-ua: "Google Chrome";v="87", " Not;A Brand";v="99", "Chromium";v="87"' \
  -H 'authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik1qRTNNakE1TUVVM01FSkZNRGRFUVVSRE9ERkZSRUUwTXpJMFJrUkRNekE0UXpFek1qQTRNZyJ9.eyJodHRwczovL215YMKRakztZ0LMb8icP9g436EzfvhVGRwlfguE6MV8XHINhSEAtJNj9tcp_M-Jp9DoXrMH1NvRI4quZi34lBxbQ' \
  -H 'content-type: application/json' \
  --data '{
  "roles": ["admin", "editor"],
  "permittedClusters": [],
  "userId": "auth0|5ff4bf09f2243e0069dac63c",
  "email": "gevalt@run.ai",
  "permitAllClusters": true
}' 

  response
  {"success":true}


  -----

  curl 'https://staging.run.ai/v1/k8s/users/auth0%7C5ff4bf09f2243e0069dac63c' \
  -X 'DELETE' \
  -H 'authority: staging.run.ai' \
  -H 'sec-ch-ua: "Google Chrome";v="87", " Not;A Brand";v="99", "Chromium";v="87"' \
  -H 'authorization: Bearer eyJhbGciOiJSUzI1NiIwlfguE6MV8XHINhSEAtJNj9tcp_M-Jp9DoXrMH1NvRI4quZi34lBxbQ' \
  -H 'dnt: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36' \
  -H 'content-type: application/json' \
  -H 'accept: */*' \
  -H 'origin: https://staging.run.ai' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://staging.run.ai/users?sortBy=%5B%7B%22key%22%3A%22email%22,%22direction%22%3A%22asc%22%7D%5D&query=gev&page=1&items_per_page=20' \
  -H 'accept-language: en-US,en;q=0.9,he;q=0.8' \
  -H 'cookie: _ga=GA1.2.2145129639.1609412678; _gid=GA1.2.1492072844.1609602361; auth0.ssodata=%22{%5C%22lastUsedConnection%5C%22:%5C%22Username-Password-Authentication%5C%22%2C%5C%22lastUsedSub%5C%22:%5C%22auth0|5d5e553d4a43940c966d1b36%5C%22}%22' \
  --compressed

response
{"success":true}
