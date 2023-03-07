## Description

Submit a distributed Pytorch training run:ai job of execution.

!!! Note
    To use distributed training you need to have installed the < insert pytorch operator here > as specified < insert pre-requisites link here >.

Syntax notes:

* Options with a value type of *stringArray* mean that you can add multiple values. You can either separate values with a comma or add the flag twice.

## Examples

< add examples here>

## Options

### Distributed

#### --clean-pod-policy < string >

>Set clean pod policy: all, running or none

#### --max-replicas < int >

> Maximum number of replicas for elastic PyTorch job.

#### --min-replicas < int >

> Minimum number of replicas for elastic PyTorch job.

#### --non-preemptible

> Resources for non-preemptible jobs are guaranteed and will not be reclaimed at any time

#### --replicas < int>

> Number of replicas for Inference jobs

--8<-- "docs/snippets/common-submit-cli-commands.md"

## Output

The command will attempt to submit an _mpi_ Job. You can follow up on the Job by running `runai list jobs` or `runai describe job <job-name>`.

## See Also

< please let me know if this is needed, or if additional documentation is needed in the link >
*   See Quickstart document [Running Distributed Training](../Walkthroughs/walkthrough-distributed-training.md).
