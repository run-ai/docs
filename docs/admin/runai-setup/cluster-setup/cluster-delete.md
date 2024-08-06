# Deleting a Cluster Installation

To delete a Run:ai Cluster installation run the following commands:

```
helm uninstall runai-cluster -n runai
```

The commands will **not** delete existing Projects, Departments, or Workloads submitted by users.
