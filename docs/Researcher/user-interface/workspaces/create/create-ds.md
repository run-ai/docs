# Create a new data source

When you select `New Compute Resource` you will be presented with various data source options described below.

## Create an NFS data source

To create an NFS data source, provide:

* A data source name.
* A Run:ai project scope which is assigned to that item and all its subsidiaries.
* An NFS server.
* The path to the data within the server.
* The path within the container where the data will be mounted.

The data can be set as read-write or limited to read-only permission regardless of any other user privileges.

## Create a PVC data source

To create an PVC data source, provide:

* A data source name
* A Run:ai project scope which is assigned to that item and all its subsidiaries.
* Select an existing PVC or create a new one by providing:

    * A claim name
    * A storage class
    * Access mode
    * Required storage size
    * Volume system mode

* The path within the container where the data will be mounted.

You can see the status of the resources created in the [Data sources table](#data-sources-table).

## Create an S3 data source

S3 storage saves data in *buckets*. S3 is typically attributed to AWS cloud service but can also be used as a separate service unrelated to Amazon.

To create an S3 data source, provide

* A data source name
* A Run:ai project scope which is assigned to that item and all its subsidiaries.
* The relevant S3 service URL server
* The bucket name of the data.
* The path within the container where the data will be mounted.

An S3 data source can be public or private. For the latter option, please select the relevant credentials associated with the project to allow access to the data. S3 buckets that use credentials will have a status associated with it. For more information, see [Data sources table](#data-sources-table).

## Create a Git data source

To create a Git data source, provide:

* A data source name.
* A Run:ai project scope which is assigned to that item and all its subsidiaries.
* The relevant repository URL.
* The path within the container where the data will be mounted.

The Git data source can be public or private. To allow access to a private Git data source, you must select the relevant credentials associated with the project. Git data sources that use credentials will have a status associated with it. For more information, see [Data sources table](#data-sources-table).

## Create a host path data source

To create a host path data source, provide:

* A data source name.
* A Run:ai project scope which is assigned to that item and all its subsidiaries.
* The relevant path on the host.
* The path within the container where the data will be mounted.

!!! Note
    The data can be limited to read-only permission regardless of any other user privileges.

## Create a ConfigMap data source

* A Run:ai project scope which is assigned to that item and all its subsidiaries.
  
    !!! Note
        You can only choose a project as a scope.

* A data source name.
* A data mount consisting of:
    * A ConfigMap name&mdash;select from the drop down.
    * A target location&mdash;the path to the container.

## Data sources table

The *Data sources* table contains a column for the status of the data source. The following statuses are supported:

| Status |  Description |
| -- | -- |
| **No issues found** | No issues were found when propagating the data source to the *PROJECTS*. |
| **Issues found** | Failed to create the data source for some or all of the *PROJECTS*. |
| **Issues found** | Failed to access the cluster. |
| **Deleting** | The data source is being removed. |

!!! Note

    * The *Status* column in the table shows statuses based on your level of permissions. For example, a system administrator will see status that are calculated from the entire scope, while researchers will only be able to see statuses that from a subset of the scope (assets that they have permissions to).
    * The status of “-” indicates that there is no status because this asset is not cluster-syncing.

You can download the Data Sources table to a CSV file. Downloading a CSV can provide a snapshot history of your Data Sources over the course of time, and help with compliance tracking. All the columns that are selected (displayed) in the table will be downloaded to the file.

To download the Data Sources table to a CSV:

1. Open *Data Sources*.
2. From the *Columns* icon, select the columns you would like to have displayed in the table.
3. Click on the ellipsis labeled *More*, and download the CSV.
