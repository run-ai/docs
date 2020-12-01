# Quickstart: Launch Distributed Training Workloads

## Introduction

Distributed Training is the ability to split the training of a model among multiple processors. Each processor is called a _worker node_. Worker nodes work in parallel to speed up model training. Distributed Training should not be confused with multi-GPU training. Multi-GPU training is the allocation of more than a single GPU to your workload which runs on a __single container__.

Getting Distributed Training to work is more complex than multi-GPU training as it requires syncing of data and timing between the different workers. However, it is often a necessity when multi-GPU training no longer applies; typically when you require more GPUs than exist on a single node. There are a number of Deep Learning frameworks that support Distributed Training. [Horovod](https://eng.uber.com/horovod/){target=_blank} is a good example.

Run:AI provides the ability to run, manage, and view Distributed Training workloads. The following is a Quickstart document for such a scenario.

## Prerequisites

To complete this Quickstart you must have:

*   Run:AI software is installed on your Kubernetes cluster. See: [Installing Run:AI on an on-premise Kubernetes Cluster](../../Administrator/Cluster-Setup/cluster-install.md)
*   Run:AI CLI installed on your machine. See: [Installing the Run:AI Command-Line Interface](../../Administrator/Researcher-Setup/cli-install.md)

## Step by Step Walkthrough

### Setup

*   Login to the Projects area of the Run:AI Administration user interface at [https://app.run.ai/projects](https://app.run.ai/projects){target=_blank}
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

### Run Training Distributed Workload

*   At the command-line run:

``` shell
runai config project team-a
runai submit-mpi dist --processes=2 -g 1 \
        -i gcr.io/run-ai-demo/quickstart-distributed
```

*   We named the job _dist_
*   The job is assigned to _team-a_
*   There will be two worker processes (--processes=2), each allocated with a single GPU (-g 1)
*   The job is based on a sample docker image ``gcr.io/run-ai-demo/quickstart-distributed``.
*   The image contains a startup script that runs a deep learning Horovod-based workload.


Follow up on the job's status by running:

        runai list jobs

The result:

![mceclip11.png](img/mceclip11.png)

The Run:AI scheduler ensures that all processes can run together. You can see the list of workers as well as the main "launcher" process by running:

        runai describe job dist

You will see two worker processes (pods) their status and on which node they run:

![mceclip12.png](img/mceclip12.png)

To see the merged logs of all pods run:

        runai logs dist

Finally, you can delete the distributed training workload by running:

        runai delete dist

### Run an Interactive Distributed Workload

It is also possible to run a distributed training job as "interactive". This is useful if you want to test your distributed training job before committing on a long, unattended training session. To run such a session use:

``` shell
runai submit-mpi dist-int --processes=2 -g 1 \
        -i gcr.io/run-ai-demo/quickstart-distributed --interactive \
        --command -- sh -c sleep infinity 
```

When the workers are running run:

        runai bash dist-int

This will provide shell access to the launcher process. From there, you can run your distributed workload. For Horovod version smaller than 0.17.0 run:

``` shell
horovodrun -np $RUNAI_MPI_NUM_WORKERS \
        python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
        --model=resnet20 --num_batches=1000000 --data_name cifar10 \
        --data_dir /cifar10 --batch_size=64 --variable_update=horovod
```

For Horovod version 0.17.0 or later, add the `-hostfile` flag as follows:

``` shell
horovodrun -np $RUNAI_MPI_NUM_WORKERS -hostfile /etc/mpi/hostfile \
        python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
        --model=resnet20 --num_batches=1000000 --data_name cifar10 \
        --data_dir /cifar10 --batch_size=64 --variable_update=horovod 
```


The environment variable ``RUNAI_MPI_NUM_WORKERS`` is passed by Run:AI and contains the number of worker processes provided to the ``runai submit-mpi`` command (in the above example the value is 2).


## See Also

*   The source code of the image used in this Quickstart document is in [Github](https://github.com/run-ai/docs/tree/master/quickstart/distributed){target=_blank}
*   For a full list of the ``submit-mpi`` options see [runai submit-mpi](../cli-reference/runai-submit-mpi.md)
