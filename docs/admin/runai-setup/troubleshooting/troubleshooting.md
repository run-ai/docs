
# Troubleshooting Run:ai 

## Dashboard Issues

??? "No Metrics are showing on Dashboard"

    __Symptom__: No metrics are not showing in `<company-name>.run.ai/dashboards/now`

    __Typical root causes:__

    * Firewall-related issues.
    * Internal clock is not synced.
    * Prometheus pods are not running



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
          -n monitoring -f --tail 100
    ```

    Verify that there are no errors. If there are connectivity-related errors you may need to:

    * Check your firewall for outbound connections. See the required permitted URL list in [Network requirements](cluster-prerequisites.md#network-requirements.md).
    * If you need to set up an internet proxy or certificate, please contact Run:ai customer support. 


    __Machine Clocks are not synced__

    Run: `date` on cluster nodes and verify that date/time is correct.  If not,

    * Set the Linux time service (NTP).
    * Restart Run:ai services. Depending on the previous time gap between servers, you may need to reinstall the Run:ai cluster


    __Prometheus pods are not running__

    Run: `kubectl get pods -n monitoring -o wide`

    * Verify that all pods are running.
    * The default Prometheus installation is not built for high availability. If a node is down, the Prometheus pod may not recover by itself unless manually deleted. Delete the pod to see it start on a different node and consider adding a second replica to Prometheus.

??? "GPU Relates metrics not showing"
    __Symptom:__ GPU-related metrics such as `GPU Nodes` and `Total GPUs` are showing zero but other metrics, such as `Cluster load` are shown.

    __Root cause:__ An installation issue relating to the NVIDIA stack.

    __Resolution:__ 

    Need to run through the NVIDIA stack and find the issue. The current NVIDIA stack looks as follows:

    1. NVIDIA Drivers (at the OS level, on every node)
    2. NVIDIA Docker (extension to Docker, on every node)
    3. Kubernetes Node feature discovery (mark node properties)
    4. NVIDIA GPU Feature discovery (mark nodes as “having GPUs”)
    5. NVIDIA Device plug-in (Exposes GPUs to Kubernetes)
    6. NVIDIA DCGM Exporter (Exposes metrics from GPUs in Kubernetes)

    Run:ai requires the NVIDIA GPU Operator which installs the entire stack. However, there are two alternative methods to use the operator:

    * Use the default operator values to install 1 through 6.
    * If the NVIDIA Drivers (#1 above) are already installed on each node, use the operator with a flag that disables drivers install. 
    
    For more information see [Cluster prerequisites](cluster-prerequisites.md#nvidia).

    __NVIDIA GPU Operator__

    Run: `kubectl get pods -n gpu-operator | grep nvidia` and verify that all pods are running.

    __Node and GPU feature discovery__
    
    _Kubernetes Node feature discovery_ identifies and annotates nodes. _NVIDIA GPU Feature Discovery_ identifies and annotates GPU properties. See that: 
    
    * All such pods are up, 
    * The GPU feature discovery pod is available for every node with a GPU.
    * And finally, when describing nodes, they show an active `gpu/nvidia` resource.

    __NVIDIA Drivers__
    
    * If NVIDIA drivers are installed on the nodes themselves, ssh into each node and run `nvidia-smi`. Run `sudo systemctl status docker` and verify that docker is running. Run `nvidia-docker` and verify that it is installed and working.  Linux software upgrades may require a node restart.
    * If NVIDIA drivers are installed by the Operator, verify that the NVIDIA driver daemonset has created a pod for each node and that all nodes are running. Review the logs of all such pods. A typical problem may be the driver version which is too advanced for the GPU hardware. You can set the driver version via operator flags. 


    __NVIDIA DCGM Exporter__

    View the logs of the DCGM exporter and verify that there are no errors porhibiting the sending of metrics. 



??? "Allocation-related metrics not showing"
    __Symptom:__ GPU Allocation-related metrics such as `Allocated GPUs` are showing zero but other metrics, such as `Cluster load` are shown.

    __Root cause:__ The origin of such metrics is the scheduler. 

    __Resolution:__

    * Run: `kubectl get pods -n runai | grep scheduler`. Verify that the pod is running.
    * Review the scheduler logs and look for errors. If such errors exist, contact Run:ai customer support. 

??? "All metrics are showing ""No Data"""
    __Symptom:__ all data on all dashboards is showing the text "No Data".

    __Root cause:__ Internal issue with metrics infrastructure.

    __Resolution:__ Please contact Run:ai customer support.

## Log in and Authentication Issues

??? "After a successful login, you are redirected to the same login page"
    For a self-hosted installation, check Linux clock synchronization as described above. Use the [Run:ai pre-install script](../cluster-setup/cluster-prerequisites.md#pre-install-script) to test this automatically. 

??? "Single-sign-on issues"
    For single-sign-on issues, see the troubleshooting section in the [single-sign-on](../authentication/sso.md#troubleshooting) configuration document. 

## Submit Jobs from User Interface

??? "New Job button is greyed out"
    __Symptom:__ The `New Job` button on the top right of the Job list is grayed out.
    
    __Root Cause:__ This can happen due to multiple configuration issues. 
    
    * Open Chrome developer tools and refresh the screen.
    * Under `Network` locate a network call error. Search for the HTTP error code.

    __Resolution for 401 HTTP Error__

    * The Cluster certificate provided as part of the installation is valid and trusted (not self-signed).
    * [Researcher Authentication](../authentication/researcher-authentication.md) has not been properly configured. Try running `runai login` from the Command-line interface. Alternatively, run: `kubectl get pods -n kube-system`, identify the api-server pod and review its logs. 

    __Resolution for 403 HTTP Error__

    Run `kubectl get pods -n runai` identify the `agent` pod, see that it's running, and review its logs.

??? "New Job button is not showing"
    __Symptom:__ The `New Job` button on the top right of the Job list does not show.

    __Root Causes:__ (multiple)

    * You do not have `Researcher` or `Research Manager` permissions.
    * Cluster version is 2.3 or lower.
    * Under `Settings | General`, verify that `Unified UI` is on.


??? "Submit form is distorted"
    __Symptom:__ xxx

??? "Submit form is not showing after pressing Create Job button"
    __Symptom:__ xxx

??? "Submit form does not show the list of Projects"
    __Symptom:__ xxx

## Symptom: Projects are not syncing

Create a Project on the Run:ai user interface, then run: `runai list projects`. The new Project does __not__ appear.

 __Typical root cause:__ The Run:ai _agent_ is not syncing properly. This may be due to:

 * A dependency on the internal Run:ai database. See [separate](#symptom-internal-database-has-not-started) symptom below
 * Firewall issues

Run:

      runai pods -n runai | grep agent

See if the agent is in _Running_ state. Select the agent's full name and run:

      kubectl logs -n runai runai-agent-<id>

Verify that there are no errors. If there are connectivity-related errors you may need to:

* Check your firewall for outbound connections. See the required permitted URL list in [Network requirements](../cluster-setup/cluster-prerequisites.md#network-requirements.md).
* If you need to setup an internet proxy or certificate, please contact Run:ai customer support. 




## Symptom: Cluster Installation failed on Rancher-based Kubernetes (RKE)

Cluster is not installed. When running `kubectl get pods -n runai` you see that pod `init-ca` has not started

__Resolution__

During initialization, Run:ai creates a Certificate Signing Request (CSR) which needs to be approved by the cluster's Certificate Authority (CA). In RKE, this is not enabled by default, and the paths to your Certificate Authority's keypair must be referenced manually by adding the following parameters inside your cluster.yml file, under kube-controller:

``` YAML
services:
  kube-controller:
    extra_args:
      cluster-signing-cert-file: /etc/kubernetes/ssl/kube-ca.pem
      cluster-signing-key-file: /etc/kubernetes/ssl/kube-ca-key.pem
```

For further information see [here](https://github.com/rancher/rancher/issues/14674){target=_blank}.

## Symptom: Jobs fail with ContainerCannotRun status 

When running `runai list jobs`, your Workload has a status of `ContainerCannotRun`.

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

Run:ai is based on Kubernetes. Kubernetes runs its own internal subnet with a separate DNS service. If you see in the logs that services have trouble connecting, the problem may reside there.  You can find further information on how to debug Kubernetes DNS [here](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/){target=_blank}. Specifically, it is useful to start a Pod with networking utilities and use it for network resolution:

```
kubectl run -i --tty netutils --image=dersimn/netutils -- bash
```

