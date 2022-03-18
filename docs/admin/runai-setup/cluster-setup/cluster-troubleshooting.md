
## Determining Cluster Health

Following are a set of tests to run to determine cluster health:

### 1. Verify that data is sent to the cloud

Log in to `<company-name>.run.ai/dashboards/now`.

* Verify that all metrics in the overview dashboard are showing. Specifically the list of nodes and the numeric indicators
* Go to __Projects__ and create a new Project. Find the new Project using the CLI command: `runai list projects`


### 2. Verify that the Run:AI services are running

Run:

```
kubectl get pods -n runai
```

* Verify that all pods are in `Running` status and in a ready state (1/1 or similar)
* Identify the `runai-db-0` and `runai-agent-<id>` pods. Run: `kubectl logs -n runai <pod name>` and verify that there are no errors.

Run:

```
kubectl get deployments -n runai
```

Check that all deployments are in a ready state (1/1)

Run:

```
kubectl get daemonset -n runai
```

A _Daemonset_ runs on every node. Some of the Run:AI daemon-sets run on all nodes. Others run only on nodes that contain GPUs. Verify that for all daemonsets the _desired_ number is equal to  _current_ and to _ready_. 


Run:

```
runai list projects
```

Create a Project using the Administrator UI and verify that the Project is reflected in the above command. 

### 3. Submit a Job

Submitting a Job will allow you to verify that the Run:AI scheduling service is in order. 

* Make sure that the Project you have created has a quota of at least 1 GPU
* Run:

``` 
runai config project <project-name>
runai submit -i gcr.io/run-ai-demo/quickstart -g 1
```

* Verify that the Job is a _Running_ state when running: 

```
runai list jobs
```

* Verify that the Job is showing in the Jobs area at `<company-name>.run.ai/jobs`.

## Symptom: Metrics are not showing on Overview Dashboard

Some or all metrics are not showing in `<company-name>.run.ai/dashboards/now`

__Typical root causes:__

* NVIDIA prerequisites have not been met.
* Firewall-related issues.
* Internal clock is not synced.
* Prometheus pods are not running


__NVIDIA prerequisites have not been met__

Run:

```
runai pods -n runai | grep nvidia
```

Select one of the NVIDIA pods and run:

```
kubectl logs -n runai nvidia-device-plugin-daemonset-<id>
```

If the log contains an error, it means that NVIDIA-related prerequisites have not been met. Review [NVIDIA prerequisites](cluster-prerequisites.md). Verify that:

* Step 1.1: CUDA Toolkit is installed
* Step 1.2: NVIDIA Docker is installed. A typical issue here is the installation of the _NVIDIA Container Toolkit_ instead of _NVIDIA Docker 2_. 
* Step 1.3: Verify that NVIDIA Docker is the __default__ docker runtime
* If the system has recently been installed, verify that docker has restarted by running the aforementioned  `pkill` command
* Check the status of Docker by running:

```
sudo systemctl status docker
```

__Firewall issues__

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
* If you need to set up an internet proxy or certificate, please contact Run:AI customer support. 


__Machine Clocks are not synced__

Run: `date` on cluster nodes and verify that date/time is correct.  If not,

* Set the Linux time service (NTP).
* Restart Run:AI services. Depending on the previous time gap between servers, you may need to reinstall the Run:AI cluster


__Prometheus pods are not running__

Run: `kubectl get pods -n monitoring -o wide`

* Verify that all pods are running.
* The default Prometheus installation is not built for high availability. If a node is down, the Prometheus pod will not recover by itself unless manually deleted. Delete the pod to see it start on a different node and consider adding a second replica to Prometheus.

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
* If you need to setup an internet proxy or certificate, please contact Run:AI customer support. 


## Symptom: Cluster Installation failed on Rancher-based Kubernetes (RKE)

Cluster is not installed. When running `kubectl get pods -n runai` you see that pod `init-ca` has not started

__Resolution__

During initialization, Run:AI creates a Certificate Signing Request (CSR) which needs to be approved by the cluster's Certificate Authority (CA). In RKE, this is not enabled by default, and the paths to your Certificate Authority's keypair must be referenced manually by adding the following parameters inside your cluster.yml file, under kube-controller:

``` YAML
services:
  kube-controller:
    extra_args:
      cluster-signing-cert-file: /etc/kubernetes/ssl/kube-ca.pem
      cluster-signing-key-file: /etc/kubernetes/ssl/kube-ca-key.pem
```

For further information see [here](https://github.com/rancher/rancher/issues/14674){target=_blank}.

## Symptom: Jobs fail with ContainerCannotRun status 

When running `runai list jobs`, your Jobs has a status of `ContainerCannotRun`.

__Resolution__

The issue may be caused due to an unattended upgrade of the NVIDIA driver.

To verify, run `runai describe job <job-name>`, and search for an error `driver/library version mismatch`.

To fix: reboot the node on which the Job attempted to run.

Going forward, we recommend blacklisting NVIDIA driver from unattended upgrades.  
You can do that by editing `/etc/apt/apt.conf.d/50unattended-upgrades`, and adding `nvidia-driver-` to the `Unattended-Upgrade::Package-Blacklist` section.  
It should look something like that:

``` CONF
Unattended-Upgrade::Package-Blacklist {
    // The following matches all packages starting with linux-
//  "linux-";
    "nvidia-driver-";
```

## Diagnostic Tools

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


### Internal Networking Issues

Run:AI is based on Kubernetes. Kubernetes runs its own internal subnet with a separate DNS service. If you see in the logs that services have trouble connecting, the problem may reside there.  You can find further information on how to debug Kubernetes DNS [here](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/){target=_blank}. Specifically, it is useful to start a Pod with networking utilities and use it for network resolution:

```
kubectl run -i --tty netutils --image=dersimn/netutils -- bash
```

