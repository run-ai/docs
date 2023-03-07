# Cluster wide PVCs

A PersistentVolumeClaim (PVC) is a request for storage by a user. It is similar to a Pod. Pods consume node resources and PVCs consume PV resources. Pods can request specific levels of resources (CPU and Memory). Claims can request specific size and access modes. For more information about PVCs, see [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/){targe=_blank}.

Pvcs are namespace-specific. If your PVC relates to all run:ai Projects, do the following to propagate the PVC to all Projects:

Create a PVC within the run:ai namespace, then run the following once to propagate the PVC to all run:ai Projects:

```
kubectl label persistentvolumeclaims -n runai <PVC_NAME> runai/cluster-wide=true
```

!!! Reminder
    To install the run:ai Administrator CLI, see [Install the Run:ai Administrator Command-line Interface](../runai-setup/config/cli-admin-install.md).

To delete a PVC from all run:ai Projects, run:

```
kubectl label persistentvolumeclaims -n runai <PVC_NAME> runai/cluster-wide-
```
