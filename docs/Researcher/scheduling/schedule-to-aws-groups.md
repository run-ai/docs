# Scheduling workloads to AWS placement groups

Run:ai supports AWS placement groups when building and submitting a job. AWS [Placement Groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html){targe=_blank} are used to maximize throughput and performance of distributed training workloads.

To enable and configure this feature:

1. Press `Jobs | New job`.
2. In `Scheduling and lifecycle` enable the `Topology aware scheduling`.
3. In `Topology key`, enter the label of the topology of the node.
4. In `Scheduling rule` choose `Required` or `Preferred` from the drop down.

    - `Required`&mdash;when enabled, all PODs ***must*** be scheduled to the same placement group.
    - `Preferred`&mdash;when enabled, this is a best-effort, to place as many PODs on the same placement group.
