
# Compute resource introduction

A compute resource is a mandatory building block for the creation of a workspace (See also [Create Compute resource](#xxx)). 

This building block represents a resource request to be used by the workspace (for example 0.5 GPU, 8 cores & 200 [Mb] of CPU memory). When a workspace is activated, the scheduler looks for a node that answers that request. 
 
 A request is composed of one or more of the following resources: 

* GPU resources
* CPU memory resources
* CPU cores resources


![](images/compute-form.png)


When a compute resource is created, its scope of relevancy can be set to be of a specific single project (e.g. “Project A”) or of the entire Tennant, which results in scope relevancy of all projects (current projects and also any future ones).


![](images/proj-selection.png)


To reduce noise and increase context, data scientists can view & use only environments that are in their scope of relevancy.


![](images/compute-resource-grid.png)
