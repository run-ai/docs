# Create a new data source

## Create an NFS data source

To create an NFS data source you need to point out the relevant NFS server as well as the path to the data within the server. Then, select the path within the container where the data will be mounted.

The data can be set as read-write or limited to read-only permission regardless of any other user privileges. 

## Create a pvc (?) data source


## Create an S3 data source
S3 storage saves data in _buckets_. S3 is typically attributed to AWS cloud service but can also be used as a separate service unrelated to Amazon. 

To create an S3 data source, you must point out the relevant S3 service URL server as well as the bucket name of the data. Then, select the path within the container where the data will be mounted.

Note that an S3 data source can be public or private. For the latter option, please select the relevant credentials associated with the project to allow access to the data.

## Create a Git data source

To create a Git data source select the relevant repository URL. Then, select the path within the container where the data will be mounted.

The Git data source can be public or private. To allow access a private Git data source, you must select the relevant credentials associated with the project. 

## Create a host path data source

To create a host path data source you must select the relevant path on the host. Then, select the path within the container where the data will be mounted.

Note that the data can be limited to read-only permission regardless of any other user privileges. 


