# What are Templates?

Templates are a way to reduce the number of flags required when using the Command Line Interface to start workloads. Using Templates the researcher can:

*   Review list of templates by running _runai template list_
*   Review the contents of a specific template by running_ runai template get &lt;template-name&gt;_
*   Use a template by running runai submit --template &lt;template-name&gt;

The purpose of this document is to provide the administrator with guidelines on how to create templates

# The Template Implementation

CLI Templates are implemented as_ Kubernetes <a href="https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/" target="_self">ConfigMaps</a>.&nbsp;_ConfigMaps in Kubernetes are a standard way to save cluster-wide settings.

To create a Run:AI CLI Template, you will need to save a ConfigMap on the cluster. The Run:AI CLI is then looking for ConfigMaps marked as Run:AI templates.

Template Usage

The Researcher can use the Run:AI CLI to

Show a list of templates:

<pre><em>runai template list</em></pre>

Showing the properties of a specific template:

<pre><em>runai template get &lt;my-template&gt;</em></pre>

_Use the template when submitting a workload_

<pre><em>runai submit &lt;my-job&gt; --template &lt;my-template&gt;</em></pre>

For further details, see the Run:AI command line reference <a href="https://support.run.ai/hc/en-us/articles/360011548039-runai-template" target="_self">template</a>&nbsp;&nbsp;and <a href="https://support.run.ai/hc/en-us/articles/360011436120-runai-submit" target="_self">submit</a> functions

# Template Syntax

A template looks as follows:

<pre>apiVersion: v1<br/>kind: ConfigMap<br/>data:<br/>  name: cli-template1<br/>  description: "my first template"<br/>  values: |<br/>    image: gcr.io/run-ai-lab/quickstart<br/>    gpu: 1<br/>    elastic: true<br/>metadata:<br/>  name: cli-template1<br/>  namespace: runai<br/>  labels:<br/>    runai/template: "true"</pre>

Notes:

*   The template above set 3 defaults: a specific image, a default of 1 gpu and sets the "elastic" flag to true
*   The label runai/template marks the ConfigMap as a Run:AI template.&nbsp;
*   The name and description will show when using the_ runai template list_ command

To store this template run:

<pre>kubectl apply -f &lt;template-file-name&gt;&nbsp;</pre>

For a complete list of template values, see the end of this document

# The Default Template

The administrator can also set a default template that is always used on _runai submit_&nbsp;whenever a template is __not__ specified. To create a default template use the annotation&nbsp;_<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">runai/default</span><span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">: </span><span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">"true".&nbsp;</span>_<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Example:</span>

<div>
<pre>apiVersion: v1<br/>kind: ConfigMap<br/>data:<br/>  name: cli-template1<br/>  description: "my first template"<br/>  values: |<br/>    volume:<br/>    - '/path/on/host:/dest/container/path'<br/>metadata:<br/>  name: cli-template1<br/>  namespace: runai<br/><strong>  annotations:</strong><br/><strong>    runai/default: "true"</strong><br/>  labels:<br/>    runai/template: "true"</pre>
<p>Sets a default template which mounts a volume</p>
</div>

# Syntax of all Values

The following template sets all runai submit flags.

<pre>apiVersion: v1<br/>kind: ConfigMap<br/>data:<br/>  name: "all-cli-flags"<br/>  description: "A sample showing all possible flag overrides via a template"<br/>  values: |<br/>    project: "team-ny"<br/>    image: ubuntu<br/>    gpu: 1<br/>    cpu: 0.5<br/>    memory: 1G<br/>    elastic: false<br/>    interactive: true<br/>    node_type: "dgx-1"              # --node-type<br/>    hostIPC: false                  # --host-ipc <br/>    shm: false                      # --large-shm <br/>    localImage: false               # --local-image<br/>    serviceType: "loadbalancer"     # -- service-type<br/>    ttlSecondsAfterFinished: 30     # --ttl-after-finish<br/>    environmentDefault:<br/>    - 'LEARNING_RATE=0.25'<br/>    - 'TEMP=302'<br/>    portsDefault:<br/>    - '80:8888'<br/>    - 9090<br/>    command:<br/>    - 'sleep'<br/>    args:<br/>    - 'infinity'<br/>    volumeDefault:<br/>    - '/etc:/dest/container/path'<br/>    <span>workingDir: "/etc".             # --working-dir</span><br/>metadata:<br/>  name: cli-all-flags<br/>  namespace: runai<br/>  labels:<br/>    runai/template: "true"</pre>

&nbsp;
&nbsp;