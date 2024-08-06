# Deleting a Cluster Installation

To delete a Run:ai Cluster installation while retaining existing running jobs, run the following commands:

```
helm uninstall runai-cluster -n runai
```

The commands will **not** delete existing Jobs submitted by users.
