
# Submitting Workloads via REST

You can submit Workloads via HTTP calls, using the Kubernetes REST API.

## Submit Workload Example


``` bash 
curl --location --request POST 'https://<KUBERNETES-API-SERVER>:6443/apis/run.ai/v1alpha1/namespaces/runai-team-a/trainingworkloads' \ # (1) 
--header 'Content-Type: application/yaml' \
--header 'Authorization: Bearer <BEARER>' \  # (2) 
--data-raw 'apiVersion: run.ai/v1alpha1
kind: TrainingWorkload 
metadata:
  name: job-1    
spec:
  gpu:
    value: "1"
  image:
    value: gcr.io/run-ai-demo/quickstart
  name:
    value: job-1  
```
(1) Replace `<KUBERNETES-API-SERVER>` with the Kubernetes control-plane endpoint (can be found in kubeconfig profile). Replace `runai-team-a` with namespace name.
(2) Add Bearer token here 



1. This is a _Training_ workload.
2. Kubernetes object name. Mandatory, but has no functional significance.
3. Namespace: Replace `runai-team-a` with the name of the Run:ai namespace for the specific Project (typically `runai-<Project-Name>`).
4. Job name as appears in Run:ai. Can provide name, or create automatically if name prefix is configured. 

Change the namespace and run: `kubectl apply -f job1.yaml`

Run: `runai list workloads` (or using the older syntax: `runai list workloads`) to see the new Workload.

Run: `kubectl delete -f job1.yaml` to delete the Workload. 


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



