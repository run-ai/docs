# Configure Policies

## What are Policies?

Policies are a way for administrators to perform the following actions:

1) Impose restrictions on researchers workloads. For example, 
an administrator can restrict researchers from requesting more than 
2 GPUs, or less than 1gb of memory for each interactive job.
   
2) Apply default values for workload parameters. For example, an 
administrator can set the default memory of each training job to 1gb, or 
mount a default volume to be used by any submitted workload.
   
Policies are stored as kubernetes [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources) (CRs).
Different policy can be set by the administrator for each kind of workload, by
creating different kinds of policy resources. 
Supported kinds are:
* InteractivePolicy: affecting any interactive run:ai job. 
* TrainingPolicy: affecting any training run:ai job. 
* DeploymentPolicy: affecting any deployment workload. 

An instance of a policy resource can be created in the namespace of each project.
Additionally, a policy resource can be created in `runai` namespace, to 
take over whenever there is no project specific policy for the relevant
workload kind.

## Creating a Policy

### Creating your First Policy 

To create a sample `InteractivePolicy`, prepare a file (e.g. `policy.yaml`) 
containing the following yaml:

``` YAML
apiVersion: run.ai/v1alpha1
kind: InteractivePolicy
metadata:
  name: interactive-policy
  namespace: runai
spec:
  gpu:
    rules:
      required: true
      min: "1"
      max: "4"  
    value: 
      value: "1"
```
The policy places a default and limit on the available values for GPU allocation.
The numbers are quoted as they represent non-integer values. 
Integer values should be specified without quotes. 

Note that the policy above is created in `runai` namespace, thus apply whenever
the containing project does not have a project specific InteractivePolicy resource. 

To apply this policy, run: 

``` bash
kubectl apply -f policy.yaml 
```
Now try the following command:
``` bash
runai submit --gpu 5 --interactive
```
The following message should appear:
```
gpu: must be no greater than 4
```
A similar message should appear in the _New Job_ form of the run:ai user interface, when
attempting to enter number of GPUs which is out of range in the Interactive tab.  

### Itemized Values

The example above illustrated rules for parameters of "primitive" types, such as 
GPU allocation, CPU memory, working directory, etc. All these parameters contain a single
"flat" value. 

Some other workload parameters, such as ports or volumes, are "itemized", in the sense
that they may contain multiple values: a workload may contain multiple
ports and multiple volumes. 

Following is an example for a policy containing itemized parameter:

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
A policy for itemized field is composed of three parts:

* Rules: These rules apply to the `ports` parameter as a whole. In this
example, the administrator specifies `canAdd` rule with _true_ value, indicating
  that a researcher submitting an interactive job can add additional
  ports to the ports listed by the policy. _true_ is actually the default 
  for `canAdd`, so it actually could have been omitted from the policy above.
  Administrators would normally specify `canAdd` when its desired value is false,
  indicating that a researcher cannot add any port except those specified
  by the policy.<p><br>
  
* itemRules: These rules impose restrictions on the data members of 
each item, in this case - `container` and `external`. In the above examlpe, 
  administrator limited the value of `container` to 30000-32767, and the value of
  `external` to a maximum of 32767. <p><br>
  
* Items: In this section the administrator  specifies a list of default
ports. Each port is outlined as one item in the list, and must be labeled.
  In this example there are two ports, labeled admin-port-a and admin-port-b.
  Their default value is 30100:8080 and 30101:8081, respectively. The administrator 
  can also specify if a researcher can change/delete ports from the submitted workload. In this
  case, `admin-port-a` is hardwired, while `admin-port-b` can be changed or deleted
  by the researcher when submitting a workload.
  
### Syntax

The complete syntax of the policy yaml can be obtained using the explain
command of kubectl. 

For example:

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

The following commands can be used to drill further down the spec:

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

Note that each kind of policy has slightly different set of parameters. For example, an InteractivePolicy should
have a `jupyter` parameter, not available under TrainingPolicy. Always use the relevant policy kind in your explain 
queries to get the correct set of parameters for the policy you're creating.

### Using Secrets for Environment Variables

It is possible to add values from Kubernetes secrets as the value of environment variables included in the policy.
The secret will be extracted from the secret object when the Job is created. For example:


``` YAML
  environment:
    items:
      MYPASSWORD:
        value: "SECRET:my-secret,password"
```

When submitting a workload which is affected by this policy, the created container will have an environment variable called
`MYPASSWORD` whose value is the key `password` residing in Kubernetes secret `my-secret` which has been pre-created in
the namespace where the workload runs.

#### Note

* Run:ai provides a secret propagation mechanism from the `runai` namespace to all project namespaces. For further
  information see [secret propagation](use-secrets.md/#secrets-and-projects)
  
## Modifying/Deleting Policies

Use the standard kubectl get/apply/delete commands to modify and delete policies.

For example:

```bash
k get interactivepolicies -n runai
```
Should return the following:
```bash
NAME                 AGE
interactive-policy   2d3h
````
In order to delete this policy:
```bash
kubectl delete InteractivePolicy interactive-policy -n runai
```
In order to access project-specific policies, replace the `-n runai`
parameter with the namespace of the relevant project.

## See Also

* For creating workloads based on policies, see the Run:ai [submitting workloads guide](../../Researcher/submitting/workloads.md)




