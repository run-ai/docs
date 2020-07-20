## June 13th, 2020

#### New Settings for the Allocation of CPU and Memory

It is now possible to set limits for CPU and memory as well as to establish defaults based on the ratio of GPU to CPU and GPU to memory.&nbsp;

For further information see:&nbsp;<https://support.run.ai/hc/en-us/articles/360014087199-Allocation-of-CPU-and-Memory>&nbsp;

## June 3rd, 2020

#### Node Group Affinity

Projects now support _Node Affinity.&nbsp;_This feature allows the administrator to assign specific projects to run only on specific nodes (machines). Example use cases:

*   The project team needs specialized hardware (e.g. with enough memory)
*   The project team is the owner of specific hardware which was acquired with a specialized budget
*   We want to direct build/interactive workloads to work on weaker hardware and direct longer training/unattended workloads to faster nodes

For further information see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011591300-Working-with-Projects>

#### Limit Duration of Interactive Jobs

Researchers frequently forget to close Interactive jobs. This may lead to a waste of resources. Some organizations prefer to limit the duration of interactive jobs and close them automatically. For further information on how to set up duration limits see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011591300-Working-with-Projects>

## May 24th, 2020

#### Kubernetes Operators

Cluster installation now works with Kubernetes _Operators_. Operators make it easy to install, update, and delete a&nbsp; Run:AI cluster. For further information see: <https://support.run.ai/hc/en-us/articles/360013843140-Upgrading-and-Deleting-a-Run-AI-Cluster-Installation>&nbsp;

## March 3rd, 2020

#### Admin Overview Dashboard

A new admin overview dashboard which shows a more holistic view of multiple clusters. Applicable for customers with more than one cluster&nbsp;