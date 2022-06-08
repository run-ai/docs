
# Submitting Workloads via YAML

You can use YAML to submit Workloads directly to Run:ai. Below are examples of how to create training, interactive and inference workloads via YAML.

## Submit Workload Example

Create a file named `training1.yaml` with the following text:

``` YAML title="training1.yaml"
apiVersion: run.ai/v2alpha1
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

Change the namespace and run: `kubectl apply -f training1.yaml`

Run: `runai list jobs` to see the new Workload.

## Delete Workload Example

Run: `kubectl delete -f training1.yaml` to delete the Workload. 


## Creating a YAML syntax from a CLI command

An easy way to create a YAML for a workload is to generate it from the `runai submit` command by using the `--dry-run` flag. For example, run:

```
runai submit build1 -i ubuntu -g 1 --interactive --dry-run \
     -- sleep infinity 
```

The result will be the following Kubernetes object declaration:

``` YAML
apiVersion: run.ai/v2alpha1
kind: InteractiveWorkload  # (1)
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

1. This is an _Interactive_ workload.


## Inference Workload Example

Creating an inference workload is similar to the above two examples.

``` YAML
apiVersion: run.ai/v2alpha1
kind: InferenceWorkload
metadata:
  name: inference1
  namespace: runai-team-a
spec:
  name:
    value: inference1
  gpu:
    value: "0.5"
  image:
    value: "gcr.io/run-ai-demo/example-triton-server"
  minScale:
    value: 1
  maxScale:
    value: 2
  metric:
    value: concurrency # (1)
  target:
    value: 80  # (2)
  ports:
      items:
        port1:
          value:
            container: 8000
```

1. Possible metrics can be `cpu-utilization`, `latency`, `throughput`, `concurrency`, `gpu-utilization`, `custom`. Different metrics may require additional [installations](../../admin/runai-setup/cluster-setup/cluster-prerequisites.md#inference) at the cluster level. 
2. Inference requires a port to receive requests.

## See Also
* To understand how to connect to the inference workload, see [Inference Quickstart](../../Researcher/Walkthroughs/quickstart-inference.md).
* To learn more about Inference and Run:ai see [Inference overview](../../admin/workloads/inference-overview.md).