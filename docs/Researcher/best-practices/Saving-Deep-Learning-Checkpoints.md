# Best Practice: Save Deep-Learning Checkpoints

## Introduction

Run:AI can pause unattended executions, giving your GPU resources to another workload. When the time comes, Run:AI will give you back the resources and restore your workload. Thus, it is a good practice to save the state of your run at various checkpoints and start a workload from the latest checkpoint (typically between epochs).

## How to Save Checkpoints

TensorFlow, Pytorch, and others have mechanisms to help save checkpoints (e.g. <https://www.tensorflow.org/guide/checkpoint> for TensorFlow and [https://pytorch.org/tutorials/recipes/recipes/saving\_and\_loading\_a\_general\_checkpoint.html](https://pytorch.org/tutorials/recipes/recipes/saving_and_loading_a_general_checkpoint.html) for Pytorch).

## Where to Save Checkpoints

It is important to __save the checkpoints to network storage__ and not the machine itself. When your workload resumes, it can, in all probability, be allocated to a different node (machine) than the original node.

## When to Save Checkpoints

### Save Periodically

It is a best practice to save checkpoints at intervals. For example, every epoch.

### Save on Exit Signal

If periodic checkpoints are not enough, you can use a_ signal-hook_ provided by Run:AI (via Kubernetes). The hook is python code that is called before your job is suspended and allows you to save your checkpoints as well as other state data you may wish to store.

<pre><code>import signal<br/>import time<br/><br/>def graceful_exit_handler(signum, frame):<br/> # save your checkpoints to shared storage<br/><br/> # exit with status "1" is important for the job to return later.  <br/> exit(1)<br/><br/>if __name__ == "__main__":<br/> signal.signal(signal.SIGTERM, graceful_exit_handler)<br/><br/> # rest of code </code></pre>

By default, you will have 30 seconds to save your checkpoints.

## Resuming using Saved Checkpoints

A Run:AI unattended workload that is resumed, will run the __same startup script __as on the first run. It is the responsibility of the script developer to add code that:

*   Checks if saved checkpoints exist
*   If saved checkpoints exist, load them and start the run using these checkpoints