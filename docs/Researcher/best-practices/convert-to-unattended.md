# Best Practice: Convert your Workload to Run Unattended

## Motivation

Run:ai allows non-interactive training workloads to extend beyond guaranteed quotas and into over-quota as long as computing resources are available.  
To achieve this kind of flexibility, the system needs to be able to safely stop a workload and restart it again later. This requires Researchers to switch workloads from running interactively, to running unattended, thus allowing Run:ai to pause/resume the run.

Unattended workloads are a good fit for long-duration runs, or sets of smaller hyperparameter optimization runs.

## Best Practices

### Docker Image

A docker container is based on a docker image. Some Researchers use generic images such as ones provided by Nvidia, for example: [NVIDIA NGC TensorFlow](https://ngc.nvidia.com/catalog/containers/nvidia:tensorflow){target=_blank}. 
Others, use generic images as the __base__ image to a more customized image using [Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/){target=_blank}.

Realizing that Researchers are not always proficient with building docker files, as a best practice, you will want to:

*   Use the same docker image both for interactive and unattended jobs. In this way, you can keep the difference between both methods of invocation to a minimum. This can be a stock image from Nvidia or a custom image.
*   Leave some degree of flexibility, which allows the Researcher to add/remove python dependencies without re-creating images.


### Code Location

You will want to minimize the cycle of code change-and-run. There are a couple of best practices which you can choose from:

1. Code resides on the network file storage. This way you can change the code and immediately run the Job. The Job picks up the new files from the network.
2. Use the `runai submit` flag `--git-sync`. The flag allows the Researcher to provide details of a Git repository. The repository will be automatically cloned into a specified directory when the container starts.
3. The code can be embedded within the image. In this case, you will want to create an automatic CI/CD process, which packages the code into a modified image. 

The document below assumes option #1. 

### Create a Startup Script

Gather the commands you ran inside the interactive Job into a single script. The script will be provided with the command-line at the start of the unattended execution (see the section _running the job_ below). This script should be kept next to your code, on a shared network drive (e.g. _/nfs/john_).

An example of a common startup script __start.sh__:

``` 
pip install -r requirements.txt
...
python training.py
```

The first line of this script is there to make sure that all required python libraries are installed before the training script executes, it also allows the Researcher to add/remove libraries without needing changes to the image itself.

### Support Variance Between Different Runs

Your training script must be flexible enough to support variance in execution without changing the code. For example, you will want to change the number of epochs to run, apply a different set of hyperparameters, etc. There are two ways to handle this in your script. You can use <ins>one</ins> or <ins>both</ins> methods:

1. Your script can read arguments passed to the script:

    <pre><code>python training.py <strong>--number-of-epochs=30</strong></code></pre>

In which case, change your start.sh script to:

<pre><code>pip install -r requirements.txt
...
python training.py <strong>$@</strong></code></pre>

2. Your script can read from environment variables during script execution. In case you use environment variables, the variables will be passed to the training script automatically. No special action is required in this case.

### Checkpoints

Run:ai can pause unattended executions, giving your GPU resources to another workload. When the time comes, Run:ai will give you back the resources and restore your workload. Thus, it is a good practice to save your weights at various checkpoints and start a workload from the latest checkpoint (typically between epochs).

TensorFlow, Pytorch, and others have mechanisms to help save checkpoints (e.g. [https://www.tensorflow.org/guide/checkpoint](https://www.tensorflow.org/guide/checkpoint){target=_blank} for TensorFlow and [https://pytorch.org/tutorials/recipes/recipes/saving_and_loading_a_general_checkpoint.html](https://pytorch.org/tutorials/recipes/recipes/saving_and_loading_a_general_checkpoint.html){target=_blank} for Pytorch).

It is important to __save the checkpoints to network storage__ and not the machine itself. When your workload resumes, it can, in all probability, be allocated to a different node (machine) than the original node

For more information on best practices for saving checkpoints, see [Saving Deep Learning Checkpoints](save-dl-checkpoints.md).

## Running the Job

Using ``runai submit``, drop the flag ``--interactive``. For submitting a Job using the script created above, please use ``-- [COMMAND]`` flag to specify a command, use the `--` syntax to pass arguments, and pass environment variables using the flag ``--environment``.

Example with Environment variables:

```
runai submit train1 -i tensorflow/tensorflow:1.14.0-gpu-py3  
    -v /nfs/john:/mydir -g 1  --working-dir /mydir/  
    -e 'EPOCHS=30'  -e 'LEARNING_RATE=0.02'  
    -- ./startup.sh  
```

Example with Command-line arguments:


```
runai submit train1 -i tensorflow/tensorflow:1.14.0-gpu-py3  
    -v /nfs/john:/mydir -g 1  --working-dir /mydir/  
    -- ./startup.sh batch-size=64 number-of-epochs=3
```


Please refer to [Command-Line Interface, runai submit](../cli-reference/runai-submit.md) for a list of all arguments accepted by the Run:ai CLI.

### Use CLI Policies

Different run configurations may vary significantly and can be tedious to be written each time on the command-line. To make life easier, our CLI offers a way to set administrator policies for these configurations and use pre-configured configuration when submitting a Workload. Please refer to [Configure Command-Line Interface Policies](../../admin/workloads/policies.md). 

## Attached Files

The 3 relevant files mentioned in this document can be downloaded from [Github](https://github.com/run-ai/docs/tree/master/quickstart/unattended-execution){target=_blank}

## See Also

See the unattended training Quickstart: [Launch Unattended Training Workloads](../Walkthroughs/walkthrough-train.md)
