# Designating Specific Role Nodes

When installing a production cluster you may want to:

* Set one or more Run:ai system nodes. These are nodes dedicated to Run:ai software. 
* Machine learning frequently requires jobs that require CPU but __not GPU__. You may want to direct these jobs to dedicated nodes that do not have GPUs, so as not to overload these machines. 
* Limit Run:ai monitoring and scheduling to specific nodes in the cluster. 

To perform these tasks you will need the Run:ai Administrator CLI. See [Installing the Run:ai Administrator Command-line Interface](cli-admin-install.md).

## Dedicated Run:ai System Nodes

Find out the names of the nodes designated for the Run:ai system by running `kubectl get nodes`. For each such node run:

```
runai-adm set node-role --runai-system-worker <node-name>
```

If you re-run `kubectl get nodes` you will see the node role of these nodes changed to `runai-system`

To remove the runai-system node role run:

```
runai-adm remove node-role --runai-system-worker <node-name>
```

!!! Warning
    Do not select the Kubernetes master as a runai-system node. This may cause Kubernetes to stop working (specifically if Kubernetes API Server is configured on 443 instead of the default 6443).

## Dedicated GPU & CPU Nodes

Separate nodes into those that:

* Run GPU workloads
* Run CPU workloads
* Do not run Run:ai at all. these jobs will not be monitored using the Run:ai Administration User interface. 

Review nodes names using `kubectl get nodes`. For each such node run:

```
runai-adm set node-role --gpu-worker <node-name>
```

or 

```
runai-adm set node-role --cpu-worker <node-name>
```

Nodes not marked as GPU worker or CPU worker will not run Run:ai at all.


To set __all__ workers not running runai-system as GPU workers run:

```
runai-adm set node-role --all <node-name>
```

To remove the CPU or GPU worker node role run:

```
runai-adm remove node-role --cpu-worker <node-name>
```

or 

```
runai-adm remove node-role --gpu-worker <node-name>
```