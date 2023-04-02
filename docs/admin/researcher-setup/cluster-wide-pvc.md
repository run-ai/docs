# Cluster wide PVCs

:octicons-versions-24: Version 2.10 and later.

A PersistentVolumeClaim (PVC) is a request for storage by a user. It is similar to a Pod. Pods consume node resources and PVCs consume PV resources. Pods can request specific levels of resources (CPU and Memory). Claims can request specific size and access modes. For more information about PVCs, see [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/){targe=_blank}.

PVCs are namespace-specific. If your PVC relates to all run:ai Projects, do the following to propagate the PVC to all Projects:

Create a PVC within the run:ai namespace, then run the following once to propagate the PVC to all run:ai Projects:

```
kubectl label persistentvolumeclaims -n runai <PVC_NAME> runai/cluster-wide=true
```

To delete a PVC from all run:ai Projects, run:

```
kubectl label persistentvolumeclaims -n runai <PVC_NAME> runai/cluster-wide-
```

You can add a PVC to a job using the `New job` form.

To add a PVC to a new job:

1. On the `New job` form, press `Storage`.
2. In `Persistent Volume Claims` press `Add`.
3. Enable `Existing PVC`.
4. Enter the name (claim name) of the PVC.
5. Enter the storage class. (Optional)
6. Enter the size.
7. Enable / disable access modes.