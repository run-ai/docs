
# Compute resource introduction

A compute resource is a mandatory building block for the creation of a workspace (See also [Create Compute resource](#xxx)). 

This building block represents a resource request to be used by the workspace (for example 0.5 GPU, 8 cores and 200 [Mb] of CPU memory). When a workspace is activated, the scheduler looks for a node that answers that request.
 
 A request is composed of the following resources: 

* GPU resources
* CPU memory resources
* CPU cores resources

!!! Note
    GPU resources can be requested as either memory request, full GPU request or fraction of GPU. A fraction of a GPU supports the selection of a dynamic MIG profile (if it is supported in the cluster, relevant for A100-40GB, A100-80GB and H100)


![](images/compute-form.png)

