

## Introduction

When the Run:ai scheduler schedules Jobs, it can use two alternate *placement strategies*:

| Strategy    | Description |
|-------------|-------------|
| Bin Packing | Fill up a GPU or CPU and/or a node before moving on to the next one |
| Spreading   | Equally spread Jobs amongst GPUs, CPUs and nodes |

## Bin Packing

Bin packing is the default strategy. With bin packing, the scheduler tries to:

* Fill up a node (GPUSs or CPUs) with Jobs before allocating Jobs to second and third nodes.
* In a multi GPU node, when using [fractions](fractions.md), fill up a GPU before allocating Jobs to a second GPU.

The advantage of this strategy is that the scheduler, over time, can package more Jobs into the cluster. As the strategy minimizes fragmentation.

In a GPU node, for example, if we have 2 GPUs in a single node on the cluster, and 2 tasks requiring 0.5 GPUs each, using bin-packing, we would place both Jobs on the same GPU and remain with a full GPU ready for the next Job.

In a CPU node, for example, if we have 4 CPUs in a single node on the cluster, and 2 tasks requiring 1 CPU each, using bin-packing, we would place both Jobs on the same node and still have more capacity for the next Job.

## Spreading

There are disadvantages to bin-packing:

* Within a single GPU, two fractional Jobs compete for the same onboard compute power.
* Within a single node, two Jobs (even on separate GPUs) compete for networking resources, compute power and memory.

When there are more resources available than requested, it sometimes makes sense to spread Jobs amongst nodes and GPUs, to allow higher utilization of computing resources and network resources.

Returning to the example above, if we have 2 GPUs in a single node on the cluster, and 2 Jobs requiring 0.5 GPUs each, using spread scheduling we would place each Job on a separate GPU, allowing both to benefit from the computing power of a full GPU.

## Changing Scheduler Strategy

The strategy affects the entire cluster. To change the strategy run:

``` 
kubectl edit runaiconfig -n runai
```

Find `runai-scheduler` then add one of the following options, where <STRATEGY_VALUE> is either `Bin Packing` or `Spreading`.

Use this option for both CPUs and GPUs.

```yaml
runai-scheduler:
  placementStrategy: <STRATEGY_VALUE>
```

Use this option if you would like to have the scheduling strategy be applied to GPUs and CPUs separately.

```yaml
runai-scheduler:
  gpuPlacementStrategy: <STRATEGY_VALUE>
  cpuPlacementStrategy: <STRATEGY_VALUE>
```

!!! Note
    It is not recommended to combine `placementStrategy` with `gpuPlacementStrategy` and `cpuPlacementStrategy`.
