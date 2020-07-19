The Run:AI Researcher Library is a python library you can add to your deep learning python code. The reporting module in the library will externalize information about the run which can then be available for users of the Run:AI user interface (<https://app.run.ai>)

With the reporter module, you can externalize information such as progress, accuracy, and loss over time/epoch and more. In addition, you can externalize custom metrics of your choosing.

# Sending Metrics

## Python Deep-Learning Code

In your command line run:

<pre>pip install runai</pre>

In your python code add:

<pre>import runai.reporter </pre>

To send a number-based metric report, write:

<pre>reportMetric(&lt;reporter_metric_name&gt;, &lt;reporter_metric_value&gt;)</pre>

For example,&nbsp;

<pre>reportMetric("accuracy", 0.34)</pre>

To send a text-based metric report, write:

<pre>reportParameter(&lt;reporter_param_name&gt;, &lt;reporter_param_value&gt;)</pre>

For example,&nbsp;

<pre>reportParameter("state", "Training Model")</pre>

## Recommended Metrics to send

For the sake of uniformity with the Keras implementation (see below), we recommend sending the following metrics:

<table border="1" cellpadding="1" cellspacing="1" style="width: 729px;">
<tbody>
<tr>
<td style="padding: 6px; width: 304px;"><strong>Metric</strong></td>
<td style="padding: 6px; width: 304px;"><strong>Type</strong></td>
<td style="padding: 6px; width: 304px;"><strong>Frequency of Send</strong></td>
<td style="padding: 6px; width: 335px;"><strong>Description</strong></td>
</tr>
<tr>
<td style="padding: 6px; width: 304px;">accuracy</td>
<td style="padding: 6px; width: 304px;">numeric&nbsp;</td>
<td style="padding: 6px; width: 304px;">Each step</td>
<td style="padding: 6px; width: 335px;">
<span class="wysiwyg-underline">Current</span> accuracy of run</td>
</tr>
<tr>
<td style="padding: 6px; width: 304px;">loss</td>
<td style="padding: 6px; width: 304px;">numeric</td>
<td style="padding: 6px; width: 304px;">Each step</td>
<td style="padding: 6px; width: 335px;">
<span class="wysiwyg-underline">Current</span> result of loss function of run&nbsp;</td>
</tr>
<tr>
<td style="padding: 6px; width: 304px;">learning_rate</td>
<td style="padding: 6px; width: 304px;">numeric</td>
<td style="padding: 6px; width: 304px;">Once</td>
<td style="padding: 6px; width: 335px;">Defined learning rate of run</td>
</tr>
<tr>
<td style="padding: 6px; width: 304px;">step</td>
<td style="padding: 6px; width: 304px;">numeric&nbsp;</td>
<td style="padding: 6px; width: 304px;">East Step</td>
<td style="padding: 6px; width: 335px;">Current step of run</td>
</tr>
<tr>
<td style="padding: 6px; width: 304px;">number_of_layers</td>
<td style="padding: 6px; width: 304px;">numeric&nbsp;</td>
<td style="padding: 6px; width: 304px;">Once</td>
<td style="padding: 6px; width: 335px;">Number of layers defined for the run</td>
</tr>
<tr>
<td style="padding: 6px; width: 304px;">optimizer_name</td>
<td style="padding: 6px; width: 304px;">text</td>
<td style="padding: 6px; width: 304px;">Once</td>
<td style="padding: 6px; width: 335px;">&nbsp;Name of Deep Learning Optimizer</td>
</tr>
<tr>
<td style="padding: 6px; width: 304px;">batch_size</td>
<td style="padding: 6px; width: 304px;">numeric</td>
<td style="padding: 6px; width: 304px;">Once</td>
<td style="padding: 6px; width: 335px;">Size of batch</td>
</tr>
<tr>
<td style="padding: 6px; width: 304px;">epoch</td>
<td style="padding: 6px; width: 304px;">numeric</td>
<td style="padding: 6px; width: 304px;">Each epoch</td>
<td style="padding: 6px; width: 335px;">&nbsp;Current Epoch number</td>
</tr>
<tr>
<td style="padding: 6px; width: 304px;">overall_epochs</td>
<td style="padding: 6px; width: 304px;">numeric&nbsp;</td>
<td style="padding: 6px; width: 304px;">Once</td>
<td style="padding: 6px; width: 335px;">&nbsp;Total number of epochs</td>
</tr>
</tbody>
<caption>&nbsp;</caption>
</table>

__epoch__ and __overall\_epochs__ are especially important since the job progress bar is computed by dividing these parameters.&nbsp;&nbsp;

# Automatic Sending of Metrics for Keras-Based Scripts

For Keras based deep learning runs, there is a python code that automates the task of sending metrics. Install the library as above and reference runai.reporter from your code. Then write:

<pre>runai.reporter.autolog()</pre>

The above metrics will automatically be sent going forward.

# Adding the Metrics to the User interface

The metrics show up in the Job list of the user interface. To add a metric to the UI

*   Integrate the reporter library into your code
*   Send a metrics via the reporter library
*   Run the workload once to send initial data.
*   Go to:&nbsp;<https://app.run.ai/jobs>
*   On the top right, use the settings wheel and select the metrics you have added

![mceclip0.png](https://support.run.ai/hc/article_attachments/360007611820/mceclip0.png)