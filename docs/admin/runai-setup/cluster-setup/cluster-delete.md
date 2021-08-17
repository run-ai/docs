# Deleting a Cluster Installation


## Find the current Run:AI cluster version

To find the current version of the Run:AI cluster, run:

```
kubectl get deployment -n runai runai-operator -o yaml \
    -o jsonpath='{.spec.template.spec.containers[*].image}'
```


## Delete Run:AI Software


To delete a Run:AI Cluster installation while retaining existing running jobs, run the following commands:

``` 
kubectl delete RunaiConfig runai -n runai
helm delete runai-cluster -n runai --no-hooks
```

The command will __not__ delete existing Jobs submitted by users. 

