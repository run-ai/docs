# Configure Command-Line Interface Templates

## What are Templates?

Templates are a way to reduce the manual entry required when submitting Jobs and to limit the range of possible values. Templates can be used with the Command-line interface and with the [Researcher User Interface](researcher-ui-setup.md). 

<!-- The Researcher can:

*   Use a template by running `runai submit --template <template-name>`
*   Review list of templates by running `runai list template`
*   Review the contents of a specific template by running ``runai describe template <template-name>`` -->

There are two template _levels_:

* Using the Researcher user interface, __Researchers__ can create, modify and delete templates for personal use.
* Administrators can create __administrative templates__ which set cluster-wide defaults and constraints and defaults for the submission of Jobs. 

The purpose of this document is to provide the Administrator with guidelines on how to create & maintain __administrative__ templates.

## Templates and Kubernetes

CLI Templates are implemented as Kubernetes [ConfigMaps](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/){target=_blank}. A Kubernetes ConfigMap is the standard way to save cluster-wide settings.

### Creating your First Administration Template 

There are two available administration templates: 
* An administration template for interactive Jobs
* An administration template for training Jobs

To create an __interactive__, administration template, create a file (e.g. `my-template.yaml`) and try this sample template:

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
The template places a default and limit on the available values for  _gpu_.  

Similarly, you can create a __training__ administration template by using the name `job-settings-training` instead.


To store this template run: 

``` bash
kubectl apply -f my-template.yaml 
```

Now open the Researcher user interface, under the _Resource Allocation_ category, find the _Requested GPU_ box. Verify that the default is set to 1, that it is possible to edit the value to any number between 1 and 4 at 0.2 increments. 

## Template parameters

Administrative template can be used to configure all Run:AI Job submittion parameters. You can find the full list of parameters under the Command-line documentation of [runai submit](../../Researcher/cli-reference/runai-submit.md) and [runai submit-mpi](../../Researcher/cli-reference/runai-submit-mpi.md).


## Syntax

Template parameters are written in _Camel Case_ notation. For example, the Command-line flag `--host-network` is written as `hostNetwork`. For a full list of parameters and their correct spelling, type, and syntax, see the [Run:AI Submit REST API](../../developer/researcher-rest-api/rest-submit.md).  

The following section describe the syntax of the various parameter types.

### Boolean

A Boolean parameter accepts two values: `true` and `false`. The syntax is: 

``` YAML
{parameter name}:
  required: {true|false}
  default:
    value: {true|false}      
    editable: {true|false}
```

Description:

* `required`: is the parameter mandatory for submitting a Job.  XXX is there a default? 
* `default.value`: if provided, serves as the default value for this parameter.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter.    XXXX the default is editable. Right?

Example: Mandate the disabling of host network: 

``` YAML
hostNetwork:
  required: true
  default:
    value: false
    editable: false
```

### Integer

An Integer parameter accepts whole numbers. The syntax is: 

``` YAML
{name}: 
  required: {true|false}
  default:
    value: {integer}      
    editable: {true|false}
  min: {integer}
  max: {integer}
  format: {port}   XXX REMOVE THIS??? There are no standalone ports. 
```

Description:

* `required`: is the parameter mandatory for submitting a Job.
* `default.value`: if provided, serves as the default value for this parameter.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter.
* `min/max`: if provided,mandate a range for this parameter.
* `format`: allows for special formats. Currently, the only format available is `port` which mandates a valid port number (between 1 and 65535).

Example: Set a limit to hyperparameter optimization parallelism:

``` YAML
parallelism:
  required: false
  default:
    value: 3
    editable: true
  min: 1
  max: 50
```

### Number 

A Number (or "Double") parameter accepts any number including non-integer numbers. The syntax is: 

``` YAML
{name}: 
  required: {true|false}
  default:
    value: {float}      
    editable: {true|false}
  min: {float}
  max: {float}
  step: {float}
```

Description:

* `required`: is the parameter mandatory for submitting a Job.
* `default.value`: if provided, serves as the default value for this parameter.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter.
* `min/max`: if provided,mandate a range for this parameter.
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

### String

A String parameter accepts any text. The syntax is: 

``` YAML
{name}: 
  required: {true|false}
  default:
    value: {string}      
    editable: {true|false}
  options:
    - {string1}
    - {string2}
    ...
```

Description:

* `required`: is the parameter mandatory for submitting a Job.
* `default.value`: if provided, serves as the default value for this parameter.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter.
* `options`: list of strings. The list provides the XXXX editable works?


Example: set a closed list of possible images.

``` YAML
image: 
  required: true
  default:
    value: gcr.io/run-ai-demo/quickstart     
    editable: false
  options:
    - gcr.io/run-ai-demo/quickstart
    - gcr.io/run-ai-demo/quickstart-distributed
    - gcr.io/run-ai-demo/quickstart-hpo
```

### Array of Strings

Set a list of strings. The syntax is:

``` YAML
{name}:
  required: {true|false}
  default:
    value: 
      {string1},
      {string2},
      ...
    editable: {true|false}
```

Description:

* `required`: is the parameter mandatory for submitting a Job.
* `default.value`: if provided, serves as the default value for this parameter.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter.
* `options`: list of strings. All strings are part of the default value


Example: arguments to a command

``` YAML
arguments:
  required: false
  default:
    value: 
      '-X',
      '-b 20',
      ...
    editable: true
```


###  String to String Mapping

A set of mapping of string to a string. The syntax is: 

``` YAML
{name}:
  default:
    value: 
      {key1}: {value1},
      {key2}: {value2},
      ...
    editable: {true|false}
```

Description:

* `required`: is the parameter mandatory for submitting a Job.
* `default.value`: if provided, serves as the default key-value set for this parameter.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter.


Example: 

``` YAML
environment:
  default:
    value:
      LEARNING_RATE: 0.1
      EPOCHS:
        editable: false
        value: 100
```

Two environment variables are sent to the container: LEARNING_RATE

BIN: with a default value /usr/local/bin, which the researcher can override. 

HOME: with a default /home, which the user cannot override. 


### Special: Array of PVCs

An array of Persistent Volume Claims (PVC) provides a way to provide a default for attaching multiple PVCs to a container. The syntax is: 

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
???? XXX  No required?
* `default.value`: if provided, serves as the default key-value set for this parameter.
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter.


Example:

``` YAML
pvc:
  default:
    editable: false
    value:
      pvc1:
        storageClass: local_path
        size: 3Gi
        path: /etc/path1
        readOnly: true
      pvc2:
        ....
```

### Special: Array of Port Maps

An array of port maps. The syntax is:

``` YAML
ports:
  default:
    value: 
      {port-map-id1}:
        container: {containerPort}
        external: {hostPort}
        autoGenerate: {true|false}
      {port-map-id2}:
        container: {containerPort}
        external: {hostPort}
        autoGenerate: {true|false}        
    editable: {true|false}
```

Description: 
???? No required?
* `default.value`: if provided, serves as the default key-value set for this parameter. XXX
* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter.
XXX

Example: 

``` YAML
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

## Override rules

XXX 

## Deleting a Template
to delete the template, run:

```
kubectl delete cm my-template.yaml
```

## See Also

* For a full list of parameters and their correct spelling, type and syntax, see the [Run:AI Submit REST API](../../developer/researcher-rest-api/rest-submit.md).  

* For a list of `runai submit` flags, see the Run:AI [runai submit reference](../../Researcher/cli-reference/runai-submit.md)

* For a list of `runai submit-mpi` flags, see the Run:AI [runai submit-mpi reference](../../Researcher/cli-reference/runai-submit-mpi.md)
