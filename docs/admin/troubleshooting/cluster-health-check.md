# Cluster Health and Troubleshooting

This toubleshooting guide helps you diagnose and resolve issues you may find in your cluster.

## Cluster is Disconnected

When a cluster's status shows “Disconnected”, this means that no communication from the Run:ai cluster services reaches the Run:ai Control Plane. 

This may reflect a networking issue from or to your Kubernetes cluster regardless of Run:ai components. In some cases, it may indicate an issue with one or more Run:ai services that communicate with the Control Plane. These are:
* Cluster sync (`cluster-sync`)
* Agent (`runai-agent`)
* Asset sync (`asset-sync`)

### Troubleshooting actions:

* First, check that the Run:ai services that communicate with the Control Plane are up and running.

  Run:

  `kubectl get pods -n runai | grep -E 'runai-agent|cluster-sync|assets-sync'`

* Verify Run:ai services logs. Inspecting the logs of the Run:ai services that communicate with the CP is an essential first step to identify any error messages or connection issues.

  Run the following command on each one of the services:

  ```
  kubectl logs runai-agent -n runai
  kubectl logs cluster-sync -n runai
  kubectl logs assets-sync -n runai
  ```

* Check the network connection from the runai namespace in your cluster to the Control Plane. You can do that by running a connectivity check pod.

  Create a pod within the runai namespace. This pod can be a simple container with basic network troubleshooting tools, such as curl or get. Use the following command to determine if the pod can establish connections to the necessary Control Plane endpoints:

  `kubectl run control-plane-connectivity-check -n runai --image=wbitt/network-multitool --command -- /bin/sh -c 'curl -sSf <control-plane-endpoint> > /dev/null && echo "Connection Successful" || echo "Failed connecting to the Control Plane"'`

  Replace `control-plane-endpoint` with the URL of the Control Plane in your environment.

* Check potential network issues. You can use the following guidelines:
  
    * Ensure that the network policies in your Kubernetes cluster allow communication between the Run:ai services that communicate with the Control Plane to the Control Plane.
   
    * Check both Kubernetes Network Policies and any network-related configurations at the infrastructure level.
  
    * Verify that the required ports and protocols are not blocked. 

* Contact Run:ai Support

  If the issue persists and you couldn’t resolve it after completing the above steps, contact Run:ai support for assistance.

!!! Note 
    The above steps can also be relevant if you installed the cluster and it is stuck in the status “Waiting to connect” for a long time.

## Cluster has Service issues

When a cluster is in the status “Service issues”, this means that one or more Run:ai services that are running in the cluster are not available.

* In this case, first run the following command, to verify which are the non-functioning services, and get more details about deployment issues and resources required by these services that may not be ready (e.g. ingress is was not created or is unhealthy): 

  `kubectl get runaiconfig -n runai runai -ojson | jq -r '.status.conditions | map(select(.type == "Available"))'`

  The list of non-functioning services is also available on the UI Clusters page.

* After determining the non-functioning services, you can use the following guidelines to further investigate the issue.

  Get all Kubernetes events and look for recent failures:

  `Kubectl get events  -A`

  If a required resource was created but not available or unhealthy, you can also check its details by running:

  `Kubectl describe <resource_type> <name>`

* If the issue persists and you couldn’t resolve it, contact Run:ai support for assistance. 

## General tests to verify the Run:ai cluster health

In addition of the troubleshooting options described above, regardless of the cluster status, you can use the following tests regularly, to determine the Run:ai cluster health.

### Verify that data is sent to the cloud

Log in to `<company-name>.run.ai/dashboards/now`.

* Verify that all metrics in the overview dashboard are showing. 
* Verify that all metrics are showing in the Nodes view. 
* Go to **Projects** and create a new Project. Find the new Project using the CLI command: `runai list projects`


### Verify that the Run:ai services are running

Run:
```
kubectl get runaiconfig -n runai runai -ojson | jq -r '.status.conditions | map(select(.type == "Available"))'
```
Verify that all the Run:ai services are available and have all their required resources available as well.


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


### Submit a Job via the command-line interface

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

### Submit a Job via the user interface

Log into the Run:ai user interface, and verify that you have a `Researcher` or `Research Manager` role. 
Go to the `Jobs` area. On the top right, press the button to create a Job. Once the form opens -- submit a Job. 
