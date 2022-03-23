# Best Practice: Save Deep-Learning Checkpoints

## Introduction

Run:ai can pause unattended executions, giving your GPU resources to another workload. When the time comes, Run:ai will give you back the resources and restore your workload. Thus, it is a good practice to save the state of your run at various checkpoints and start a workload from the latest checkpoint (typically between epochs).

## How to Save Checkpoints

TensorFlow, PyTorch, and others have mechanisms to help save checkpoints (e.g. [https://www.tensorflow.org/guide/checkpoint](https://www.tensorflow.org/guide/checkpoint){target=_blank} for TensorFlow and [https://pytorch.org/tutorials/recipes/recipes/saving_and_loading_a_general_checkpoint.html](https://pytorch.org/tutorials/recipes/recipes/saving_and_loading_a_general_checkpoint.html){target=_blank} for Pytorch).

This document uses Keras as an example. The code itself can be found [here](https://github.com/run-ai/docs/tree/master/quickstart/unattended-execution){target=_blank}

## Where to Save Checkpoints

It is important to __save the checkpoints to network storage__ and not the machine itself. When your workload resumes, it can, in all probability, be allocated to a different node (machine) than the original node. Example:

```
runai submit train-with-checkpoints -i tensorflow/tensorflow:1.14.0-gpu-py3 \
  -v /mnt/nfs_share/john:/mydir -g 1  --working-dir /mydir --command -- ./startup.sh
```

The command saves the checkpoints in an NFS checkpoints folder `/mnt/nfs_share/john`

## When to Save Checkpoints

### Save Periodically

It is a best practice to save checkpoints at intervals. For example, every epoch as the Keras code below shows:

``` python
checkpoints_file = "weights.best.hdf5"
checkpoint = ModelCheckpoint(checkpoints_file, monitor='val_acc', verbose=1, 
    save_best_only=True, mode='max')
```

### Save on Exit Signal

If periodic checkpoints are not enough, you can use a _signal-hook_ provided by Run:ai (via Kubernetes). The hook is python code that is called before your Job is suspended and allows you to save your checkpoints as well as other state data you may wish to store.

``` python
import signal
import time

def graceful_exit_handler(signum, frame):
    # save your checkpoints to shared storage

    # exit with status "1" is important for the Job to return later.  
    exit(1)

signal.signal(signal.SIGTERM, graceful_exit_handler)
```

By default, you will have 30 seconds to save your checkpoints.

!!! Important Note
    For the signal to be captured, it must be propagated from the startup script to the python child process. See code [here](https://github.com/run-ai/docs/blob/master/quickstart/unattended-execution/startup.sh){target=_blank}

## Resuming using Saved Checkpoints

A Run:ai unattended workload that is resumed, will run the __same startup script__ as on the first run. It is the responsibility of the script developer to add code that:

*   Checks if saved checkpoints exist (see above)
*   If saved checkpoints exist, load them and start the run using these checkpoints

``` python
import os

checkpoints_file = "weights.best.hdf5"
if os.path.isfile(checkpoints_file):
    print("loading checkpoint file: " + checkpoints_file)
    model.load_weights(checkpoints_file)
```