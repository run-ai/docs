
# Uninstall Run:AI Backend 


## Delete a Cluster
To delete the cluster use: [../../runai-setup/cluster-setup/cluster-delete/](../../runai-setup/cluster-setup/cluster-delete/) 


## Uninstall Backend

To delete the backend, run:

``` shell
helm delete runai-backend -n runai-backend

```

For a full delete also delete namespace and images as follows:

```
kubectl delete ns runai-backend
sudo docker rmi -f $(sudo docker images -a -q)
```


