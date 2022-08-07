# Try Run:ai on Azure Cloud

You can try Run:ai by starting a virtual machine on Azure. This option is currently limited to a single GPU node. To install a cluster with multiple nodes or for running a formal pilot with Run:ai, use [Cluster Installation](cluster-setup/cluster-install.md).


## Prerequisites

You will need:

* An account in Azure with a quota for GPUs. Run:ai will work with any modern GPU.
* Tenant credentials and data, provided by Run:ai customer support. 


## Create an instance in Azure

* Go to the Azure portal and [create](https://portal.azure.com/#create/Microsoft.VirtualMachine){target=_blank} a virtual machine
* Under `image` select `See all images`. In the Azure marketplace select `Run:ai Quickstart`
* Select a machine size with GPUs. 
* Under the `Advanced` tab select `Enable user data`. Paste the user data provided by Run:ai customer support. It should be in the format:
``` bash
export RUNAI_TENANT=<tenant-name>
export RUNAI_CLIENTID=<client-id>
export RUNAI_SECRET=<secret>
```
* Create the machine.

## Use Run:ai

Go to `https://<tenant-name>.run.ai`. Use credentials provided by Run:ai support.

After ~10 minutes you should have a full working Run:ai cluster.
