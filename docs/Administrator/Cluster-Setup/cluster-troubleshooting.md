# Troubleshooting

## Determining the Health of a Run:AI Cluster

To understand whether your Run:AI cluster is healthy you need perform the following verification tests:

1. All Run:AI services are running.
2. Data is sent to the cloud.
3. A job dan be sumbitted.


### 1. Run:AI services are running

Run:

      kubectl get pods -n runai

Verify that all pods are in ``Running`` status. 

Run:

      kubectl get deployments -n runai
      kubectl get sts -n runai

Verify that all items (deployments and statefulsets alike) are in a ready state (1/1)

Run:

      kubectl get daemonset -n runai


A _Daemonset_ runs on every node. Some of the Run:AI daemon-sets run on all nodes. Others run only on nodes which contain GPUs. Verify that for all daemon-sets the _desired_ number is equal to  _current_ and to _ready_. 


### 2. Data is sent to the cloud

Log in to [app.run.ai](https://app.run.ai)

* Verify that all metrics in the overview dashboard are showing. Specifically the list of nodes and the numeric indicators
* Go to __Projects__ and create a new project. Find the new project using the CLI command:

         runai project list


### 3. Submit a job

Submitting a job will allow you to verify that Run:AI scheduling service are in order. 

* Make sure that the project you have created has a quota of at least 1 GPU
* Run:

         runai project set <project-name>
         runai submit job1 -i gcr.io/run-ai-demo/quickstart -g 1

* Verify that the job is a _Running_ state when running: 

         runai list

* Verify that the job is showing on the job area in [app.run.ai/Jobs](https://app.run.ai/Jobs)


## Symptoms 

### Metrics are not showing on Overview Dashboard

__Symptom:__ Some or all metrics are not showing in [app.run.ai](https://app.run.ai)

__Typical root causes:__

* NVIDIA prerequisites have not been met.
* Firewall related issues.
* Internal clock is not synced.

#### NVIDIA related issues

Run:

      runai pods -n runai | grep nvidia

Select one of the nvidia pods and run:

      kubectl logs -n runai nvidia-device-plugin-daemonset-<id>

If the log contains an error, it means that NVIDIA related prerequisites have not been met. Review step 1 in [NVIDIA prerequisites](../Installing-Run-AI-on-an-on-premise-Kubernetes-Cluster/#step-1-nvidia). Verify that:

* Step 1.1: NVIDIA drivers are installed
* Step 1.2: NVIDIA Docker is installed. A typical issue here is the installation of the _NVIDIA Container Toolkit_ instead of _NVIDIA Docker 2_. 
* Step 1.3: Verify that NVIDIA Docker is the __default__ docker runtime
* If the system has recently been installed, verify that docker has restarted by running the aforementioned  `pkill` command
* Check the status of Docker by running:

         sudo systemctl status docker



#### Firewall issues

Run:

      runai pods -n runai | grep agent

Select the agent's full name and run:

      kubectl logs -n runai runai-agent-<id>

Verify that there are no errors. If there are connectivity related errors you may need to:

* Check your firewall for outbound connections. See the required permitted URL list in: [Network requirements](cluster-prerequisites.md#network-requirements.md).
* If you need to setup an internet proxy or certificate, review: [Installing Run:AI with an Internet Proxy Server](proxy-server.md)
* Remove the Run:AI default Storage Class if a default already exists. See: [remove default storage class](../cluster-troubleshooting/#internal-database-has-not-started)

#### Clock is not synced

Run: `date` on cluster nodes and see that date is in sync.


### Internal Database has not started
 
 __Typical root cause:__ more than one default storage class is installed
 
 The Run:AI Cluster installation includes, by default, a storage class named ``local path provisioner`` which is installed as a default storage class. In some cases, your k8s cluster may __already have__ a default storage class installed. In such cases you should disable the local path provisioner. Having two default storage classes will disable both the internal database and some of the metrics.

 Run:

      kubectl get storageclass

And look for _default_ storage classes.

 Run:

      kubectl describe pod -n runai runai-db-0

 See that there is indeed a storage class error appearing

 To disable local path provisioner please run:

      kubectl edit runaiconfig -n runai
 
 Add the following lines under `spec`:
 
``` yaml
local-path-provisioner:
      enabled: false
```

