# Running SPARK jobs with Run:AI

Spark has two modes for running jobs on kubernetes:

* Using a CLI tool called `spark-submit` that submits raw pods.
* CRD with operator.

## CLI `Spark-submit`

To run a Spark job on Kubernetes using the CLI:

1. Download a pre-built spark with hadoop image from [here](https://spark.apache.org/downloads.html).
2. Open the file, then go to its root to submit the jobs.

### Cluster preparation

Ensure that your Kubernetes cluster has a service account with permissions in the namespace that you want to run the jobs in. Use the following commands to launch the Spark demo:

```
k create ns spark-demo

k create serviceaccount spark -n spark-demo

k create clusterrolebinding spark-role --clusterrole edit --serviceaccount spark-demo:spark -n spark-demo
```

Change the namespace to `runai-<your_runai-project-name>`.

### Docker Images

We need to build docker images and push them to either a public repository or load them to kind.

To build the images run:

```
./bin/docker-image-tool.sh -t <image_tag> build

Then push the docker image to your repository:


### Submitting jobs

To submit a job:

1. Set the value of the API server of the kubernetes cluster you are working with in the `K8S\_SERVER` environment variable. 
2. Run `kubectl config view` to search for your cluster.
3. Copy the value of the server field (for example, https://127.0.0.1:46443).

To run a simple job with the default scheduler use the following:
<!-- Can I remove the slashes that were here? Is this a single command? -->
```
./bin/spark-submit --master k8s://$K8S\_SERVER --deploy-mode cluster --name spark-pi --conf spark.kubernetes.namespace=spark-demo --class org.apache.spark.examples.SparkPi --conf spark.executor.instances=5 --conf spark.kubernetes.container.image=spark:v3.2.1 --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark local:///opt/spark/examples/jars/spark-examples\_2.12-3.4.0.jar 10
```

The command will first create a pod called *driver*" and then it will create 5 *executor* (worker) pods that will do the actual work of running the job. The executor pods will have the *driver* as their Kubernetes *owner*.

### Submitting jobs using `runai-scheduler`

To submit a job with `runai-scheduler` in project `<project_name>` add or change these flags:

<!-- What is the command that I need? -->
<!-- Can I remove the slashes that were here? Is this a single command? 
Also need to remove the name specific things like names and other proprietary data.-->
```
--conf spark.kubernetes.namespace=runai-team-a \

--conf spark.kubernetes.scheduler.name=runai-scheduler \

--conf spark.kubernetes.driver.label.runai/queue=team-a \

--conf spark.kubernetes.executor.label.runai/queue=team-a \
```

To schedule the executors on GPUs, add the following flags:

```
--conf spark.executor.resource.gpu.amount=1 \

--conf spark.executor.resource.gpu.vendor=nvidia.com \

--conf spark.executor.resource.gpu.discoveryScript=/opt/spark/examples/src/main/scripts/getGpusResources.sh \
```

### Spark Pods

The created pods have several labels that unite them into pod groups. Ensure that the `driver` pod is the owner of the others.

example executor pod metadata:

labels:

```
runai/queue: team-a

spark-app-name: spark-pi

spark-app-selector: spark-77204fbefcd04f1bb63816fcf9528cf1

spark-exec-id: "1"

spark-exec-resourceprofile-id: "0"

spark-role: executor

spark-version: 3.4.0

name: spark-pi-e86f4788619be7a1-exec-1

namespace: runai-team-a

ownerReferences:

- apiVersion: v1

controller: true

kind: Pod

name: spark-pi-f4445788619bd784-driver

uid: 951d5bdb-cea8-41e8-998b-9c6fb6dff846

![Shape1](RackMultipart20230620-1-fcrkwu_html_932f45e5bf08d98e.gif)
```

The driver has a set amount of jobs to distribute, and will use any available executors to finish them. So, if only two executors are running and 6 jobs are available each one will execute 3 jobs.

## See also

[1] [Demo: Running Spark Examples on minikube](https://jaceklaskowski.github.io/spark-kubernetes-book/demo/running-spark-examples-on-minikube/)

[2] [Running Spark on Kubernetes](https://spark.apache.org/docs/latest/running-on-kubernetes.html)