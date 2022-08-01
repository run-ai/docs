

## Introduction

When the Run:ai scheduler schedules Jobs, it has to alternate _placement strategies_:

| Strategy    | Description | 
|-------------|-------------|
| Bin Packing | Fill up a GPUs and fill up a node before moving on to the next one | 
| Spreading   | Equally spread Jobs amongst GPUs and nodes | 


## Bin Packing

Bin packing is the default strategy. With bin packing, the scheduler tries to:

* Fill up a node with Jobs before allocating Jobs to second and third nodes.
* In a multi GPU node, when using [fractions](fractions.md), fill up a GPU before allocating Jobs to a second GPU. 

The advantage of this strategy is that it provides an optimum in the sense that the scheduler can package more Jobs into a cluster. The strategy minimizes fragmentation. 

For example, if we have 2 GPUs in a single node on the cluster, and 2 tasks requiring 0.5 GPUs each, using bin-packing, we would place both Jobs on the same GPU and remain with a full GPU ready for the next Job. 

## Spreading

There are disadvantages to bin-packing: 

* Within a single GPU, two fractional Jobs compete for the same onboard CPUs. 
* Within a single node, two Jobs compete for networking resources. 

When there are more resources available than requested, it sometimes makes sense to spread Jobs amongst nodes and GPUs, to allow higher utilization of CPU and network resources. 

Returning to the example above, if we have 2 GPUs in a single node on the cluster, and 2 Jobs requiring 0.5 GPUs each, using spread scheduling we would place each Job on a separate GPU, allowing both to benefit from CPU computing power of a full GPU.

## Changing Scheduler Strategy

The strategy affects the entire cluster. To change the strategy run:

``` 
kubectl edit runaiconfig -n runai
```

Find `runai-scheduler' and add:

```
runai-scheduler:
  placementStrategy: spread
```
