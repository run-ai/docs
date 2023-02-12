
# Compute resource introduction


A _compute_ resource building block represents a resource request to be used by the workspace (for example 0.5 GPU, 8 cores and 200 Megabytes of CPU memory). When a workspace is activated, the scheduler looks for a node that can fullfil the request. 

The compute resource is a __mandatory__ building block for Workspace. A request is composed of the following resources: 

* GPU resources
* CPU memory resources
* CPU cores resources

![](img/7-compute-form.png)


!!! Note
    GPU resources can be requested as either a memory request, a full GPU request or a [fraction of a GPU](../../../scheduling/fractions.md#runai-fractions). A fraction of a GPU also supports the selection of a dynamic [MIG profile](../../../scheduling/fractions.md#dynamic-mig) if configured


## See Also

* Create a [Compute resource](../create/create-compute.md). 