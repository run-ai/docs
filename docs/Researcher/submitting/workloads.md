# Submitting Workloads

## Overview

Run:ai supports multiple channels for submitting workloads:

* The _New Job_ form of the user interface. 
  See [researcher user interface](../../admin/researcher-setup/researcher-ui-setup.md).
  
* The 
  [submit](../cli-reference/runai-submit.md) and 
  [submit-mpi](../cli-reference/runai-submit-mpi.md) commands of the 
  run:ai command line interface.
  
* Workload submission from a YAML file, as illustrated later in this guide. 

In all these channels, the researcher submitting the workload has to provide
values for a set of parameters that the system uses in order to compose the
workload and any additional resources it requires, such as services, 
volumes etc.

This set of values are sent to Kubernetes, which orchestrates the execution of the 
workload, by means of a [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources) (CR).

The following workload resources are supported:
* InteractiveWorkload: For submission of interactive jobs.
* TrainingWorkload: For submission of training job.
* DeploymentWorkload: For submission of inference deployments.

For generality, we will refer to all these kinds as "workload resources".

The CLI and the user interface are responsible for creating the necessary workload
resource with all the values provided via the CLI parameters or the _New Job_ fields.
These workload resources, which are automatically created for the researcher, can be used
later on as templates for submitting additional workloads with similar parameters, reducing 
manual input. See [templates guide](../../admin/researcher-setup/templates.md) for further details.

Users can also submit workloads using YAML files. Each YAML file should contain the definition
of the desired workload resource. The workload is submitted using kubectl commands, as explained later in this guide.

## Policies

In addition to workload resources, there is also a set of policies, created and maintained by the administrator. 

Policies serve two purposes:
1) To impose guidelines on the values a researcher can specify for each parameter.
2) To provide default values to various parameters.

Each kind of workload resource has a matching kind of workload policy: InteractivePolicy
resources govern InteractiveWorkload resources, TrainingPolicy resources govern
TrainingWorkload resources, etc. Policy of each kind can be defined per-project, and there
is also a global policy which applies to any project not having per-project policy.

Further details about policies can be found in the [policies guide](../../admin/researcher-setup/policies.md).

## Workload Usage

### Introduction

A key parameter in each workload resource is `usage`, which determines the 
usage of this workload resource. 

Two possible usages are supported:

1) Submit: This is the default usage. It indicates to the system that it should
use the set of values specified in the spec of this workload resource for submitting a workload. 

2) Template: When the usage of the workload resource is set to Template, it indicates
   to the system that the set of values contained in the spec of this workload
   resource should be used as defaults for other workloads. 
   These workload resources are simply called Templates. Further details about
   templates can be found in the  [template guide](../../admin/researcher-setup/templates.md).
   
In this document we will refer to workloads as submission workloads and templates, accordingly.

### Template Example

Consider the following YAML file, named `team-a-jupyter-defaults.yaml`:
``` YAML
apiVersion: run.ai/v1alpha1
kind: InteractiveWorkload
metadata:
  name: team-a-jupyter-defaults
  namespace: runai-team-a
spec:
  usage: Template
  jupyter:
    value: true 
  image:
    value: jupyter/scipy-notebook
```
This YAML file contains the definition of an InteractiveWorkload resource
named `team-a-jupyter-defaults` in project with namespace `runai-team-a`. Note that
`usage=Template`, indicating that this workload resource can only be used as a Template,
providing default values to other workload resources.

In order to apply this YAML, run the following command:
```bash
kubectl apply -f team-a-jupyter-defaults.yaml
```
In order to list all InteractiveWorkloads in `runai-team-a`
run the following command:
```bash
kubectl get -n runai-team-a InteractiveWorkload 
```
Alternatively, you can use the run:ai CLI command:
```bash
runai list workloads --interactive --project team-a
```
Following is an example for the command output:
```
WORKLOAD                   USAGE     PROJECT/GLOBAL
team-a-jupyter-defaults    Template  team-a
```
### Submit Example

The following YAML file, `my-jupyter-job.yaml`, contains the definition of 
another InteractiveWorkload resource:

``` YAML
apiVersion: run.ai/v1alpha1
kind: InteractiveWorkload
metadata:
  name: my-jupyter-job
  namespace: runai-team-a
spec:
  gpu:
    value: "1"
  jobNamePrefix: 
    value: "jupyter"
```
Running the kubectl command:
```bash
kubectl apply -f team-a-jupyter-defaults.yaml
```
Should create this workload resource just as in the previous example, however - the impact of creating 
the workload resource is significantly different. 

Running:
```bash
runai list workloads --interactive --project team-a
```
Will show the newly created workload resource with `usage=Submit`, as opposed to the other workload 
resource which has `usage=Template`:
```bash
WORKLOAD                   USAGE     PROJECT/GLOBAL
my-jupyter-job             Submit    team-a
team-a-jupyter-defaults    Template  team-a
```

The following section will elaborate the difference between the two.

### Template vs Submission Workload Resources 

To realize the difference between the two usages of workload resources, we will use the command:
```bash
runai describe --interactive {workload-name}
```
Let's run this command with `workload-name` set to `team-a-jupyter-defaultsLet`:

```bash
──────◆  team-a-jupyter-defaults  ◆──────

Project:  team-a
image:    jupyter/scipy-notebook
jupyter:  true
```
As expected, the output of the describe command lists the default values included
in the template, as the only role of a template is to provide defaults.

Now let's compare this to `describe workload` command of `my-jupyter-job`:
```bash
──────◆  my-jupyter-job  ◆──────

Project:        ofer1e
gpu:            1
jobNamePrefix:  jupyter

Status:  Submitted

Events: 

AGE  TYPE  MESSAGE
---  ----  -------
29m  Info  all the resources were created successfully

Created Resources: 

KIND       VERSION    NAMESPACE     NAME
----       -------    ---------     ----
ConfigMap  v1         runai-ofer1e  jupyter-1
RunaiJob   run.ai/v1  runai-ofer1e  jupyter-1
Service    v1         runai-ofer1e  jupyter-1-jupyter

Created job: 

Name: jupyter-1
Namespace: runai-ofer1e
Type: Interactive
Status: Running
...
Pods:
POD            STATUS   TYPE         AGE  NODE
jupyter-1-0-0  RUNNING  INTERACTIVE  29m  dev-ofer-high-cpu/10.0.1.7
```

This time, the set of values contained in the workload resource were used for submitting a workload.

The output resources that the system created are listed in the `Created Resources` section. 
For this workload resource, three resources were created:
* A RunaiJob, to run the jupyter notebook. 
* A Service, for connecting to the notebook.
* A ConfigMap, which is created for internal purposes. 

The details of the runaijob, `jupyter-1`, are listed in the `Created job` section. 
As the command output indicates, the job is already running. 

A workload resource which submitted all its output resources successfully, is marked with `Status: Submitted`.
Failure to create any output resource that the workload requires, would mark the workload resource with `Status: Failed`. 
The reason for failure can be found in the Events section of the status section.

To summarize this: 
* Workload resources with `usage=Submit` would attempt to create a workload and all the necessary
resources for its execution, according to the values of the workload resource.
* Workload resources with `usage=Template` are only used as containers of defaults to be
used by other workload resources.

!!!Note
A workload resource with  `usage=Submit` can only be used for submission of a single workload. In order to 
submit another workload, another workload resource with  `usage=Submit` must be created. Therefore, it is suggested
to suffix the workload name with a number or a time stamp. Workload resources which the CLI or the user interface create, 
will have a time stamp as suffix.

### Values Set 

In the previous example, an interactive job has been created by a workload resource.
Looking at the values listed in the `describe workload` output, indicate that values comprising this job
has been collected from multiple sources:
* The name of the job, `jupyter-1`, has been prefixed according to `jobNamePrefix: jupyter`, which was
specified in `my-jupyter-job`.
* Similarly, the number of requested GPUs, 1, has been determined by `gpu: 1`, also specified in `my-jupyter-job`.
* The image of the job, however, has been determined by the default `image: jupyter/scipy-notebook`, which
was specified in `team-a-jupyter-defaults`.
  
The complete set of values comprising the job is called Values Set, and it is a combination of up to three sources:
* The workload resource being submitted - itself.
* An optional workload which provides its values as defaults.
* Defaults specified in the policy associated with the kind of workload being submitted, which had been created by the administrator.

The policy is automatically fetched by the system while composing the values set. 

Associating optional workload resource for providing defaults (a.k.a. "baseWorkload") is accomplished in one of the following ways:
* When submitting the workload from the user interface, the list of workloads associated with the selected
project is displayed on the left side of the _New Job_ form. The researcher can chose to load any one of them to the form. 
  Its values will automatically fill the relevant fields of the form. 
* When submitting the workload using the CLI, a `--workload` parameter can be used to specify the name
of the base workload.
* When submitting the workload from a YAML file, a `baseWorload` parameter can be used to specify the name of the base
workload. Note the example above, `my-template` had  `baseWorkload: team-a-jupyter-defaults`, identifying this workload 
  resource as the base workload.
  
The rule is that any workload resource can be used as baseWorkload, but only workload resources with `usage=Submit` can specify `baseWorkload`:
a template cannot "borrow" defaults from another workload.

!!!Note
It is possible that an attempt to use a previously created workload resource as the base workload will be rejecte due to 
changes of policy. For example: if the workload resource specify `gpu: 5`, which was valid at the time it has been created,
but the operator changed the policy to `gpu: max: 3`, any attempt to use this workload will fail, with
a reason explaining that the number of GPUs requested by this workload is no longer valid according to the administrator's policy.

### Itemized Values

Recall that some parameters included in the workload resource are "itemized", in the sense that they 
can receive multiple values. For example: multiple ports, multiple volumes, etc.

A base workload can override a default value of the policy (if policy permits modifying this value).
Similarly, a workload with `usage=Submit` can override a default value in either the policy or its
base workload (as long as policy permits it).

When the value is itemized, a workload can delete a value specified in its base workload or in the
relevant policy, as long as policy permits it. 

When submitting from the user interface, the _New Job_ form is responsible for doing this book-keeping.
However, when creating a workload from YAML, it is the researcher or the developer of the YAML who 
is responsible for setting this up correctly. 

Following is an example.

Consider the following policy:

``` YAML
apiVersion: run.ai/v1alpha1
kind: InteractivePolicy
metadata:
  name: interactive-policy
  namespace: runai
spec:
  ports:
    items:
      admin-port-a:
        value:
          container: 30100
          external: 8080
      admin-port-b:
        value:
          container: 30101
          external: 8081
```
The following template:
``` YAML
apiVersion: run.ai/v1alpha1
kind: InteractiveWorkload
metadata:
  name: team-a
  namespace: runai-team-a
spec:
  usage=Template
  ports:
    items:
      admin-port-a:
        value:
          container: 30100
          external: 8100
      team-a-port:
        value:
          container: 30111
          external: 8111
```
And finally, the following workload:
``` YAML
apiVersion: run.ai/v1alpha1
kind: InteractiveWorkload
metadata:
  name: my-ports
  namespace: runai-team-a
spec:
  ports:
    items:
      admin-port-b:
        deleted: true
      my-port:
        value:
          container: 30222
          external: 8222
```
The following table summarize the set of ports, as collected from all sources:

| Label         | Policy      | team-a      | my-ports    | RESULT
| ------------- | ----------- | ----------- | ----------  | ---------
| admin-port-a  | 30100:8080  | 30100:8100  |             | 30100:8100
| admin-port-b  | 30101:8081  |             | (deleted)   | (obsolete)
| team-a-port   |             | 30111:8111  |             | 30111:8111
| my-port       |             |             | 30222:8222  | 30222:8222

As you can see, each source of parameters can add, edit and delete - as long as it is permitted by the policy.
The end result is a combination of all the sources, merged by the item labels.

!!!Note
When overriding an itemized value, all the member fields must be provided. For example,
it is not possible to specify only the container port id, assuming the external port id will
be "borrowed" from a policy or a base workload. Once port is specified, all its members must be provided.

## See Also

*   See [policies configuration](../../admin/researcher-setup/policies.md) for a description on policies.
*   See [template configuration](../../admin/researcher-setup/templates.md) for a description on templates.

