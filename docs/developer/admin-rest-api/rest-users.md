# Departments

Create, Update Delete, Get and List Run:AI Departments.

XXXX



## ****  INTERNAL API ISSUES 
``` 
* Create User is not returning any response (except 200 I guess).  its inconsistent with projects, departments etc which return the object itself.  At least want the User ID returned so I can use it for further manipulation
* Not seeing a user-get api
* Update user returns   {"success":true} which is inconsistent with other objects
* API uses 'users' where all the rest use singular. 

```

* ...


## JSON Format
Projects are represented as JSON objects with the following properties. All properties are mandatory.

| Name                        | Type                     | Mandatory | Read Only| Description  |  
| :-------------              |:------------------------ | :-------- | :------- | :----------- |
| userId                      | string                   | true      | true     | User ID. Automatically assigned when the User is created   |
| email                       | string                   | true      | false    | email of User.  |
| password                    | string                   | on create | -        | The name of the Project. |
| roles                       | array of strings         | false     | false    | One or more of `editor`, `admin`, `viewer`, `researcher`  |
| permittedClusters           | array of strings         | true      | false    | List of clusters that the User has access to. |
| permitAllClusters           | boolean                  | true      | false    | true if User has access to all clusters. If true, value of permittedClusters is ignored |
| lastLogin                   | date-time                | false     | true     | Last login time of user   | 
| createdAt                   | date-time                | false     | true     | Creation Date-Time. |


__Example__

``` json
{
    "userId": "auth0|5d5e553d4a43940c966d1b36",
    "email": "john@acme.com",
    "password": "password",
    "roles": [
      "researcher"
    ],
    "permittedClusters": [
      "2f6c8d5f-f4db-4fd5-8ac8-fa37b00ec5bc"
    ],
    "permitAllClusters": false,
    "lastLogin": "2021-01-05T17:45:53.797Z",
    "createdAt": "2019-08-22T08:41:33.382Z"
}
```



## Create User

`POST  https://app.run.ai/v1/k8s/users/`

Create a new User in a Tenant.

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
  "name": "",  XXX REMOVE THIS AND TRY
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



## Get User NOT WORKING

`GET https://app.run.ai/v1/k8s/user/{user_id}`

Returns a User object. 

__Parameters__

* ``user_id`` - User identifier.

__Example__

``` shell
curl '...' \
  -H 'authorization: Bearer <Bearer>' \
  -H 'content-type: application/json' 
```

__Example Response__

``` JSON
xxx
```

## Update User

`PUT https://app.run.ai/v1/k8s/users/{user_id}`

Update an existing User.

__Parameters__

* ``user_id`` - User identifier.

!!! Important
    The Update API expects editable User fields. Fields that are omitted will be removed from the object.

__Example__ 

``` json
curl -X PUT https://app.run.ai/v1/k8s/users/auth0%7C5ff4bf09f2243e0069dac63d \
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
{"success":true}
```


## Delete User


`DELETE https://app.run.ai/v1/k8s/users/{user_id}`

__Parameters__

* ``user_id`` - User identifier.

__Example__ 

``` shell
curl -X DELETE https://app.run.ai/v1/k8s/users/auth0%7C5ff4bf09f2243e0069dac63d \
  -H 'authorization: Bearer <bearer>' 
```

__Example Response__

```
{"success":true}
```


## Get List of Users

` GET https://app.run.ai/v1/k8s/users'`

__Example__

``` shell
curl https://app.run.ai/v1/k8s/users \
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
  

  