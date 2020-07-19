## Motivation

Run:AI allows non-interactive training workloads to extend beyond guaranteed quotas and into over-quota as long as computing resources are available.  
To achieve this flexibility, the system needs to be able to safely stop a workload and restart it again later. This requires researchers to switch workloads from running interactively, to running unattended, thus allowing Run:AI to pause/resume the run.&nbsp;

Unattended workloads are good for long-duration runs, or sets of smaller hyper-parameter-tuning runs.&nbsp;

## Best&nbsp;Practices

### Docker Image

A docker container is based on a docker image.&nbsp; Some researchers use generic images such as ones provided by Nvidia (e.g.&nbsp;<https://ngc.nvidia.com/catalog/containers/nvidia:tensorflow>). Others, use generic images as the <span class="wysiwyg-underline">base</span> image to a more customized image using _Dockerfiles_.&nbsp;_&nbsp;_&nbsp;[https://docs.docker.com/develop/develop-images/dockerfile\_best-practices/.](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

Realizing that researchers are not always proficient with building docker files, as a best practice you will want to:

*   Use the same docker image both for interactive and unattended jobs. In this way, you can keep the difference between both methods of invocation to a minimum. This can be a stock image from Nvidia or a custom image.
*   Leave some degree of flexibility which allows the researcher to add/remove python dependencies without re-creating images.&nbsp;

As such we recommend the following best practice:

### Create a Startup Script

All the commands you run inside the interactive job after it has been allocated should be gathered into a single script. The script will be provided with the command-line at the start of the unattended execution (see the section _running the job_ below). This script should be kept next to your code, on a shared network drive (e.g. _/nfs/john_).

An example of a very common startup script __start.sh__&nbsp;will be:

<pre>pip install -r requirements.txt<br/>...<br/>python training.py</pre>

The first line of this script is there to make sure that all required python libraries are installed prior to the training script execution, it also allows the researcher to add/remove libraries without needing changes to the image itself.&nbsp;

### Support Variance Between Different Runs

Your training script must be flexible enough to support variance in execution without changing the code. For example, you will want to change the number of epochs to run, apply a different set of hyperparameters, etc. There are two ways to handle this in your script. You can use <span class="wysiwyg-underline">one</span> or <span class="wysiwyg-underline">both</span> methods:&nbsp;

1.&nbsp; Your script can read arguments passed to the script:

<pre>python training.py <strong>--number-of-epochs=30</strong></pre>

In which case, change your start.sh script to:&nbsp;

<pre>pip install -r requirements.txt<br/>...<br/>python training.py <span class="wysiwyg-color-blue"><strong>$@</strong></span></pre>

2.&nbsp;Your script can read from environment variables during script execution. In case you use environment variables, they will be passed to the training script automatically. No special action is required in this case.

### Checkpoints

Run:AI can pause unattended executions, giving your GPU resources to another workload. When the time comes, Run:AI will give you back the resources and restore your workload. Thus, it is a good practice&nbsp;<span>to save your weights at various checkpoints and start a workload from the latest checkpoint&nbsp;</span>&nbsp;(typically between epochs).

TensorFlow, Pytorch, and others have mechanisms to help save checkpoints (e.g.&nbsp;<https://www.tensorflow.org/guide/checkpoint>&nbsp;for TensorFlow and&nbsp;[https://pytorch.org/tutorials/recipes/recipes/saving\_and\_loading\_a\_general\_checkpoint.html](https://pytorch.org/tutorials/recipes/recipes/saving_and_loading_a_general_checkpoint.html)&nbsp;&nbsp;for Pytorch).

It is important to&nbsp;__save the checkpoints to network storage__ and not the machine itself. When your workload resumes, it can, in all probability, be allocated to a different node (machine) than the original node

For more information on best practices for saving checkpoints, see:&nbsp;<https://support.run.ai/hc/en-us/articles/360014636380-Saving-Deep-Learning-Checkpoints>&nbsp;

## Running the Job

Using _runai submit_, drop the flag _--interactive_. For submitting a job using the script created above, please use&nbsp;___--command___, and pass arguments and/or environment variables using the runai submit flags&nbsp;___--args ___and___ --environment___.&nbsp;

Example with Environment variables:

<pre>runai submit train1 -i nvcr.io/nvidia/tensorflow:20.03-tf1-py3 \<br/>  --project my-project -v /nfs/john:/mydir -g 1 \<br/>  --command ./startup.sh --working-dir /mydir/ \<br/><strong>  -e 'EPOCHS=30' \</strong><br/><strong>  -e 'LEARNING_RATE=0.02'</strong> </pre>

Example with Command-line arguments:

<pre>runai submit train1 -i nvcr.io/nvidia/tensorflow:20.03-tf1-py3 \<br/> --project my-project -v /nfs/john:/mydir -g 1 \<br/> --command ./startup.sh --working-dir /mydir/ \<br/>   --args='<strong>number-of-epochs=30'</strong> \<br/>   --args=<strong>'batch-size=64'</strong> </pre>

Please refer to&nbsp;<https://support.run.ai/hc/en-us/articles/360011436120-runai-submit>&nbsp;for a list of all arguments accepted by the Run:AI CLI.

### Use CLI Templates

Different run configurations may vary significantly and can be tedious to be written each time on the command line. To make life easier, our CLI offers a way to template those configurations and use preconfigured configuration when submitting a job. Please refer to&nbsp;<https://support.run.ai/hc/en-us/articles/360011627459-Configure-Command-Line-Interface-Templates>&nbsp;

## Attached Files

The 3 relevant files are attached to this document for reference

## See Also

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">See the unattended training walkthrough:&nbsp;<https://support.run.ai/hc/en-us/articles/360010706360-Walkthrough-Launch-Unattended-Training-Workloads-></span>

&nbsp;