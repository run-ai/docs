# Researcher Library: Dynamically Stretch or Compress Workload's GPU Quota

## Introduction

The Run:AI Researcher Library is a python library you can add to your deep learning python code. The library contains an _elasticity_ module which allows _train_ workloads to shrink or expand based on the cluster's availability

### Shrinking a Workload

Shrinking a training job allows your workload to run on a smaller number of GPUs than the researcher code was originally written for. This is useful for maximizing utilization of the cluster as a whole as well as allowing a researcher to run, albeit slower than intended.

Shrinking a training job uses an algorithm called _Gradient_ _Accumulation_. For more information about the algorithm see: <https://towardsdatascience.com/what-is-gradient-accumulation-in-deep-learning-ec034122cfa>

### Expanding a Workload

Expanding a training job allows your GPUs to runs on more GPUs than the researcher code was originally written for. This is useful for maximizing the utilization of the cluster as a whole as well as allowing a researcher to run faster if idle GPUs exist in the cluster. The extra GPUs will be automatically reclaimed if needed by other, prioritized jobs.

## Installation

### Python Deep-Learning Code

In your command-line run:

    pip install runai

In your python code add:

    import runai.elastic

Initialize Elasticity by calling:

    runai.elastic.init(global_batch_size, max_gpu_batch_size)

Create a Keras model:

    model = runai.elastic.keras.models.Model(model)

Model Fitting:

    model.fit(x_train, y_train, 
      batch_size=runai.elastic.batch_size, 
      epochs=100, 
      validation_data=(x_test, y_test), 
      shuffle=False, 
      verbose=runai.elastic.master, 
      callbacks=[StepTimeReporter()] if runai.elastic.master else [])

### Running a Training Workload

Run the training workload by using the "elastic" flag:

*   When launching the job with the [runai submit](../cli-reference/runai-submit.md) command use --elastic
*   When launching a job via YAML code, use the label "elastic" with the value "true"

## Limitations

*   Elasticity currently works with Keras-based or PyTorch-based deep learning code only
*   Any training job with Run:AI is subject to pause/resume episodes. Elasticity may increase these episodes, making it even more important to make your code resilient. Save checkpoints in your code and allow it to resume from the latest checkpoint rather than start from the beginning

## See Also

For additional documentation as well as Python examples see our [GitHub repository](https://github.com/run-ai/runai/tree/master/runai/elastic)