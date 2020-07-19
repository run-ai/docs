## Introduction

When we discuss the allocation of deep learning compute resources, the discussion tends to focus on GPUs as the most critical resource. But there are two additional resources that are no less important:

*   CPUs. Mostly needed for preprocessing and postprocessing tasks during a deep learning training run.
*   Memory. Has a direct influence on the quantities of data a training run can process in batches.

GPU servers tend to come installed with a significant amount of memory and CPUs.&nbsp;

&nbsp;

## Requesting CPU &amp; Memory

When submitting a job, you can request a guaranteed amount of CPUs and memory by using the __--cpu__ and __--memory__ flags in the _runai submit_ command. For example:

<pre>runai submit job1 -i ubuntu --gpu 2 --cpu 12 --memory 1G</pre>

The system guarantees that if the job is scheduled, you will be able to receive this amount of CPU and memory.

For further details on these flags see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011436120-runai-submit>

### CPU over allocation

The number of CPUs your job will receive is guaranteed to be&nbsp;the number defined using the --cpu flag. In practice, however, you may receive <span class="wysiwyg-underline">more CPUs than you have asked</span> for:

*   If you are currently alone on a node, you will receive all the node CPUs until such time when another workload has joined.
*   However, when a second workload joins, each workload will receive a number of CPUs <span class="wysiwyg-underline">proportional</span> to the number requested via the --cpu flag. For example, if the first workload asked for 1 CPU and the second for 3 CPUs, then on a node with 40 nodes, the workloads will receive 10 and 30 CPUs respectively.

### Memory over allocation

The amount of Memory your job will receive is guaranteed to be&nbsp;the number defined using the --memory flag. In practice, however, you may receive <span class="wysiwyg-underline">more memory than you have asked</span> for. This is along the same lines as described with CPU over allocation above.&nbsp;

It is important to note, however, that if you have used this memory over-allocation, and new workloads have joined, your job may receive an out of memory exception and terminate.

## CPU and Memory limits

You can limit your job's allocation of CPU and memory by using&nbsp;the __--cpu-limit__ and __--memory-limit__ flags in the __runai submit__ command. For example:

<pre>runai submit job1 -i ubuntu --gpu 2 --cpu 12 --cpu-limit 24 \<br/>   --memory 1G --memory-limit 4G</pre>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">The limit behavior is different for CPUs and memory.</span>

*   Your job will never be allocated with more than the amount stated in the --cpu-limit flag
*   If your job tries to allocate more than the amount stated in the --memory-limit flag it will receive an out of memory exception.&nbsp;&nbsp;

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">For further details on these flags see:&nbsp;</span><a href="https://support.run.ai/hc/en-us/articles/360011436120-runai-submit" style="background-color: #ffffff; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">https://support.run.ai/hc/en-us/articles/360011436120-runai-submit</a>

## Flag Defaults

### Defaults for --cpu flag

If your job has not specified --cpu, the system will use a default. The default is cluster-wide and is defined as a&nbsp;__ratio__ of GPUs to CPUs.

Consider the default of 1:6. If your job has only specified --gpu 2 and has not specified --cpu, then the implied --cpu flag value is 12 CPUs.&nbsp;

The system comes with a cluster-wide default <span class="wysiwyg-color-black">of 1:1.</span><span class="wysiwyg-color-black">&nbsp;To change this default please contact Run:AI customer support</span>

### <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Default for the --memory flag</span>

<span class="wysiwyg-color-black" style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">If your job has not specified --memory, the system will use a default. The default is cluster-wide and is proportional to the number of requested GPUs.</span>

<span class="wysiwyg-color-black" style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">The system comes with a cluster-wide default </span><span class="wysiwyg-color-black"><span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">of </span><span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">100MiB per GPU.</span></span><span class="wysiwyg-color-black" style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;"><span class="wysiwyg-color-black"> To change this default please contact Run:AI customer support</span></span>

&nbsp;
&nbsp;
&nbsp;