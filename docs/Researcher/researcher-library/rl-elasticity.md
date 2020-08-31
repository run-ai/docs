# Researcher Library: Dynamically Stretch or Compress Workload's GPU Quota

## Introduction

The Run:AI Researcher Library is a python library you can add to your deep learning python code. The library contains an _elasticity_ module which allows _train_ workloads to shrink or expand based on the cluster's availability

### Shrinking a Workload

Shrinking a training job allows your workload to run on a smaller number of GPUs than the researcher code was originally written for. This is useful for maximizing utilization of the cluster as a whole as well as allowing a researcher to run, albeit slower than intended.

Shrinking a training job uses an algorithm called _Gradient_ _Accumulation_. For more information about the algorithm see: <https://towardsdatascience.com/what-is-gradient-accumulation-in-deep-learning-ec034122cfa>

### Expanding a Workload

Expanding a training job allows your GPUs to runs on more GPUs than the researcher code was originally written for. This is useful for maximizing the utilization of the cluster as a whole as well as allowing a researcher to run faster if idle GPUs exist in the cluster. The extra GPUs will be automatically reclaimed if needed by other, prioritized jobs.

## Installation

Install the Run:AI Python library using the following command:

    pip install runai

## Code

In your python code add, if using Keras, add:

    import runai.elastic.keras

If using PyTorch, add:

    import runai.elastic.torch


## Initizalization
 
To initialize the module, you need two parameters:

* __Maximum GPU batch size__ - The maximum batch size that your could can use on a single GPU in terms of memory. Running with batch sizes larger than this number (without Elasticity) will cause a memory overflow. This number will be used by the Run:AI elasticity module for determining whether to use _Gradient Accumulation_ or not, and how many steps to use.

* __Global batch size__ - The desired batch size. Of course, if this number is larger than the _Maximum GPU batch size_ defined above, the model will not fit into a single GPU. The elasticity module will then use _Gradient Accumulation_ and _multiple GPUs_ to run your code.

Call the init() method from the imported module and pass these two arguments. For example, if you are using PyTorch, use the following line:

    runai.elastic.torch.init(256, 64)

Where 256 is the _global batch size_ and 64 is the _maximum GPU batch size_.

# Usage

### Keras

Create a Keras model:

    model = runai.elastic.keras.models.Model(model)

### PyTorch

For PyTorch models, you'll need to wrap your `Optimizer` with GA.
Refer to the documentation for more information.
Use `runai.elastic.steps` for the number of steps to be accumulated - the value for the `steps` argument of Run:AI GA optimizer. For example:

    optimizer = runai.ga.torch.optim.Optimizer(optimizer, runai.elastic.steps)



## Running a Training Workload

Run the training workload by using the "elastic" flag:

*   When launching the job with the [runai submit](../cli-reference/runai-submit.md) command use --elastic
*   When launching a job via YAML code, use the label "elastic" with the value "true"

## Limitations

*   Elasticity currently works with Keras-based or PyTorch-based deep learning code only.
*   Any training job using Run:AI is subject to pause/resume episodes. Elasticity may increase these episodes, making it even more important to make your code resilient. Take care to [save checkpoints](../best-practices/Saving-Deep-Learning-Checkpoints.md) in your code and have your code resume from the latest checkpoint rather than start from the beginning.

## See Also

For additional documentation as well as Python examples see our [GitHub repository](https://github.com/run-ai/runai/tree/master/runai/elastic)