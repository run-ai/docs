# Configure Templates

## What are Templates?

Templates are a way to reduce the manual entry required when submitting workloads. 

Templates can be used with the Command-line interface and with the
_New Job_ form of the user interface. They can also be
used when submitting a workload from a YAML file.

## Creating a Template

There are multiple ways to create a template:

1) In the _New Job_ form of the user interface, provide any set of values
to the various workload parameters and then click the _Save As_ button. In 
   the dialog which opens, you can choose to save the template to your
   project, or save it globally, for using it in any project.
   Saving a template globally will download it as a yaml
   file to your downloads folder. You will have to send the file to your administrator in order to apply it.
   
2) After submitting a workload, you are prompted to choose if you would 
like to save the set of parameters of the recent submission
   as a template.
3) Any submitted workload, which has not been deleted, can be used as a
template. 
4) Finally, a template can be created as a Kubernetes resource from a 
yaml file, as explained in the following sections of this guide.
   
## Templates and Kubernetes

All templates are implemented as Kubernetes [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources) (CRs)
of the following kinds:
* InteractiveWorkload: Templates for interactive jobs.
* TrainingWorkload: Templates for training jobs.
* DeploymentWorkload: Templates for inference deployments. 

As discussed in the [submitting workloads guide](../../Researcher/submitting/workloads.md), 
the primary purpose of workload resources is to hold the set of values for submitting
a workload. In order to indicate to the system that a given workload resource should be used
as a template rather than for submission, a `usage` parameter with the value `Template`
must be specified in the spec of the workload resource.

## Creating a Template from Yaml

Following is an example of a template resource yaml. To create such 
template, save its content to a file such as `jupyter-templaye.yaml`.
```yaml
apiVersion: run.ai/v1alpha1
kind: InteractiveWorkload
metadata:
  name: jupyter-template
  namespace: runai-team-a
spec:
  usage: Template
  jupyter:
    value: true
  image:
    value: jupyter/scipy-notebook
```
This template is intended for reducing the manual entry for all interactive jupyter
jobs. It sets the `jupyter` parameter to `true` and the default image to
`jupyter/scipy-notebook`. 

In order to apply the template, run the following command:
```bash
kubectl apply -f jupyter-template.yaml
```
The template resource should now reside in `runai-team-a` namespace, restricting it
only for jobs created in the project associated with that namespace (typically _team_a_ project). 

Changing the namespace to `runai` should expose it to all projects, but requires administrator privileges to apply.

### Itemized Parameters

As discussed in the [policies guide](policies.md), some parameters that 
composes the template are itemized, in the sense that they can hold multiple values. 
For example, volumes parameter is itemized, as multiple volumes can be specified 
for a given workload.

As any parameter, default values for itemized parameters can be overridden
in a template. Furthermore, items from the policy defaults can be deleted
in the workload (assuming the policy permitting deletion), and new items 
can be added (assuming the policy permitting addition).

Further details about overriding itemized parameter can be found in 
the [submitting workloads guide](../../Researcher/submitting/workloads.md).

## Using a Template

### User Interface

The set of available templates appears on the left side of the 
_New Job_ form in the user interface. Select any template you want to use, 
and notice its values are applied on all the relevant parameters.

### Command-Line

Use the following command to obtain a list of templates:
```
 runai list workloads [--interactive|--inference]
```
The command will list all templates, according to the following guidelines:
* If type flag is not specified, templates for training jobs will be listed.
* With `--interactive` flag, templates for interactive jobs will be listed.
* With `--inference` flag, templates for deployment workloads will be listed.

Following is a sample output of the command:
```
WORKLOAD                   USAGE    PROJECT/GLOBAL
my-template                Template team-a
all-jobs                   Template (global)
job-0-2022-04-16t07-49-18  Submit   team-a
```
The usage differentiate between Templates - indicating templates which were manually created
by a researcher (my-template) or by an administrator (all-jobs), to 
Submit - indicating templates which hol parameters of a previously 
submitted workload. The project/global differentiate between project specific
templates to global templates. 

To check the set of parameters included in a template, run the following command:
```bash
runai describe workload {name} [--interactive|--inference]
```

To use a template for submitting a workload, use the `--workload` option of the submit command. For example:
```
runai submit --interactive --project team-a --workload my-template 
```

In this example, the job is created based on an interactive template named `temp1`, of project `team-a`.

### Yaml

A workload created from a Yaml file can use defaults from a template. 
Further details can be found in the [submitting workloads guide](../../Researcher/submitting/workloads.md).

## Deleting a User Template

### User Interface

To delete a user template, open the Submit form in the Researcher User
Interface and click on the remove icon which appears right next to it.

### Command Line

As manually created templates cannot be created from the CLI, it is also not possible to delete such 
templates from the CLI. 

Templates which were automatically created from a submitted workload will be removed when the workload itself
is deleted. 

For example, consider the following submission:
```bash
➜  runai submit --image ubuntu
A request to submit job job-2 as been created.
You can check the status of the request by running:
	runai describe workload job-2-2022-04-16t10-54-40 -p team-a
```
As indicated in the output of the command. a template has been automatically
created for the submitted job. Running the describe command should provide
you with the following details: 

```
──────◆  job-2-2022-04-16t10-54-40  ◆──────

Project:             team-a
gpu:                 1
image:               ubuntu
imagePullPolicy:     Always
name:                job-2

Status:  Submitted

Events:

AGE  TYPE  MESSAGE
---  ----  -------
2m   Info  all the resources were created successfully

Created Resources:

KIND       VERSION               NAMESPACE     NAME
----       -------               ---------     ----
ConfigMap  networking.k8s.io/v1  runai-tema-a  job-2
RunaiJob   networking.k8s.io/v1  runai-team-a  job-2

Created job:

Name: job-2
Namespace: runai-team-a
Type: Train
Status: Succeeded
Duration: 0s
...
```
Recall that the `usage` of automatically created templates is `Submit`, as
the usage of the workload is for submission. The describe, therefore, displays
information about both template and the workload created from it (job-2). 

Running:
```bash
runai delete job job-2
```
Will delete both the job (job-2) and the automatically created template
(job-2-2022-04-16t10-54-40).

### Yaml

In order to delete a template, run:
```bash
kubectl -n {namespace} {workload-kind} {name}
```
For example, in order to delete the automatically created template for job-2 in the 
example of the previous section, run:
```bash
kubectl -n runai-team-a TrainingWorkload job-2-2022-04-16t10-54-40
```
Any template can be removed using kubectl, both having `usage=Template`
and `usage=Submit`.

## See Also

* For information on creating policies, consult the [policies guide](policies.md).
* For information on submitting workloads, consult the [submitting workloads guide](../../Researcher/submitting/workloads.md).
