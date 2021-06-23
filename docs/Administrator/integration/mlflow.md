# Integrate Run:AI with MLflow

[MLflow](https://www.mlflow.org/) is an open source platform to manage the ML lifecycle, including experimentation, reproducibility, deployment, and a central model registry. The purpose of this document is to explain how to run Jobs with MLflow using the Run:AI scheduler. 

## Overview 

MLflow concepts and alternative architectures are discussed [here](https://www.mlflow.org/docs/latest/concepts.html). MLflow can run on various platforms. To work with Run:AI we would use the MLflow [Kubernetes integration](https://www.mlflow.org/docs/latest/projects.html#kubernetes-execution).

The MLflow documentation describes the integration as such:

!!! quote
    When you run an MLflow Project on Kubernetes, MLflow constructs a new Docker image containing the Project’s contents; this image inherits from the Project’s Docker environment. MLflow then pushes the new Project image to your specified Docker registry and starts a Kubernetes Job on your specified Kubernetes cluster. This Kubernetes Job downloads the Project image and starts a corresponding Docker container. Finally, the container invokes your Project’s entry point, logging parameters, tags, metrics, and artifacts to your MLflow tracking server.

To run an MLflow job via Kubernetes, you specify an MLflow Kubernetes configuration file which contains a template. Here is an example from the MLflow documentation:

``` JSON
{
  "kube-context": ...,
  "repository-uri": ...,
  "kube-job-template-path": "/Users/username/path/to/kubernetes_job_template.yaml"
}
```

The Run:AI integration requires the modification of `kubernetes_job_template.yaml` file. Specifically adding the Run:AI scheduler name


## Step by Step Instructions


### Prerequisites

* Install [MLflow](https://www.mlflow.org/docs/latest/quickstart.html#installing-mlflow).
* Make sure you have __push__ access to a Docker repository from your local machine.
* Make sure you are connected to Run:AI via the Run:AI Command-line interface


### The Sample MLflow Project

The relevant sample files are [here](dfdfdfdfd). The components are:

* A Dockerfile. This builds a base docker image containing python3 and the required mlflow dependencies. The Docker file is already compiled and available at `gcr.io/run-ai-demo/mlflow-demo`.
* An MLflow project file named _MLproject_. The project file refers to the base image above and provides the python command line to run. 
* The training python code `train.py`. 
* MLflow Kubernetes configuration files as in [MLflow documentation](https://www.mlflow.org/docs/latest/projects.html#run-an-mlflow-project-on-kubernetes-experimental).
    * Kubernetes configuration file `kubernetes_config.json`
    * An MLflow Kubernetes Job template `kubernetes_job_template.yaml`. 


### Preparations

* Edit `kubernetes_config.json`. Set "kube-context" to the name of the Kubernetes context. You can find the name by running `runai list clusters` or `kubectl config get-contexts`.
* Edit `kubernetes_job_template.yaml`. Set the value of `namespace` to `runai-<name of Run:AI project>`. Note the last line which adds the Run:AI scheduler to the configuration. 


### Running 
* Perform `docker login` if required
* Run:

```
mlflow run mlproject -P alpha=5.0  -P l1-ratio=0.1 --backend kubernetes --backend-config kubernetes_config.json
```

## MLflow Tracking

The sample training code above does __not__ contain references to an MLflow tracking server. This has been done in order to simplify the required setup. With MLflow-Kubernetes you will need a [remote server architecture](https://www.mlflow.org/docs/latest/tracking.html#scenario-4-mlflow-with-remote-tracking-server-backend-and-artifact-stores). Once you have such an architect set up, you can use MLflow tracking.