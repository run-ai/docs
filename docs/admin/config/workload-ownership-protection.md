
## Workload Deletion Protection

Workload deletion protection in Run:ai ensures that only users who created a workload can delete or modify them. This feature is designed to safeguard important jobs and configurations from accidental or unauthorized modifications by users who did not originally create the workload.

By enforcing ownership rules, Run:ai helps maintain the integrity and security of your machine learning operations. This additional layer of security ensures that only users with the appropriate permissions can delete and suspend workloads.

The protection feature is implemented at the cluster level.

To enable deletion protection run the following command:

```
kubectl patch -n runai runaiconfigs.run.ai/runai --type='merge' --patch '{"spec":{"global":{"enableWorkloadOwnershipProtection":true}}}'
```
