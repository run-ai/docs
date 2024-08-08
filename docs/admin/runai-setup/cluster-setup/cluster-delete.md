# Deleting a Cluster Installation

To delete a Run:ai Cluster installation, run the following commands:

```
helm uninstall runai-cluster -n runai
```
The command does **not** delete existing Projects, Departments or Workloads sumbitted by users.
