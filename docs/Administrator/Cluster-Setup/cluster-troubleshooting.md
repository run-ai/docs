# Troubleshooting

## Determining the Health of a Run:AI Cluster

To understand whether your Run:AI cluster is healthy you need perform the following verification tests:

1. All Run:AI services are running.
2. Data is sent to the cloud.
3. A Job can be submitted.


### 1. Run:AI services are running

Run:

      kubectl get pods -n runai

Verify that all pods are in ``Running`` status. 

Run:

      kubectl get deployments -n runai
      kubectl get sts -n runai

Verify that all items (deployments and StatefulSets alike) are in a ready state (1/1)

Run:

      kubectl get daemonset -n runai


A _Daemonset_ runs on every node. Some of the Run:AI daemon-sets run on all nodes. Others run only on nodes which contain GPUs. Verify that for all daemon-sets the _desired_ number is equal to  _current_ and to _ready_. 


### 2. Data is sent to the cloud

Log in to [https://app.run.ai/dashboards/now](https://app.run.ai/dashboards/now){target=_blank}

* Verify that all metrics in the overview dashboard are showing. Specifically the list of nodes and the numeric indicators
* Go to __Projects__ and create a new Project. Find the new Project using the CLI command:

         runai list projects


### 3. Submit a Job

Submitting a Job will allow you to verify that the Run:AI scheduling service is in order. 

* Make sure that the Project you have created has a quota of at least 1 GPU
* Run:

         runai config project <project-name>
         runai submit job1 -i gcr.io/run-ai-demo/quickstart -g 1

* Verify that the Job is a _Running_ state when running: 

         runai list jobs

* Verify that the Job is showing in the Jobs area in [app.run.ai/jobs](https://app.run.ai/jobs){target=_blank}


## Symptom: Metrics are not showing on Overview Dashboard

Some or all metrics are not showing in [https://app.run.ai/dashboards/now](https://app.run.ai/dashboards/now){target=_blank}

__Typical root causes:__

* NVIDIA prerequisites have not been met.
* Firewall related issues.
* Internal clock is not synced.

### NVIDIA prerequisites have not been met

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


### Firewall issues

Add verbosity to Prometheus by editing RunaiConfig:
```
kubectl edit runaiconfig runai -n runai
```

Add a `debug` log level:

``` YAML
prometheus-operator:
  prometheus:
    prometheusSpec:
      logLevel: debug
```

Run:
``` 
kubectl logs  prometheus-runai-prometheus-operator-prometheus-0 prometheus \
      -n runai -f --tail 100
```

Verify that there are no errors. If there are connectivity related errors you may need to:

* Check your firewall for outbound connections. See the required permitted URL list in: [Network requirements](cluster-prerequisites.md#network-requirements.md).
* If you need to setup an internet proxy or certificate, review: [Installing Run:AI with an Internet Proxy Server](proxy-server.md)


### Clock is not synced

Run: `date` on cluster nodes and verify that date/time is correct.  If not,

* Set the Linux time service (NTP).
* Restart Run:AI services. Depending on the previous time gap between servers, you may need to reinstall the Run:AI cluster


## Symptom: Projects are not syncing

Create a Project on the Admin UI, then run: `runai list projects`. The new Project does __not__ appear.

 __Typical root cause:__ The Run:AI _agent_ is not syncing properly. This may be due to:

 * A dependency on the internal Run:AI database. See [separate](#symptom-internal-database-has-not-started) symptom below
 * Firewall issues

Run:

      runai pods -n runai | grep agent

See if the agent is in _Running_ state. Select the agent's full name and run:

      kubectl logs -n runai runai-agent-<id>

Verify that there are no errors. If there are connectivity related errors you may need to:

* Check your firewall for outbound connections. See the required permitted URL list in: [Network requirements](cluster-prerequisites.md#network-requirements.md).
* If you need to setup an internet proxy or certificate, review: [Installing Run:AI with an Internet Proxy Server](proxy-server.md)




## Symptom: Internal Database has not started

Run: 
```
runai pods -n runai | grep runai-db-0
``` 
The status of the Run:AI database is not _Running_

 
__Typical root causes:__ 

* More than one default storage class is installed
* Incompatible NFS version


### More than one default storage class is installed
 The Run:AI Cluster installation includes, by default, a storage class named ``local path provisioner`` which is installed as a default storage class. In some cases, your k8s cluster may __already have__ a default storage class installed. In such cases you should disable the local path provisioner. Having two default storage classes will disable both the internal database and some of the metrics.

 Run:

      kubectl get storageclass

And look for _default_ storage classes.

 Run:

      kubectl describe pod -n runai runai-db-0

 See that there is indeed a storage class error appearing

 To disable local path provisioner, run:

      kubectl edit runaiconfig -n runai
 
 Add the following lines under `spec`:
 
``` yaml
local-path-provisioner:
      enabled: false
```

### Incompatible NFS version
Default NFS Protocol [level](https://www.netapp.com/pdf.html?item=/media/19755-tr-3085.pdf){target=_blank} is currently 4. If your NFS requires an older version, you may need to add the option as follows. Run:

```
kubectl edit runaiconfig runai -n runai
```

Add `mountOptions` as follows:

``` YAML
nfs-client-provisioner:
  nfs: 
    mountOptions: ["nfsvers=3"]
```

### Adding Verbosity to Database container

Run:

```
kubectl edit runaiconfig runai -n runai
```

Under `spec`, add: 

``` YAML
spec:
  postgresql:
    image:
      debug: true
```

Then view the log by running:

```
kubectl logs -n runai runa-db-0 
```

## Internal Networking Issues

Run:AI is based on Kubernetes. Kubernetes runs its own internal subnet with a separate DNS service. If you see in the logs that services have trouble connecting, the problem may reside there.  You can find further information on how to debug Kubernetes DNS [here](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/){target=_blank}. Specifically, it is useful to start a Pod with networking utilities and use it for network resolution:

```
kubectl run -i --tty netutils --image=dersimn/netutils -- bash
```

