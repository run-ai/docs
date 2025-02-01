# workload-assets

Run:ai [workload](../../docs/workloads-in-runiai/overviews/introduction-to-workloads.md) assets are preconfigured building blocks that simplify the workload submission effort and remove the complexities of Kubernetes and networks for AI practitioners.

Workload assets enable organizations to:

* Create and reuse preconfigured setup for code, data, storage and resources to be used by AI practitioners to simplify the process of submitting workloads
* Share the preconfigured setup with a wide audience of AI practitioners with similar needs

!!! Note

```
* The creation of assets is possible only via API and the Run:ai UI  
* The submission of workloads using assets, is possible only via the Run:ai UI
```

### Workload asset types

There are four workload asset types used by the workload:

* [Environments](environments.md)\
  The container image, tools and connections for the workload
* [Data sources](datasources.md)\
  The type of data, its origin and the target storage location such as PVCs or cloud storage buckets where datasets are stored
* [Compute resources](../../docs/workloads-in-runiai/workload-assets/compute.md)\
  The compute specification, including GPU and CPU compute and memory
* [Credentials](credentials.md)\
  The secrets to be used to access sensitive data, services, and applications such as docker registry or S3 buckets

### Asset scope

When a workload asset is created, a [scope](../../platform-admin/aiinitiatives/overview.md) is required. The scope defines who in the organization can view and/or use the asset.

!!! Note When an asset is created via API, the scope can be the entire account, this is currently an experimental feature.

### Who can create an asset?

Any subject (user, application, or SSO group) with a [role](../../admin/authentication/roles.md) that has permissions to Create an asset, can do so within their scope.

### Who can use an asset?

Assets are used when submitting workloads. Any subject (user, application or SSO group) with a [role](../../admin/authentication/roles.md) that has permissions to Create workloads, can also use assets.

### Who can view an asset?

Any subject (user, application, or SSO group) with a [role](../../admin/authentication/roles.md) that has permission to View an asset, can do so within their scope.
