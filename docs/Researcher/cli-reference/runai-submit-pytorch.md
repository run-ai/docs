## Description

Submit a distributed Pytorch training run:ai job to run.

!!! Note
    To use distributed training you need to have installed the < insert pytorch operator here > as specified < insert pre-requisites link here >.

Syntax notes:

* Options with a value type of *stringArray* mean that you can add multiple values. You can either separate values with a comma or add the flag twice.

## Examples

```console
runai submit-pytorch --name distributed-job --replicas=2 -g 1 \
	-i gcr.io/run-ai-demo/quickstart-distributed
```

## Options

### Distributed

#### --clean-pod-policy < string >

> The CleanPodPolicy controls deletion of pods when a job terminates. The policy can be one of the following values:
>
>* **Running**&mdash;only pods still running when a job completes (for example, parameter servers) will be deleted immediately. Completed pods will not be deleted so that the logs will be preserved. (Default)
>* **All**&mdash;all (including completed) pods will be deleted immediately when the job finishes.
>* **None**&mdsh;no pods will be deleted when the job completes.

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
