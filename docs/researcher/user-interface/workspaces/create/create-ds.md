# Create a new data source

When you select `New Compute Resource` you will be presented with various data source options described below.

## Create an NFS data source

To create an NFS data source, provide:

* A data source name
* A Run:ai project scope
* An NFS server 
* The path to the data within the server. 
* The path within the container where the data will be mounted.

The data can be set as read-write or limited to read-only permission regardless of any other user privileges. 

## Create a PVC data source

To create an PVC data source, provide:

* A data source name
* A Run:ai project scope
* Select an existing PVC or create a new one by providing a claim name, a storage class, access mode, and a required storage size. 
* The path within the container where the data will be mounted.

## Create an S3 data source

S3 storage saves data in _buckets_. S3 is typically attributed to AWS cloud service but can also be used as a separate service unrelated to Amazon. 

To create an S3 data source, provide

* A data source name
* A Run:ai project scope
* The relevant S3 service URL server
* The bucket name of the data. 
* The path within the container where the data will be mounted.

Note that an S3 data source can be public or private. For the latter option, please select the relevant credentials associated with the project to allow access to the data.

## Create a Git data source

To create a Git data source, provide:

* A data source name
* A Run:ai project scope
* The relevant repository URL. 
* The path within the container where the data will be mounted.

The Git data source can be public or private. To allow access to a private Git data source, you must select the relevant credentials associated with the project. 

## Create a host path data source

To create a host path data source, provide:

* A data source name
* A Run:ai project scope
* The relevant path on the host. 
* The path within the container where the data will be mounted.

Note that the data can be limited to read-only permission regardless of any other user privileges. 


