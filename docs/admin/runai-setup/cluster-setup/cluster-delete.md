# Deleting a Cluster Installation


To delete a Run:AI Cluster installation while retaining existing running jobs, run the following commands:

``` 
kubectl delete RunaiConfig runai -n runai
helm delete runai-cluster -n runai --no-hooks
```

The commands will __not__ delete existing Jobs submitted by users. 

