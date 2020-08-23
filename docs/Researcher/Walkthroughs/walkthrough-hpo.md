# Walk-through: Hyperparameter Optimization

## Introduction

Hyperparameter optimization (HPO) is the process of choosing a set of optimal hyperparameters for a learning algorithm. A hyperparameter is a parameter whose value is used to control the learning process. Example hyperparameters: Learning rate, Batch size, Different optimizers, number of layers.

To search for good hyperparameters, Researchers typically start a series of small runs with different hyperparameter values, let them run for awhile and then examine the results of the runs to decide what works best.

There are a number of strategies for searching the hyperparameter space. Most notable are __Random search__ and __Grid search__. The former, as its name implies, selects parameters at random while the later does an exhaustive search from a list of pre-selected values.

Run:AI provides the ability to run, manage, and view HPO runs. The following is a walk-through of such a scenario.

## Prerequisites

To complete this walk-through you must have:

*   Run:AI software is installed on your Kubernetes cluster. See: [Installing Run:AI on an on-premise Kubernetes Cluster](../../Administrator/Cluster-Setup/cluster-install.md)
*   Run:AI CLI installed on your machine. See: [Installing the Run:AI Command-Line Interface](../../Administrator/Researcher-Setup/cli-install.md)

## Step by Step Walk-through

### Setup

*   Open the Run:AI user interface at [app.run.ai](https://app.run.ai)
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

### Pods

With HPO, we introduce the concept of __Pods__. Pods are units of work within a Job. 

* Typically, each Job has a single Pod. However, with HPO as well as with [Distributed Training](walkthrough-distributed-training.md) there are multiple Pods per Job. 
* Pods are independent
* All Pods execute with the same parameters as added via ``runai submit``. E.g. The same image name, the same code script, the same number of Allocated GPUs, memory.


### Run an HPO Workload

*   At the command-line run:

        runai project set team-a 
        runai submit hpo1 -i gcr.io/run-ai-demo/quickstart -g 1 --parallelism 3 --completions 10

*   We named the job _hpo1_
*   The job is assigned to _team-a_
*   The job will be complete when 10 pods will run (--completions 10), each allocated with a single GPU (-g 1)
*   At most, there will be 3 pods running concurrently (--parallelism 3)
*   The job is based on a sample docker image ``gcr.io/run-ai-demo/quickstart-xxx``. The image contains a startup script that runs selects a set of hyper parameters and then uses them. 

Where ``RUNAI_MPI_NUM_WORKERS`` is a Run:AI environment variable containing the number of worker processes provided to the runai submit-mpi command (in this example it's 2).

Follow up on the job's status by running:

        runai list

The result:

![mceclip11.png](img/mceclip11.png)

The Run:AI scheduler ensures that all processes can run together. You can see the list of workers as well as the main "launcher" process by running:

        runai get dist

You will see two worker processes (pods) their status and on which node they run:

![mceclip12.png](img/mceclip12.png)

To see the merged logs of all pods run:

        runai logs dist

Finally, you can delete the distributed training workload by running:

        runai delete dist

### Run an Interactive Distributed training Workload

It is also possible to run a distributed training job as "interactive". This is useful if you want to test your distributed training job before committing on a long, unattended training session. To run such a session use:

        runai submit-mpi dist-int --processes=2 -g 1 \ 
          -i gcr.io/run-ai-demo/quickstart-distributed  \
          --command="sh" --args="-c" --args="sleep infinity"  --interactive

When the workers are running run:

        runai bash dist-int

This will provide shell access to the launcher process. From there, you can run your distributed session. For examples, with Horovod:

        horovodrun -np 2 python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
        --model=resnet20 --num_batches=1000000 --data_name cifar10 \
        --data_dir /cifar10 --batch_size=64 --variable_update=horovod

## Next Steps

*   For more information on how to convert an interactive session into a training job, see: [Converting your Workload to use Unattended Training Execution](../best-practices/Converting-your-Workload-to-use-Unattended-Training-Execution.md)
*   For a full list of the ``submit-mpi`` options see [runai submit-mpi](../Command-Line-Interface-API-Reference/runai-submit-mpi.md)
