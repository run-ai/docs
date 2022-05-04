
# Submitting Workloads via YAML

You can use YAML to submit Workloads directly to Run:ai. 

## Submit Workload Example

Create a file named `job1.yaml` with the following text:

``` YAML title="job1.yaml"
apiVersion: run.ai/v1alpha1
kind: TrainingWorkload # (1)
metadata:
  name: job-1  # (2) 
  namespace: runai-team-a # (3)
spec:
  gpu:
    value: "1"
  image:
    value: gcr.io/run-ai-demo/quickstart
  name:
    value: job-1 # (4)
```

1. This is a _Training_ workload.
2. Kubernetes object name. Mandatory, but has no functional significance.
3. Namespace: Replace `runai-team-a` with the name of the Run:ai namespace for the specific Project (typically `runai-<Project-Name>`).
4. Job name as appears in Run:ai. Can provide name, or create automatically if name prefix is configured. 

Change the namespace and run: `kubectl apply -f job1.yaml`

Run: `runai list workloads` (or using the older syntax: `runai list workloads`) to see the new Workload.

Run: `kubectl delete -f job1.yaml` to delete the Workload. 

## Submit Options

There are many possible options for submitting a workload. Full documentation of these flags can be found in the documentation of the [runai-submit](../../Researcher/cli-reference/runai-submit.md) command. 

To find the exact YAML syntax run:

```
 kubectl explain TrainingWorkload.spec
```

(and similarly for other Workload types).

To get information on a specific value (e.g. `node type`), you can also run:

```
kubectl explain TrainingWorkload.spec.nodeType
```


## Creating a YAML syntax from a CLI command

An easy way to create a YAML for a workload is to generate it from the `runai submit` command by using the `--dry-run` flag. For example, run:

```
runai submit build1 -i ubuntu -g 1 --interactive --command --dry-run \
     -- sleep infinity 
```

The result will be an `InteractiveWorkload` Kuberntes object:

``` YAML
apiVersion: run.ai/v1alpha1
kind: InteractiveWorkload
metadata:
  creationTimestamp: null
  labels:
    PreviousJob: "true"
  name: job-0-2022-05-02t08-50-57
  namespace: runai-team-a
spec:
  command:
    value: sleep infinity
  gpu:
    value: "1"
  image:
    value: ubuntu
  imagePullPolicy:
    value: Always
  name:
    value: job-0

... Additional internal and status properties...
```

## Using other Programming Languages

You can use any Kubernetes client library together with the YAML documentation above to submit workloads via another programming languages. For more information see [Kubernetes client libraries](https://kubernetes.io/docs/reference/using-api/client-libraries/){target=_blank}.



