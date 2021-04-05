# Deleting a Cluster Installation


## Find the current Run:AI cluster version

To find the current version of the Run:AI cluster, run:

```
kubectl get deployment -n runai runai-operator -o yaml \
    -o jsonpath='{.spec.template.spec.containers[*].image}'
```


## Delete Run:AI Software

### Delete a Version 1.X Cluster 

```
runai-adm uninstall
```

The command will __not__ delete existing Jobs submitted by users. 


### Delete a Version 2.X Cluster 

To delete a Run:AI Cluster installation while retaining existing running jobs, run the following command:

``` 
helm delete runai-cluster -n runai
```

The command will __not__ delete existing Jobs submitted by users. 

