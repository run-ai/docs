# Submit a Run:AI Job via Kubernetes API

The easiest way to submit jobs to the Run:AI GPU cluster is via the Run:AI Command-line interface (CLI). Still, the CLI is not a must. It is only a wrapper for a more detailed Kubernetes API syntax using YAML. 

There are cases where you want to forgo the CLI and use direct YAML calls. A frequent scenario for using the Kubernetes YAML syntax to submit jobs is __integrations__. Researchers may already be working with an existing system that submits jobs, and want to continue working with the same system. Though it is possible to call the Run:AI CLI from the customer's integration, it is sometimes not enough.

This article is a complementary article to the article [Launching jobs via YAML](launch-job-via-yaml.md). It shows how to use [Kubernetes API](https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/#programmatic-access-to-the-api){target=_blank} to submit jobs. 

The article uses Python, though Kubernetes API is available several other programming languages. 

## Submit a Run:AI Job 

The following code builds the Job YAML from the article on [launching jobs via YAML](launch-job-via-yaml.md) and sends it via Kubernetes API.

``` python
from __future__ import print_function
import kubernetes
from kubernetes import client, config
from pprint import pprint
import json

config.load_kube_config()

with client.ApiClient() as api_client:

    namespace = 'runai-team-a'  # Run:AI project name is prefixed by runai-
    jobname = 'my-job'
    username = 'john'  # used in un-authenticated systems only
    gpus = 1

    body = client.V1Job(api_version="run.ai/v1", kind="RunaiJob")
    body.metadata = client.V1ObjectMeta(namespace=namespace, name=jobname)

    template = client.V1PodTemplate()
    template.template = client.V1PodTemplateSpec()
    template.template.metadata = client.V1ObjectMeta(labels = {'user' : username})

    resource = client.V1ResourceRequirements(limits= {'nvidia.com/gpu' : gpus})
    container = client.V1Container(
        name=jobname, image='gcr.io/run-ai-demo/quickstart', resources=resource)
    template.template.spec = client.V1PodSpec(
        containers=[container], restart_policy='Never', scheduler_name='runai-scheduler')
    body.spec = client.V1JobSpec(template=template.template)

    pprint(body)
 
    try:
        api_instance = client.CustomObjectsApi(api_client)
        api_response = api_instance.create_namespaced_custom_object(
            "run.ai", "v1", namespace, "runaijobs", body)
        pprint(api_response)
    except client.rest.ApiException as e:
        print("Exception when calling AppsV1Api->create_namespaced_job: %s\n" % e)
```