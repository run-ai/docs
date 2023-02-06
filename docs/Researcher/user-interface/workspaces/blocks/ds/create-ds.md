# Creating a new data source

## Creating a NFS data source

In order to create an NFS data source you need to point out the relevant NFS server as well as the path to the data. Then to point out the data target location as a container path.

Note that the data can be limited to read-only permission regardless to any other user privileges. 

## Creating a pvc (?) data source


## Creating an S3 data source
In order to create an S3 data source (either by AWS or not) you need to point out the relevant S3 service URL server as well as the bucket name of the data. Then to point out the data target location as a container path.

Note that S3 data source can be public or private. For the latter option, please select the relevant credential associated with the project in order to allow access to the data.

## Creating a git data source
In order to create a git data source you need to point out the relevant repository URL. Then to point out the data target location as a container path.

Note that git data source can be public or private. For the latter option, please select the relevant credential associated with the project in order to allow access to the data.

## Creating a host path data source
In order to create a host path data source you need to point out the relevant path. Then to point out the data target location as a container path.

Note that the data can be limited to read-only permission regardless to any other user privileges. 


