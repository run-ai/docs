# Configure Policies

:octicons-versions-24: [Version 2.5](../../home/whats-new-2022.md#may-2022-runai-version-25)

## What are Policies?

Policies allow administrators to _impose restrictions_ and set _default values_ for Researcher Workloads. For example:

1. Restrict researchers from requesting more than 2 GPUs, or less than 1GB of memory for an interactive workload.
2. Set the default memory of each training job to 1GB, or mount a default volume to be used by any submitted Workload.
   
Policies are stored as Kubernetes [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources){default=_blank}.

Policies are specific to Workload type as such there are several kinds of Policies:

|  Workload Type | Kubernetes Workload Name | Kubernetes Policy Name |
|----------------|-----------------|-------------|
| Interactive    | `InteractiveWorkload` | `InteractivePolicy` |
| Training       | `TrainingWorkload`| `TrainingPolicy` |
| Inference      | `InferenceWorkload` | `InferencePolicy` |

A Policy can be created per Run:ai Project (Kubernetes namespace). Additionally, a Policy resource can be created in the `runai` namespace. This special Policy will take effect when there is no project-specific Policy for the relevant workload kind.

## Creating a Policy

### Creating your First Policy 

To create a sample `InteractivePolicy`, prepare a file (e.g. `policy.yaml`) containing the following YAML:

``` YAML title="policy.yaml"
apiVersion: run.ai/v1alpha1
kind: InteractivePolicy
metadata:
  name: interactive-policy
  namespace: runai-team-a # (1)
spec:
  gpu:
    rules:
      required: true
      min: "1"  # (2)
      max: "4"  
    value: 
      value: "1"
```

1. Set the Project namespace here
2. GPU values are quoted as they can contain non-integer values. 

The policy places a default and limit on the available values for GPU allocation. To apply this policy, run: 

``` bash
kubectl apply -f policy.yaml 
```
Now, try the following command:
``` bash
runai submit --gpu 5 --interactive -p team-a
```
The following message will appear:
```
gpu: must be no greater than 4
```
A similar message will appear in the _New Job_ form of the Run:ai user interface, when attempting to enter the number of GPUs, which is out of range for an Interactive tab.  

### Complex Values

The example above illustrated rules for parameters of "primitive" types, such as _GPU allocation_, _CPU memory_, _working directory_, etc. These parameters contain a single value. 

Other workload parameters, such as _ports_ or _volumes_, are "complext", in the sense that they may contain multiple values: a workload may contain multiple ports and multiple volumes. 

Following is an example of a policy containing the value `ports`, which is complex: The `ports` flag typically contains two values: The `external` port that is mapped to an internal `container` port. One can have multiple port tuples defined for a single Workload:

``` YAML
apiVersion: run.ai/v1alpha1
kind: InteractivePolicy
metadata:
  name: interactive-policy
  namespace: runai
spec:
  ports:
    rules:
      canAdd: true
    itemRules:
      container:
        min: 30000
        max: 32767
      external:
        max: 32767
    items:
      admin-port-a:
        rules:
          canRemove: false
          canEdit: false
        value:
          container: 30100
          external: 8080
      admin-port-b:
        value:
          container: 30101
          external: 8081
```


A policy for complext field is composed of three parts:

* __Rules__: Rules apply to the `ports` parameter as a whole. In this example, the administrator specifies `canAdd` rule with `false` value, indicating that a researcher submitting an interactive job can add additional ports to the ports listed by the policy (_true_ is the default for `canAdd`, so it actually could have been omitted from the policy above). When `canAdd` is set to `false`, the researcher will not be able to add any additional port except those already specified by the policy.
* __itemRules__: itemRules impose restrictions on the data members of each item, in this case - `container` and `external`. In the above example, the administrator has limited the value of `container` to 30000-32767, and the value of `external` to a maximum of 32767. 
* __Items__: Specifies a list of default ports. Each port is an item in the ports list and given a label (e.g. `admin-port-b`). The administrator can also specify whether a researcher can change/delete ports from the submitted workload. In the above example, `admin-port-a` is hardwired and cannot be changed or deleted, while `admin-port-b` can be changed or deleted by the researcher when submitting the Workload.
  
### Syntax

The complete syntax of the policy YAML can be obtained using the `explain` command of kubectl. For example:

```bash
kubectl explain trainingpolicy.spec
```
Should provide the list of all possible fields in the spec of training policies:

```yaml
KIND:     TrainingPolicy
VERSION:  run.ai/v1alpha1

RESOURCE: spec <Object>

DESCRIPTION:
The specifications of this TrainingPolicy

FIELDS:
annotations	<Object>
Specifies annotations to be set in the container running the created
workload.

arguments	<Object>
If set, the arguments are sent along with the command which overrides the
image's entry point of the created workload.

command	<Object>
If set, overrides the image's entry point with the supplied command.
...
```

You can further drill down to get the syntax for `ports` by running:

```bash
kubectl explain trainingpolicy.spec.ports
```

```yaml
KIND:     TrainingPolicy
VERSION:  run.ai/v1alpha1

RESOURCE: ports <Object>

DESCRIPTION:
     Specify the set of ports exposed from the container running the created
     workload. Used together with --service-type.

FIELDS:
   itemRules	<Object>

   items	<map[string]Object>

   rules	<Object>
     these rules apply to a value of type map (=non primitive) as a whole
     additionally there are rules which apply for specific items of the map
```

Drill down into the `ports.rules` object by running:

```bash
kubectl explain trainingpolicy.spec.ports.rules
```

```yaml
KIND:     TrainingPolicy
VERSION:  run.ai/v1alpha1

RESOURCE: rules <Object>

DESCRIPTION:
     these rules apply to a value of type map (=non primitive) as a whole
     additionally there are rules which apply for specific items of the map

FIELDS:
   canAdd	<boolean>
     is it allowed for a workload to add items to this map

   required	<boolean>
     if the map as a whole is required
```

Note that each kind of policy has a slightly different set of parameters. For example, an `InteractivePolicy` has a `jupyter` parameter that is not available under `TrainingPolicy`. 

### Using Secrets for Environment Variables

It is possible to add values from Kubernetes secrets as the value of environment variables included in the policy.
The secret will be extracted from the secret object when the Job is created. For example:


``` YAML
  environment:
    items:
      MYPASSWORD:
        value: "SECRET:my-secret,password"
```

When submitting a workload that is affected by this policy, the created container will have an environment variable called
`MYPASSWORD` whose value is the key `password` residing in Kubernetes secret `my-secret` which has been pre-created in
the namespace where the workload runs.

!!! Note
    Run:ai provides a secret propagation mechanism from the `runai` namespace to all project namespaces. For further information see [secret propagation](secrets.md/#secrets-and-projects)
  
## Modifying/Deleting Policies

Use the standard kubectl get/apply/delete commands to modify and delete policies.

For example, to view the _global_ interactive policy:

```bash
kubectl get interactivepolicies -n runai
```
Should return the following:
```bash
NAME                 AGE
interactive-policy   2d3h
````
To delete this policy:
```bash
kubectl delete InteractivePolicy interactive-policy -n runai
```
To access _project-specific_ policies, replace the `-n runai` parameter with the namespace of the relevant project.

## See Also

* For creating workloads based on policies, see the Run:ai [submitting workloads](../../developer/cluster-api/workload-overview-dev.md)



