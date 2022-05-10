# Submit a Run:ai Job via Kubernetes API

!!! Warning
    Researcher Kubernetes API is deprecated. See [Cluster API](../../cluster-api/workload-overview-dev.md) for its replacement.

This article is a complementary article to the article on [launching jobs via YAML](launch-job-via-yaml.md). It shows how to use a programming language and [Kubernetes API](https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/#programmatic-access-to-the-api){target=_blank} to submit jobs. 

The article uses Python, though Kubernetes API is available in several other programming languages. 


## Submit a Run:ai Job 


``` python
from __future__ import print_function
import kubernetes
from kubernetes import client, config
from pprint import pprint
import json

config.load_kube_config()

with client.ApiClient() as api_client:

    namespace = 'runai-team-a'  # Run:ai project name is prefixed by runai-
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