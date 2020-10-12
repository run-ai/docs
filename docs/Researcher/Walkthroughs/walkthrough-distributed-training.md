# Quickstart: Launch Distributed Training Workloads

## Introduction

Distributed Training is the ability to split the training of a model among multiple processors. Each processor is called a _worker node_. Worker nodes work in parallel to speed up model training. Distributed Training should not be confused with multi-GPU training. Multi-GPU training is the allocation of more than a single GPU to your workload which runs on a __single container__.

Getting Distributed Training to work is more complex than multi-GPU training as it requires syncing of data and timing between the different workers. However, it is often a necessity when multi-GPU training no longer applies; typically when you require more GPUs than exist on a single node. There are a number of Deep Learning frameworks that support Distributed Training. Horovod (<https://eng.uber.com/horovod/>) is a good example.

Run:AI provides the ability to run, manage, and view Distributed Training workloads. The following is a Quickstart document for such a scenario.

## Prerequisites

To complete this Quickstart you must have:

*   Run:AI software is installed on your Kubernetes cluster. See: [Installing Run:AI on an on-premise Kubernetes Cluster](../../Administrator/Cluster-Setup/cluster-install.md)
*   Run:AI CLI installed on your machine. See: [Installing the Run:AI Command-Line Interface](../../Administrator/Researcher-Setup/cli-install.md)

## Step by Step Walkthrough

### Setup

*   Open the Run:AI user interface at [app.run.ai](https://app.run.ai)
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

### Run Training Distributed Workload

*   At the command-line run:

``` shell
runai project set team-a
runai submit-mpi dist --processes=2 -g 1 \
        -i gcr.io/run-ai-demo/quickstart-distributed
```

*   We named the job _dist_
*   The job is assigned to _team-a_
*   There will be two worker processes (--processes=2), each allocated with a single GPU (-g 1)
*   The job is based on a sample docker image ``gcr.io/run-ai-demo/quickstart-distributed``.
*   The image contains a startup script that runs a deep learning Horovod-based workload.


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

### Run an Interactive Distributed Workload

It is also possible to run a distributed training job as "interactive". This is useful if you want to test your distributed training job before committing on a long, unattended training session. To run such a session use:

``` shell
runai submit-mpi dist-int --processes=2 -g 1 \
        -i gcr.io/run-ai-demo/quickstart-distributed  \
        --command="sh" --args="-c" --args="sleep infinity"  --interactive
```

When the workers are running run:

        runai bash dist-int

This will provide shell access to the launcher process. From there, you can run your distributed workload:

``` shell
horovodrun -np $RUNAI_MPI_NUM_WORKERS \
        python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
        --model=resnet20 --num_batches=1000000 --data_name cifar10 \
        --data_dir /cifar10 --batch_size=64 --variable_update=horovod
```

The environment variable ``RUNAI_MPI_NUM_WORKERS`` is a passed by Run:AI and contains the number of worker processes provided to the ``runai submit-mpi`` command (in this example it's 2).

!!! Note
        Using ``horovodrun`` as above will only work on Horovod versions smaller or equal to 0.16.4. For later versions of Horovod you will need to use ``mpirun`` instead. For example:

        ```
        mpirun --allow-run-as-root --tag-output -np $RUNAI_MPI_NUM_WORKERS -bind-to none -map-by slot -mca pml ob1 -mca btl ^openib -x CUDNN_VERSION -x LS_COLORS -x LD_LIBRARY_PATH -x MXNET_VERSION -x HOSTNAME -x OMPI_MCA_orte_default_hostfile -x NVIDIA_VISIBLE_DEVICES -x KUBERNETES_PORT_443_TCP_PROTO -x KUBERNETES_PORT_443_TCP_ADDR -x NCCL_VERSION -x OMPI_MCA_plm_rsh_agent -x KUBERNETES_PORT -x PWD -x HOME -x RUNAI_MPI_NUM_WORKERS -x TENSORFLOW_VERSION -x PYTORCH_VERSION -x KUBERNETES_SERVICE_PORT_HTTPS -x KUBERNETES_PORT_443_TCP_PORT -x LIBRARY_PATH -x KUBERNETES_PORT_443_TCP -x TORCHVISION_VERSION -x TERM -x CUDA_PKG_VERSION -x CUDA_VERSION -x NVIDIA_DRIVER_CAPABILITIES -x PYTHON_VERSION -x SHLVL -x podUUID -x NVIDIA_REQUIRE_CUDA -x reporterGatewayURL -x KUBERNETES_SERVICE_PORT -x jobUUID -x PATH -x KUBERNETES_SERVICE_HOST -x jobName -x _ 
                python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py 
                --model=resnet20 --num_batches=1000000 --data_name cifar10  
                --data_dir /cifar10 --batch_size=64 --variable_update=horovod
        ```



## See Also

*   The source code of the image used in this Quickstart document is in [Github](https://github.com/run-ai/docs/tree/master/quickstart/distributed)
*   For a full list of the ``submit-mpi`` options see [runai submit-mpi](../cli-reference/runai-submit-mpi.md)
