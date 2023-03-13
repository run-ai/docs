## Description

Submit a Distributed Training (MPI) Run:ai Job to run.

!!! Note
    To use distributed training you need to have installed the Kubeflow MPI Operator as specified [here](../../../admin/runai-setup/cluster-setup/cluster-prerequisites/#distributed-training-via-kubeflow-mpi)

Syntax notes:

* Options with a value type of *stringArray* mean that you can add multiple values. You can either separate values with a comma or add the flag twice.

## Examples

You can start an unattended mpi training Job of name dist1, based on Project *team-a* using a *quickstart-distributed* image:

    runai submit-mpi --name dist1 --processes=2 -g 1 \
        -i gcr.io/run-ai-demo/quickstart-distributed:v0.3.0 -e RUNAI_SLEEP_SECS=60 

(see: [distributed training Quickstart](../Walkthroughs/walkthrough-distributed-training.md)).

## Options

### Distributed

#### --clean-pod-policy < string >

> The CleanPodPolicy controls deletion of pods when a job terminates. The policy can be one of the following values:
>
>* **Running**&mdash;only pods still running when a job completes (for example, parameter servers) will be deleted immediately. Completed pods will not be deleted so that the logs will be preserved. (Default)
>* **All**&mdash;all (including completed) pods will be deleted immediately when the job finishes.
>* **None**&mdsh;no pods will be deleted when the job completes.

#### --non-preemptible

> Resources for non-preemptible jobs are guaranteed and will not be reclaimed at any time.

#### --replicas < int >

> Number of replicas for Inference jobs.

#### --slots-per-worker < int >

> Number of slots to allocate for each worker.

--8<-- "docs/snippets/common-submit-cli-commands.md"
## Output

The command will attempt to submit an _mpi_ Job. You can follow up on the Job by running `runai list jobs` or `runai describe job <job-name>`.

## See Also

*   See Quickstart document [Running Distributed Training](../Walkthroughs/walkthrough-distributed-training.md).
