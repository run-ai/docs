
# Submitting Workloads via HTTP/REST

You can submit Workloads via HTTP calls, using the Kubernetes REST API.

## Submit Workload Example

To submit a workload via HTTP, run the following:

``` bash 
curl -X POST \ # (1) 
'https://<IP>:6443/apis/run.ai/v2alpha1/namespaces/<PROJECT>/trainingworkloads' \ 
    --header 'Content-Type: application/yaml' \
    --header 'Authorization: Bearer <BEARER>' \  # (2) 
    --data-raw 'apiVersion: run.ai/v2alpha1
kind: TrainingWorkload  # (3)
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

1. Replace `<IP>` with the Kubernetes control-plane endpoint (can be found in kubeconfig profile). <br> Replace `<PROJECT>` with the name of the Run:ai namespace for the specific Project (typically `runai-<Project-Name>`). <br> Replace `trainingworkloads` with `interactiveworkloads` or `inferenceworkloads` according to type.
2. Add Bearer token. To obtain a Bearer token see [API authentication](../rest-auth.md).
3. See [Submitting a Workload via YAML](submit-yaml.md) for an explanation about the YAML-based workload

Run: `runai list jobs` to see the new Workload.



## Using other Programming Languages

You can use any Kubernetes client library together with the YAML documentation above to submit workloads via other programming languages. For more information see [Kubernetes client libraries](https://kubernetes.io/docs/reference/using-api/client-libraries/){target=_blank}.



