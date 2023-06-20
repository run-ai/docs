# Running SPARK jobs with Run:AI

Spark has two modes for running jobs on kubernetes:

- Using a CLI tool called spark-submit that submits raw pods
- CRD with operator

## Spark-submit

### Installation

Download the pre-built spark with hadoop from here:

[https://spark.apache.org/downloads.html](https://spark.apache.org/downloads.html)

Open that tar file and go to its root to submit the jobs

### Cluster preparation

Nothing has to be installed on the kubernetes, but a service account with a few permissions is needed in the namespace that we want to run the jobs in:

k create ns spark-demo

k create serviceaccount spark -n spark-demo

k create clusterrolebinding spark-role \

--clusterrole edit \

--serviceaccount spark-demo:spark \

-n spark-demo

We can change the namespace to something like runai-team-a for example.

### Docker Images

We need to build docker images and push them to either a public repository or load them to kind.

To build the images run:

./bin/docker-image-tool.sh \

-t v3.2.1 \

build

An image named spark:v3.2.1 will be created. (Probably should write 3.4.0 there but it worked fine with this tag..)

Then to load it into your kind cluster use:

kind load docker-image spark:v3.2.1 --name \<CLUSTER\_NAME\>

### Submitting a job

Set the value of the api server of the kubernetes cluster you are working with in the K8S\_SERVER environment variable. You can run the kubectl config view command and search for you cluster there and copy the value of the server field, EG https://127.0.0.1:46443

To run a simple job with the default scheduler:

./bin/spark-submit \

--master k8s://$K8S\_SERVER \

--deploy-mode cluster \

--name spark-pi \

--conf spark.kubernetes.namespace=spark-demo \

--class org.apache.spark.examples.SparkPi \

--conf spark.executor.instances=5 \

--conf spark.kubernetes.container.image=spark:v3.2.1 \

--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \

local:///opt/spark/examples/jars/spark-examples\_2.12-3.4.0.jar 10

This will create a first pod which is the "driver" and that pod will create 5 "executor" (worker) pods that will do the "actual work". The executor pods will have the driver as their kubernetes "owner".

#### runai-scheduler

To submit a job with runai-scheduler in project team-a (assuming you created a new service account in that namespace.) add / change these flags:

--conf spark.kubernetes.namespace=runai-team-a \

--conf spark.kubernetes.scheduler.name=runai-scheduler \

--conf spark.kubernetes.driver.label.runai/queue=team-a \

--conf spark.kubernetes.executor.label.runai/queue=team-a \

Scheduling with GPUs for the executors, add those flags:

--conf spark.executor.resource.gpu.amount=1 \

--conf spark.executor.resource.gpu.vendor=nvidia.com \

--conf spark.executor.resource.gpu.discoveryScript=/opt/spark/examples/src/main/scripts/getGpusResources.sh \

### Spark Pods

the created pods have several labels that could help unite them to pod groups, but most important is that the driver pod (the one that creates the other executors) is the owner of the others.

example executor pod metadata:

labels:

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

The driver has a set amount of "jobs" to distribute, and will use any available executors to finish them. So if only two executors are running and 6 jobs are available each one will execute 3 jobs.

### Issues

- pod-grouper crashes on the executor pods - Doesn't know how to manage pods owning other pods
- Couldn't find any option in spark to define elasticity

## CRD and Operator

TBD

## Links

[1] [https://jaceklaskowski.github.io/spark-kubernetes-book/demo/running-spark-examples-on-minikube/](https://jaceklaskowski.github.io/spark-kubernetes-book/demo/running-spark-examples-on-minikube/)

[2] [https://spark.apache.org/docs/latest/running-on-kubernetes.html](https://spark.apache.org/docs/latest/running-on-kubernetes.html)