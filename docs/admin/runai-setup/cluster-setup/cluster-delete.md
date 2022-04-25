# Deleting a Cluster Installation


To delete a Run:ai Cluster installation while retaining existing running jobs, run the following commands:

``` 
kubectl patch RunaiConfig runai -n runai -p '{"metadata":{"finalizers":[]}}' --type="merge"
kubectl delete RunaiConfig runai -n runai
helm delete runai-cluster runai -n runai
```

The commands will __not__ delete existing Jobs submitted by users. 

