Data volumes offer a powerful solution for storing, managing, and sharing AI training data within the NVIDIA Run:ai platform. They promote collaboration, simplify data access control, and streamline the AI development lifecycle.

Acting as a central repository for organizational data resources, data volumes can represent datasets or raw data, that is stored in Kubernetes Persistent Volume Claims (PVCs).

## Why use a data volume?

1.  Sharing with multiple scopes  
    Unlike other Run:ai data sources, data volumes can be shared across projects, departments, or clusters, encouraging data reuse and collaboration within the organization.
2.  Storage saving  
    A single copy of the data can be used across multiple [scopes](./overview.md#asset-scope)

## Typical use cases

1.  Sharing large data sets  
    In large organizations, the data is often stored in a remote location, which can be a barrier for large model training. Even if the data is transferred into the cluster, sharing it easily with multiple users is still challenging. Data volumes can help share the data seamlessly, with maximum security and control.
2.  Sharing data with colleagues  
    When sharing training results, generated data sets, or other artifacts with team members is needed, data volumes can help make the data available easily.

![data-volumes-architecture](img/data-volumes-arch.svg)

### Prerequisites

To create a data volume, there must be a [project](../../../platform-admin/aiinitiatives/org/projects.md) with a PVC in its namespace.

Working with data volumes is currently available using the API. To view the available actions, go to the [Data volumes](https://api-docs.run.ai/2.18/tag/Datavolumes){target=_blank} API reference.

## Adding a new data volume

Data volume creation is limited to [specific roles](./overview.md#who-can-create-an-asset)

## Adding scopes for a data volume

Data volume sharing (adding scopes) is limited to [specific roles](./overview.md#who-can-create-an-asset)

Once created, the data volume is available to its originating project (see the prerequisites above).

Data volumes can be shared with additional scopes in the organization.

## Who can use a data volume?

Data volumes are used when [submitting workloads](../../../platform-admin/workloads/overviews/managing-workloads.md#adding-new-workload). Any user, application or SSO group with a [role](../../../platform-admin/authentication/roles.md) that has permissions to create workloads can also use data volumes.

Researchers can list available data volumes within their permitted scopes for easy selection.


