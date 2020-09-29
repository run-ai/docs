# Best Practice: Convert your Workload to Run Unattended

## Motivation

Run:AI allows non-interactive training workloads to extend beyond guaranteed quotas and into over-quota as long as computing resources are available.  
To achieve this flexibility, the system needs to be able to safely stop a workload and restart it again later. This requires researchers to switch workloads from running interactively, to running unattended, thus allowing Run:AI to pause/resume the run.

Unattended workloads are good for long-duration runs, or sets of smaller hyperparameter optimization runs.

## Best Practices

### Docker Image

A docker container is based on a docker image. Some researchers use generic images such as ones provided by Nvidia (e.g. <https://ngc.nvidia.com/catalog/containers/nvidia:tensorflow>). Others, use generic images as the <ins>base</ins> image to a more customized image using _Dockerfiles_ <https://docs.docker.com/develop/develop-images/dockerfile_best-practices/>.

Realizing that researchers are not always proficient with building docker files, as a best practice you will want to:

*   Use the same docker image both for interactive and unattended jobs. In this way, you can keep the difference between both methods of invocation to a minimum. This can be a stock image from Nvidia or a custom image.
*   Leave some degree of flexibility which allows the researcher to add/remove python dependencies without re-creating images.

As such we recommend the following best practice:

### Create a Startup Script

All the commands you run inside the interactive job after it has been allocated should be gathered into a single script. The script will be provided with the command-line at the start of the unattended execution (see the section _running the job_ below). This script should be kept next to your code, on a shared network drive (e.g. _/nfs/john_).

An example of a very common startup script __start.sh__ will be:

    pip install -r requirements.txt
    ...
    python training.py

The first line of this script is there to make sure that all required python libraries are installed prior to the training script execution, it also allows the researcher to add/remove libraries without needing changes to the image itself.

### Support Variance Between Different Runs

Your training script must be flexible enough to support variance in execution without changing the code. For example, you will want to change the number of epochs to run, apply a different set of hyperparameters, etc. There are two ways to handle this in your script. You can use <ins>one</ins> or <ins>both</ins> methods:

1. Your script can read arguments passed to the script:

    <pre><code>python training.py <strong>--number-of-epochs=30</strong></code></pre>

In which case, change your start.sh script to:

<pre><code>pip install -r requirements.txt
...
python training.py <strong>$@</strong></code></pre>

2. Your script can read from environment variables during script execution. In case you use environment variables, they will be passed to the training script automatically. No special action is required in this case.

### Checkpoints

Run:AI can pause unattended executions, giving your GPU resources to another workload. When the time comes, Run:AI will give you back the resources and restore your workload. Thus, it is a good practice to save your weights at various checkpoints and start a workload from the latest checkpoint (typically between epochs).

TensorFlow, Pytorch, and others have mechanisms to help save checkpoints (e.g. <https://www.tensorflow.org/guide/checkpoint> for TensorFlow and <https://pytorch.org/tutorials/recipes/recipes/saving_and_loading_a_general_checkpoint.html> for Pytorch).

It is important to __save the checkpoints to network storage__ and not the machine itself. When your workload resumes, it can, in all probability, be allocated to a different node (machine) than the original node

For more information on best practices for saving checkpoints, see: [Saving Deep Learning Checkpoints](Saving-Deep-Learning-Checkpoints.md).

## Running the Job

Using ``runai submit``, drop the flag ``--interactive``. For submitting a job using the script created above, please use ``--command``, and pass arguments and/or environment variables using the runai submit flags ``--args``  and  ``--environment``.

Example with Environment variables:

<pre><code>runai submit train1 -i nvcr.io/nvidia/tensorflow:20.03-tf1-py3 \<br/>  --project my-project -v /nfs/john:/mydir -g 1 \<br/>  --command ./startup.sh --working-dir /mydir/ \<br/><strong>  -e 'EPOCHS=30' \</strong><br/><strong>  -e 'LEARNING_RATE=0.02'</strong></code></pre>

Example with Command-line arguments:

<pre><code>runai submit train1 -i nvcr.io/nvidia/tensorflow:20.03-tf1-py3 \<br/> --project my-project -v /nfs/john:/mydir -g 1 \<br/> --command ./startup.sh --working-dir /mydir/ \<br/>   --args='<strong>number-of-epochs=30'</strong> \<br/>   --args=<strong>'batch-size=64'</strong> </code></pre>

Please refer to [Command-Line Interface, runai submit](../cli-reference/runai-submit.md) for a list of all arguments accepted by the Run:AI CLI.

<!-- ### Use CLI Templates

Different run configurations may vary significantly and can be tedious to be written each time on the command-line. To make life easier, our CLI offers a way to template those configurations and use pre-configured configuration when submitting a job. Please refer to [Configure Command-Line Interface Templates](../../Administrator/Researcher-Setup/template-config.md). -->

## Attached Files

The 3 relevant files mentioned in this document can be downloaded from [Github](https://github.com/run-ai/docs/tree/master/quickstart/unattended-execution)

## See Also

See the unattended training walk-through: [Launch Unattended Training Workloads](../Walkthroughs/walkthrough-train.md)