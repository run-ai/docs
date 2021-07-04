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

Now open the Researcher user interface, find the _Requested GPU_ box. Verify that the default is set to 1, that it is possible to edit the value to any number between 1 and 4 at 0.2 increments. 

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

### Integer

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
* `min/max`: if provided,mandate a range for this parameter.

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

### Number 

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
* `options`: list of strings. The list is a closed list (no new values can be added by the Researcher). 


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

### Array of Strings

Set a list of strings. The syntax is:

``` YAML
{name}:
  required: {true|false}
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


###  String to String Mapping

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
      LEARNING_RATE: 0.1
      EPOCHS: 100
```

Two environment variables are sent to the container: LEARNING_RATE

* LEARNING_RATE: with a default value of 0.1, which the Researcher can override. 
* EPOCHS: with a default of 100, which the Researcher __cannot__ override. 


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

* `default.editable`: if `true`, the Researcher is allowed to modify the value of this parameter and add new values. Default is true
* `default.value`: if provided, serves as the default key-value set for this parameter.


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
