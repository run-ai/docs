# Configure Command-Line Interface Templates

## What are Templates?

Templates are a way to reduce the number of flags required when using the Command-Line Interface to start workloads. The researcher can:

*   Use a template by running `runai submit --template <template-name>`
*   Review list of templates by running `runai list template`
*   Review the contents of a specific template by running ``runai describe template <template-name>``

The purpose of this document is to provide the Administrator with guidelines on how to create & maintain templates.

## Template and Kubernetes

CLI Templates are implemented as Kubernetes [ConfigMaps](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/){target=_blank}. A Kubernetes ConfigMap is the standard way to save cluster-wide settings.

### Creating a Template 

To create a template, create a file (e.g. `my-template.yaml`) with:

``` YAML
apiVersion: v1
kind: ConfigMap
data:
  name: template-1
  description: "my first template"
  values: |
    gpu: 
      required: true
    image:
      value: tensorflow/tensorflow:1.14.0-gpu-py3
    environments:
      - LEARNING_RATE=0.2
      - MYUSER=$USER
      - MYPASSWORD=SECRET:my-secret,cred-pass
metadata:
  name: template-1
  namespace: runai
  labels:
    runai/template: "true"
```

To store this template run: 

``` 
kubectl apply -f my-template.yaml 
```

!!! Notes
    *   The template above sets the following:
        * That --gpu (or -g) is a required field when using this template
        * The default image file will be `tensorflow/tensorflow:1.14.0-gpu-py3`. The user can override this value and use a different image by setting the --image (-i) flag. 
        * There are two environment variables set `LEARNING_RATE` and `MYUSER`. Note that `MYUSER` will be set at runtime according to the value of `$USER`. The user can __add__ environment variables, and __override__ existing ones.  
        * `MYPASSWORD` is set from a Kubernetes secret. For further information see [Setting secrets in Jobs](use-secrets.md) 
    *   The label `runai/template` marks the ConfigMap as a Run:AI template.
    *   The name and description will show when using the `runai template list` command.
    *   See additional information below on flag syntax.


To see this template in the template list run:

```
runai list template
```

To show the properties of the created template run:

```
runai describe template template-1
```

Use the template when submitting a workload

```
runai submit my-job1 ....  --template template-1
```



## Syntax

* When specifying a single-value flag, use the full name of the flag. For example, for setting `--gpu` use `gpu`. For a list of flags, see the [runai-submit reference document](../../Researcher/cli-reference/runai-submit.md). 
* When specifying a multi-value flag, use the _plural_ of the flag name. For example: for setting the `--environment` flag use `environments`. For setting the `--volume` flag. Use `volumes` 
* When specifying a single value flag, use the syntax:
``` YAML
single-value-flag:
    required: true/false
    value: string
```
* When specifying a multi-value flag, use the syntax:
``` YAML
multi-value-flag:
  - value1
  - value2
  - ...
```

## The Default Template

The Administrator can also set a template that is always active:

``` YAML
apiVersion: v1
kind: ConfigMap
data:
  name: template-admin
  description: "my first template"
  values: |
    job-name-prefix:
      value: acme
    volumes:
      - /mnt/nfs-share/john:/workspace/john
metadata:
  name: template-admin
  namespace: runai
  labels:
    runai/template: "true"

```

!!! Notes
    * The template is denoted as the __admin__ template with the name `template-admin`


# Override rules

* The User, when running `runai submit` always overrides the default template and a template specified with `--template`
* The default template overrides any specified template.

## Deleting a Template
to delete a template, run:

```
kubectl delete cm -n runai <template-name>
```

## See Also

For a list of `runai submit` flags, see the Run:AI [command-line reference](../../Researcher/cli-reference/runai-submit.md)
