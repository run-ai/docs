# Verifying Cluster Health

Following is a set of tests that determine the Run:ai cluster health:

## Verify that data is sent to the cloud

Log in to `<company-name>.run.ai/dashboards/now`.

* Verify that all metrics in the overview dashboard are showing. 
* Verify that all metrics are showing in the Nodes view. 
* Go to __Projects__ and create a new Project. Find the new Project using the CLI command: `runai list projects`


## Verify that the Run:ai services are running

Run:

```
kubectl get pods -n runai
kubectl get pods -n monitoring
```
Verify that all pods are in `Running` status and a ready state (1/1 or similar)

Run:

```
kubectl get deployments -n runai
```

Check that all deployments are in a ready state (1/1)

Run:

```
kubectl get daemonset -n runai
```

A _Daemonset_ runs on every node. Some of the Run:ai daemon-sets run on all nodes. Others run only on nodes that contain GPUs. Verify that for all daemonsets the _desired_ number is equal to  _current_ and to _ready_. 


## Submit a Job via the command-line interface

Submitting a Job will allow you to verify that the Run:ai scheduling service is in order. 

* Make sure that the Project you have created has a quota of at least 1 GPU
* Run:

``` 
runai config project <project-name>
runai submit -i gcr.io/run-ai-demo/quickstart -g 1
```

* Verify that the Job is in a _Running_ state by running: 

```
runai list jobs
```

* Verify that the Job is showing in the Jobs area at `<company-name>.run.ai/jobs`.

## Submit a Job via the user interface

Log into the Run:ai user interface, and verify that you have a `Researcher` or `Research Manager` role. 
Go to the `Jobs` area. On the top right, press the button to create a Job. Once the form opens -- submit a Job. 
