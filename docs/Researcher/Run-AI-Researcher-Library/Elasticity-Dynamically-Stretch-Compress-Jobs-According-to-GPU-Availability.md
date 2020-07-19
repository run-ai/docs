## Introduction

The Run:AI Researcher Library is a python library you can add to your deep learning python code.&nbsp; The library contains an _elasticity_ module which allows _train_ workloads to shrink or expand based on the cluster's availability

### Shrinking a Workload

Shrinking a training job allows your workload to run on a smaller number of GPUs than the researcher code was originally written for.&nbsp; This is useful for maximizing utilization of the cluster as a whole as well as allowing a researcher to run, albeit slower than intended.&nbsp;

Shrinking a training job uses an algorithm called&nbsp;_Gradient&nbsp;__Accumulation.&nbsp;_For more information about the algorithm see&nbsp;<https://towardsdatascience.com/what-is-gradient-accumulation-in-deep-learning-ec034122cfa>

### Expanding a Workload

Expanding a training job allows your GPUs to runs on more GPUs than the researcher code was originally written for.&nbsp;This is useful for maximizing the utilization of the cluster as a whole as well as allowing a researcher to run faster if idle GPUs exist in the cluster. The extra GPUs will be automatically reclaimed if needed by other, prioritized jobs.&nbsp;

## Installation&nbsp;

### Python Deep-Learning Code

In your command line run:

<pre>pip install runai</pre>

In your python code add:

<pre>import runai.elastic</pre>

&nbsp;Initialize Elasticity by calling:

<pre><span>runai.elastic.init(global_batch_size, max_gpu_batch_size)<br/></span></pre>

<div><span>Create a Keras model:<br/></span></div>

<pre><span> model = runai.elastic.keras.models.Model(model)<br/></span></pre>

<div>Model Fitting:</div>

<pre> model.fit(x_train, y_train,<br/>   batch_size=<strong>runai</strong>.<strong>elastic</strong>.batch_size,<br/>   epochs=100,<br/>   validation_data=(x_test, y_test),<br/>   shuffle=False,<br/>   verbose=<strong>runai.elastic</strong>.master,<br/>   callbacks=[StepTimeReporter()] if <strong>runai.elastic</strong>.master else [])</pre>

<div><span></span></div>

### Running a Training Workload

<div>Run the training workload by using the "elastic" flag:</div>

*   When launching the job with the <a href="https://support.run.ai/hc/en-us/articles/360011436120-runai-submit" target="_self">runai submit</a> command use --elastic
*   When launching a job via yaml code, use the label "elastic" with the value "true"

<div></div>

## Limitations

*   Elasticity currently works with Keras-based deep learning code only
*   Any training job with Run:AI is subject to pause/resume episodes. Elasticity may increase these episodes, making it even more important to make your code resilient. Save checkpoints in your code and allow it to resume from the latest checkpoint rather than start from the beginning&nbsp;

<div></div>

<div><span></span></div>