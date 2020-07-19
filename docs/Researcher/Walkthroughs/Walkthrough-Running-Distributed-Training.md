## Introduction

Distributed Training is the ability to split the training of a model among multiple processors. Each processor is called a _worker node_.&nbsp;Worker nodes work in parallel to speed up model training.&nbsp; Distributed Training should not be confused with multi-GPU training. Multi-GPU training is the allocation of more than a single GPU&nbsp;to your workload which runs on a __single__ __container__.

Getting Distributed Training to work is more complex than multi-GPU training as it requires syncing of data and timing between the different workers. However, it is often a necessity when multi-GPU training no longer applies; typically when you require more GPUs than exist on a single node. There are a number of Deep Learning frameworks that support Distributed Training. Horovod (<https://eng.uber.com/horovod/>) is a good example.

Run:AI provides the ability to run, manage, and view Distributed Training workloads. The following is a walkthrough of such a scenario.

## Prerequisites&nbsp;

To complete this walkthrough you must have:

*   Run:AI software is installed on your Kubernetes cluster. See:&nbsp;<https://support.run.ai/hc/en-us/articles/360010280179-Installing-Run-AI-on-an-on-premise-Kubernetes-Cluster>
*   Run:AI CLI installed on your machine. See:&nbsp;<https://support.run.ai/hc/en-us/articles/360010706120-Installing-the-Run-AI-Command-Line-Interface>

## Step by Step Walkthrough

### Setup

*   Open the Run:AI user interface at<span>&nbsp;</span><https://app.run.ai>
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

### Run Training Workload

*   At the command line run:

<pre>runai project set team-a<br/><br/>runai submit-mpi dist --processes=2 -g 1 -i gcr.io/run-ai-demo/quickstart-distributed </pre>

*   We named the job&nbsp;_dist_
*   The job is assigned to<span>&nbsp;</span>_team-a_
*   There will be two worker processes (--processes=2), each allocated with a single GPU (-g 1)
*   The job is based on a sample docker image<span>&nbsp;</span>_gcr.io/run-ai-demo/quickstart-distributed_&nbsp;the image contains a startup script that runs a deep learning Horovod-based workload. The script runs the following _Horovod_ command:

<pre class="c-mrkdwn__pre" data-stringify-type="pre">horovodrun -np %<span>RUNAI_MPI_NUM_WORKERS%</span> python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \<br/>   --model=resnet20 --num_batches=1000000 --data_name cifar10  \<br/>   --data_dir /cifar10 --batch_size=64 --variable_update=horovod</pre>

&nbsp;Where&nbsp;<span>RUNAI\_MPI\_NUM\_WORKERS is a Run:AI environment variable containing the number of worker processes provided to the runai submit-mpi command (in this example it's 2).</span>

Follow up on the job's status by running:

<pre>runai list</pre>

The result:

![mceclip1.png](https://support.run.ai/hc/article_attachments/360014298800/mceclip1.png)

The Run:AI scheduler ensures that all processes can run together. You can see the list of workers as well as the main "launcher" process by running:

<pre>runai get dist </pre>

&nbsp;You will see two worker processes (pods) their status and on which node they run:

![mceclip0.png](https://support.run.ai/hc/article_attachments/360014290699/mceclip0.png)

To see the merged logs of all pods run:

<pre>runai logs dist</pre>

Finally, you can delete the distributed training workload by running:

<pre>runai delete dist</pre>

### Run an Interactive Distributed training Workload

It is also possible to run a distributed training job as "interactive". This is useful if you want to test your distributed training job before committing on a long, unattended training session. To run such a session use:&nbsp;

<pre class="c-mrkdwn__pre" data-stringify-type="pre">runai submit-mpi dist-int --processes=2 -g 1 \ <br/>   -i gcr.io/run-ai-demo/quickstart-distributed  \<br/>   --command="sh" --args="-c" --args="sleep infinity"  --interactive</pre>

&nbsp;When the workers are running run:

<pre>runai bash dist-int</pre>

This will provide shell access to the launcher process. From there, you can run your distributed session. For examples, with Horovod:

<pre>horovodrun -np 2 python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \<br/> --model=resnet20 --num_batches=1000000 --data_name cifar10 \<br/> --data_dir /cifar10 --batch_size=64 --variable_update=horovod</pre>

<span style="font-size: 2.1em; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Next Steps</span>

*   For more information on how to convert an interactive session into a training job, see: <https://support.run.ai/hc/en-us/articles/360012065440-Converting-your-Workload-to-use-Unattended-Training-Execution>
*   For a full list of the submit-mpi options see&nbsp;<https://support.run.ai/hc/en-us/articles/360015125180-runai-submit-mpi>&nbsp;

&nbsp;