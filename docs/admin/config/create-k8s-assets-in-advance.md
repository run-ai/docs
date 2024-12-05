# Creating Kubernetes Assets in Advance

The article describe how to mark Kubernetes assets for use by Run:ai

## Creating PVCs in advance

Add PVCs in advance to be used when creating a PVC-type data source via the Run:ai UI.

Follow the steps below for each required scope:


### Cluster scope

1.  Locate the PVC in the Run:ai namespace (runai)
2.  To authorize Run:ai to use the PVC, label it: `run.ai/cluster-wide: "true”`  
    The PVC is now displayed for that scope in the list of existing PVCs.

### Department scope

1.  Locate the PVC in the Run:ai namespace (runai)
2.  To authorize Run:ai to use the PVC, label it: `run.ai/department: "id"`  
    The PVC is now displayed for that scope in the list of existing PVCs.

### Project scope

1.  Locate the PVC in the project’s namespace  
    The PVC is now displayed for that scope in the list of existing PVCs.

## Creating ConfigMaps in advance

Add ConfigMaps in advance to be used when creating a ConfigMap-type data source via the Run:ai UI.

### Cluster scope

1.  Locate the ConfigMap in the Run:ai namespace (runai)
2.  To authorize Run:ai to use the ConfigMap, label it: `run.ai/cluster-wide: "true”`
3.  The ConfigMap must have a label of `run.ai/resource: <resource-name>`

    The ConfigMap is now displayed for that scope in the list of existing ConfigMaps.

### Department scope

1.  Locate the ConfigMap in the Run:ai namespace (runai)
2.  To authorize Run:ai to use the ConfigMap, label it: `run.ai/department: "<department-id>"`  
3.  The ConfigMap must have a label of `run.ai/resource: <resource-name>`
   
    The ConfigMap is now displayed for that scope in the list of existing ConfigMaps.

### Project scope

1.  Locate the ConfigMap in the project’s namespace
2.  The ConfigMap must have a label of `run.ai/resource: <resource-name>`
   
    The ConfigMap is now displayed for that scope in the list of existing ConfigMaps.
