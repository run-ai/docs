# Integrate Run:ai with MLflow

[MLflow](https://www.mlflow.org/){target=_blank} is an open-source platform to manage the ML lifecycle, including experimentation, reproducibility, deployment, and a central model registry. The purpose of this document is to explain how to run Jobs with MLflow using the Run:ai scheduler. 

## Overview 

MLflow concepts and alternative architectures are discussed [here](https://www.mlflow.org/docs/latest/concepts.html){target=_blank}. MLflow can run on various platforms. To work with Run:ai we would use the MLflow [Kubernetes integration](https://www.mlflow.org/docs/latest/projects.html#kubernetes-execution){target=_blank}.

The MLflow documentation describes the Kubernetes integration as such:

!!! quote
    When you run an MLflow Project on Kubernetes, MLflow constructs a new Docker image containing the Project’s contents; this image inherits from the Project’s Docker environment. MLflow then pushes the new Project image to your specified Docker registry and starts a Kubernetes Job on your specified Kubernetes cluster. This Kubernetes Job downloads the Project image and starts a corresponding Docker container. Finally, the container invokes your Project’s entry point, logging parameters, tags, metrics, and artifacts to your MLflow tracking server.

To run an MLflow job via Kubernetes, you specify an MLflow Kubernetes configuration file that contains a template. Here is an example from the MLflow documentation:

``` JSON
{
  "kube-context": ...,
  "repository-uri": ...,
  "kube-job-template-path": "/username/path/to/kubernetes_job_template.yaml"
}
```

The essence of the Run:ai integration is the modification of the `kubernetes_job_template.yaml` file. Specifically adding the Run:ai scheduler name and the Run:ai Project (Kubernetes namespace).


## Step by Step Instructions


### Prerequisites

* [Install MLflow](https://www.mlflow.org/docs/latest/quickstart.html#installing-mlflow){target=_blank}.
* Make sure you have __push__ access to a Docker repository from your local machine.
* Make sure you are connected to Run:ai via the Run:ai Command-line interface.


### The sample MLflow Project

The relevant sample files are [here](https://github.com/run-ai/docs/tree/master/integrations/mlflow){target=_blank}. These contain:

* A `Dockerfile`. This file builds a base docker image containing python3 and the required MLflow dependencies. The Docker file is __already compiled and available__ at `gcr.io/run-ai-demo/mlflow-demo`.
* An MLflow project file `MLproject`. The project file contains the base image above as well as the python command-line to run. 
* The training python code `train.py`
* MLflow Kubernetes configuration files as in the [MLflow documentation](https://www.mlflow.org/docs/latest/projects.html#run-an-mlflow-project-on-kubernetes-experimental){target=_blank}.
    * Kubernetes configuration file `kubernetes_config.json`
    * An MLflow Kubernetes Job template `kubernetes_job_template.yaml` 


### Preparations

* Edit `kubernetes_config.json`. 
    * Set `kube-context` to the name of the Kubernetes context. You can find the context name by running `runai list clusters` or `kubectl config get-contexts`.
    * Set `repository-uri` to a repository and name of a docker image that will be used by MLflow (this is a different image than the base docker image described above). Your local machine needs permissions to be able to push this image to the Docker registry.
* Edit `kubernetes_job_template.yaml`. 
    * Set the value of `namespace` to `runai-<name of Run:ai project>`. 
    * Note the last line which adds the Run:ai scheduler to the configuration. 
    * Do __not__ change the lines marked by `{replaced with...`.
    * Set the requested resources including GPUs. You can use the `--dry-run` flag of the [runai submit](../../Researcher/cli-reference/runai-submit.md) command to gain insight on additional configurations


### Running 
* Perform `docker login` if required.
* Run:

```
mlflow run mlproject -P alpha=5.0  -P l1-ratio=0.1  \
    --backend kubernetes --backend-config kubernetes_config.json
```

## MLflow Tracking

The sample training code above does __not__ contain references to an MLflow tracking server. This has been done to simplify the required setup. With MLflow-Kubernetes you will need a [remote server architecture](https://www.mlflow.org/docs/latest/tracking.html#scenario-4-mlflow-with-remote-tracking-server-backend-and-artifact-stores){target=_blank}. Once you have such an architecture set up, you can use MLflow Tracking in your code.

## Using Interactive Workloads

With Run:ai you can also run _interactive_ workloads. To run the Job as interactive, add the following to `kubernetes_job_template.yaml`: 

``` YAML
metadata:
  labels:
    priorityClassName: "build"
```


## See Also

* You can use MLflow together with Fractional GPUs. For more information see [Launch Job via YAML](../../developer/deprecated/k8s-api/launch-job-via-yaml.md#using-fractional-gpus).
* To map additional Run:ai options to the YAML, see [Launch Job via YAML](../../developer/deprecated/k8s-api/launch-job-via-yaml.md#mapping-additional-flags).

