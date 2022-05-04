# Configure Templates

## What are Templates?

Templates are a way to reduce the manual entry required when submitting jobs and to limit the range of possible values. 
Templates can be used with the Command-line interface and with the [Researcher User Interface](researcher-ui-setup.md).

There are two _levels_ of templates:

* __Administrative templates__: These templates are created and maintained by an administrator and are applied to researchers' work. Their purpose is to enforce organizational standards on jobs being submitted. Administrative templates are manually created by the administrator as Kubernetes resources.
* __User templates__: These templates can be created and maintained by researchers. Their purpose is to reduce manual entry required when submitting jobs. User templates are created and maintained in the [Researcher User Interface](researcher-ui-setup.md).

The purpose of this document is to provide the Administrator and the Researchers with guidelines on how to create, maintain and use __administrative__ and __user__ templates.

## Templates and Kubernetes

All Templates (administrative and user templates) are implemented as Kubernetes [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/){:target="_blank"}. A Kubernetes ConfigMap is a standard way to save settings.

## Administrative Templates

### Creating your First Administrative Template 

There are two available administrative templates: 

* An administrative template for interactive Jobs
* An administrative template for training Jobs

To create an __interactive__, administrative template, create a file (e.g. `my-template.yaml`) and try this sample template:

``` YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: job-settings-interactive
  namespace: runai
  labels:
    type: job-settings
data:
  fields: |
    gpu:
      required: true
      default: 
        value: 1
        editable: true
      min: 1
      max: 4  
      step: 0.2
```
The template places a default and limit on the available values for GPU allocation.  

Similarly, you can create a __training__ administrative template by using the metadata name `job-settings-training` instead.

To store this template run: 

``` bash
kubectl apply -f my-template.yaml 
```

Now open the Researcher user interface, find the _Requested GPU_ box. Verify that the default is set to 1, that it is possible to edit the value to any number between 1 and 4 at 0.2 increments. 

### Administrative Template parameters

Administrative template can be used to configure all Run:ai Job submission parameters. You can find the full list of parameters under the Command-line documentation of [runai submit](../../Researcher/cli-reference/runai-submit.md) and [runai submit-mpi](../../Researcher/cli-reference/runai-submit-mpi.md).

### Syntax

Administrative Template parameters are written in _Camel Case_ notation. For example, the Command-line flag `--host-network` is written as `hostNetwork`. 

The following section describes the syntax of the various parameter types.

#### Boolean

A Boolean parameter accepts two values: `true` and `false`. The syntax is: 

``` YAML
{parameter name}:
  required: {true|false}
  default:
    editable: {true|false}
    value: {true|false}      
```

Description:

* `required`: is the parameter mandatory for submitting a Job. Default is false. 
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter. Default is true
* `default.value`: if provided, serves as the default value for this parameter.

Example: Mandate the disabling of host network: 

``` YAML
hostNetwork:
  required: true
  default:
    editable: false
    value: false
```

#### Integer

An Integer parameter accepts whole numbers. The syntax is: 

``` YAML
{name}: 
  required: {true|false}
  default:
    editable: {true|false}
    value: {integer}      
  min: {integer}
  max: {integer}
```

Description:

* `required`: is the parameter mandatory for submitting a Job. Default is false. 
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter. Default is true
* `default.value`: if provided, serves as the default value for this parameter.
* `min/max`: if provided, mandates a range for this parameter.

Example: Set a limit to hyper-parameter optimization parallelism:

``` YAML
parallelism:
  required: false
  default:
    editable: true
    value: 3
  min: 1
  max: 50
```

#### Number 

A Number (or "Double") parameter accepts any number including non-integer numbers. The syntax is: 

``` YAML
{name}: 
  required: {true|false}
  default:
    editable: {true|false}
    value: {float}      
  min: {float}
  max: {float}
  step: {float}
```

Description:

* `required`: is the parameter mandatory for submitting a Job. Default is false. 
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter. Default is true
* `default.value`: if provided, serves as the default value for this parameter.
* `min/max`: if provided, mandates a range for this parameter.
* `step`: mandates the values to fall within fixed steps between the minimum and maximum values. For example, the configuration min=1, max=2, steps=0.2 will yield valid values of 1.0, 1.2, 1.4, 1.6, 1.8, 2.0

Example: Set a limit to the number of GPUs being requested:

``` YAML
gpu:
  required: true
  default: 1
  min: 1
  max: 4 
  step: 0.1
```

#### String

A String parameter accepts any text. The syntax is: 

``` YAML
{name}: 
  required: {true|false}
  default:
    editable: {true|false}
    value: {string}      
  options:
    - {string1}
    - {string2}
    ...
```

Description:

* `required`: is the parameter mandatory for submitting a Job. Default is false.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter. Default is true
* `default.value`: if provided, serves as the default value for this parameter.
* `options`: list of strings. The list is closed (no new values can be added by the Researcher). 


Example: set a closed list of possible images.

``` YAML
image: 
  required: true
  default:
    editable: true
    value: gcr.io/run-ai-demo/quickstart     
  options:
    - gcr.io/run-ai-demo/quickstart
    - gcr.io/run-ai-demo/quickstart-distributed
    - gcr.io/run-ai-demo/quickstart-hpo
```

#### Array of Strings

Set a list of strings. The syntax is:

``` YAML
{name}:
  default:
    editable: {true|false}
    value: 
      {id1} : {string1}
      {id2} : {string2}
      ...
```

Description:

* `default.value`: if provided, serves as the default value for this parameter.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter and add new values. Default is true
* `options`: list of strings. All strings are part of the default value
*  `id1`, `id2` etc are _unique_ arbitrary strings. 


Example: arguments to a command

``` YAML
arguments:
  default:
    editable: true
    value: 
      'param1' : '-X'
      'param2' : '-b 20'
```


####  String to String Mapping

A set of mapping of string to a string. The syntax is: 

``` YAML
{name}:
  default:
    editable: {true|false}
    value: 
      {key1}: {value1}
      {key2}: {value2}
      ...
```

Description:

* `default.value`: if provided, serves as the default key-value set for this parameter.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter and add new values. Default is true


Example: 

``` YAML
environment:
  editable: true
  default:
    value:
      LEARNING_RATE: "0.1"
      EPOCHS: "100"
```

Note that environment variables are strings, so they must be surrounded by quotes. 


#### Special: Array of PVCs

An array of Persistent Volume Claims (PVC) provides a way to specify a default set of PVCs 
that will be attached to any container. 

The syntax is: 

``` YAML
pvc:
  default:
    value: 
      {pvc-id1}:
        storageClass: {class}
        size: {size}
        path: {path}
        readOnly: {true|false}
      {pvc-id2}:
        storageClass: {class}
        size: {size}
        path: {path}
        readOnly: {true|false}
    editable: {true|false}

```

Description: 

* `default.value`: if provided, serves as the default set of claims.
* `default.editable`: if `true`, the Researcher is allowed to extend the default
  set with additional claims. Default is true.


Example:

``` YAML
pvc:
  default:
    editable: false
    value:
      pvc1:
        storageClass: local-path
        size: 3Gi
        path: /etc/path1
        readOnly: true
      pvc2:
        ....
```

#### Special: Array of Volumes

An array of volumes provides a way to specify a default
set of volumes that will be attached to any container

The syntax is:

``` YAML
volumes:
  default:
    value: 
      {volume-id1}:
        sourcePath: {path}
        targetPath: {path}
        readOnly: {true|false}
      {volume-id2}:
        sourcePath: {path}
        targetPath: {path}
        readOnly: {true|false}
    editable: {true|false}

```

Description:

* `default.value`: if provided, serves as the default set of volumes.
* `default.editable`: if `true`, the Researcher is allowed to extend the default set with additional volumes. 
  Default is true.


Example:

``` YAML
volumes:
  default:
    editable: false
    value:
      pvc1:
        sourcePath: /home
        targetPath: /usr/local/users
        readOnly: {true|false}
      pvc2:
        ....
```

#### Special: Array of Port Maps

An array of port maps. The syntax is:

``` YAML
ports:
  default:
    editable: {true|false}
    value: 
      {port-map-id1}:
        container: {containerPort}
        external: {hostPort}
        autoGenerate: {true|false}
      {port-map-id2}:
        container: {containerPort}
        external: {hostPort}
        autoGenerate: {true|false}        
```

Description: 

* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter and add new values. Default is true
* `default.value`: if provided, serves as the default key-value set for this parameter. 

!!! Note
    Ports will not be set without settings the `serviceType` flag as well. 


Example: 

``` YAML
serviceType: nodeport
ports:
  port1:
    container: 8443
    external: 443
    autoGenerate: true
  port2:
    container: 4500
    external: 4500
    autoGenerate: false
```

### Using Shell Variables in Templates

It is possible to add shell variables to administrative templates. The shell variable will be evaluated at Job creation time. For example:  

``` YAML
environment:
  editable: true
  default:
    value:
      MYUSER: $USER
```
The container created will have an environment variable called `MYUSER` with the value of the Linux `$USER` variable as defined in the running host machine. 

!!! Note
    Shell variables are only active with the Run:ai Command-line interface. They are not available via the Researcher user interface.

### Using Secrets in Templates

It is possible to add values from Kubernetes secrets to administrative templates. The secret will be extracted from the secret object when the Job is created. For example:  


``` YAML
environment:
  editable: true
  default:
    value:
      MYPASSWORD: "SECRET:my-secret,password"
```

When submitting the job under Project `team-a` the container created will have an environment variable called `MYPASSWORD` whose value is the key `password` residing in Kubernetes secret `my-secret` which has been pre-created in namespace `team-a`. 

!!! Note
    * Run:ai provides a secret propagation mechanism from the `runai` namespace to all project namespaces. For further information see [secret propagation](../use-secrets/#secrets-and-projects)
    * Secrets are only active with the Run:ai Command-line interface. They are not available via the Researcher user interface.

### Fields and Defaults

The following fields are possible. Also included are the field defaults if no administrative template is defined. For an explanation of the field, see the `runai submit` documentation. 


|  Flag           |   Mandatory |    UI Default    |  Range/Options | 
|-----------------|-------------|------------------|----------------|
| arguments       | -           |                  |        |
| backoffLimit    | -           |       6          |        |  
| command         | -           |                  |        | 
| completions     | -           |       1          |        |   
| cpu             | -           |       1          | min: 0, max: 100, step: 0.1       |
| cpuLimit        | -           |                  | min: 0, max: 100, step: 0.1       |
| createHomeDir   | -           |    `false`       |        | 
| environment     | -           |                  |        |
| gpu             | -           |       1          | min: 0, max: 100, step: 0.1       |
| hostIpc         | -           |    `false`       |        | 
| hostNetwork     | -           |    `false`       |        | 
| image           | yes         |                  |        |
| imagePullPolicy | yes         |    `Always`      |  `Always`, `IfNotPresent`, `Never`       |
| jobNamePrefix   | -           |                  |        |
| largeShm        | -           |    `false`       |        | 
| memory          | -           |                  |        |
| memoryLimit     | -           |                  |        |
| name            | yes         |                  |        |
| nodeType        | -           |                  |        |
| parallelism     | -           |       1          |        | 
| ports           | -           |                  |        |   
| processes       | -           |                  | min: 1 |
| project         | yes         |                  |        |
| pvc             | -           |                  |        |  
| preventPrivilegeEscalation | no | `false`        |        |
| serviceType     | -           |                  | `ingress`, `loadbalancer`, `nodeport` |  
| stdin           | -           |    `false`       |        | 
| ttlAfterFinish  | -           |                  |        |
| tty             | -           |    `false`       |        | 
| volume          | -           |                  |        | 
| workingDir      | -           |                  |        | 

### Deleting an Administrative Template
to delete the template, run:

```
kubectl delete cm my-template.yaml -n runai
```

## User Templates

A user template is a set of values, given to various submission parameters, to reduce manual input when submitting jobs.Similar to administrative templates, two sets of templates exist. One for 
interactive jobs, and the other for training jobs.

User templates are defined per Run:ai Project.   

### Creating A User Template

User templates are created and maintained in the [Researcher User Interface](researcher-ui-setup.md). Once created, A user template can be used by a researcher for submitting jobs either in the Research User Interface or using the Command-line.

To create a user template, open the Submit form in the Researcher User Interface, fill in values for parameters you would like to store in the template, and choose "Save as Template" from the actions menu. Alternatively, the set of values can be loaded from a previous job or any other existing template.

To copy a template from one project to another, select the template you wish to copy, change the selected project to the project you want to copy the template to, and use "Save As Template" to save it to the selected project.

### Using a User Template

#### Researcher User Interface

The set of available templates appears on the left side of the submission form in the Researcher User Interface. Select any template you want to use, and notice its values are applied on all the relevant parameters.

#### Command-Line

Use the following command to obtain a list of templates:
```
 runai list templates
```

Both interactive and training templates are listed.

To view the values of a user template, use the following command:
```
runai describe template {name}
```

To use a template for submitting a job, use the `--template` option of the submit command. For example:
```
runai submit --interactive --project team-a --template temp1 
```

In this example, the job is created based on an interactive template named `temp1`, of project `team-a`.

### Deleting a User Template

To delete a user template, open the Submit form in the Researcher User
Interface and click on the remove icon which appears right next to it.

## See Also

<!-- * For a full list of parameters and their correct spelling, type and syntax, see the [Run:ai Submit REST API](../../developer/researcher-rest-api/rest-submit.md).   -->

* For a list of `runai submit` flags, see the Run:ai [runai submit reference](../../Researcher/cli-reference/runai-submit.md)

* For a list of `runai submit-mpi` flags, see the Run:ai [runai submit-mpi reference](../../Researcher/cli-reference/runai-submit-mpi.md)
