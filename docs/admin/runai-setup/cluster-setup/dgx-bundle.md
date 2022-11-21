<!-- DGX Bundle -->
# Run:ai & NVIDIA DGX Bundle


NVIDIA [DGX](https://www.nvidia.com/en-us/data-center/dgx-systems/){target=_blank} is a line of NVIDIA-produced servers and workstations which specialize in using GPUs to accelerate deep learning applications.

NVIDIA DGX comes bundled out of the box with Run:ai. The purpose of this document is to guide you through the process of installing and configuring Run:ai in this scenario


## NVIDIA Bright Cluster Manager

[NVIDIA Bright Cluster Manager](https://www.nvidia.com/en-us/data-center/bright-cluster-manager/){target=_blank} allows the deployment of software on NVIDIA DGX servers. During the installation of the DGX you will select `Run:ai` as well as Run:ai prerequisites from the Bright installer.

## Prerequisites 

### Software Prerequisites

Run:ai assumes the following components to be pre-installed:

* `NVIDIA GPU Operator` - available for installation via the bright installer
* `Prometheus` - available for installation via the bright installer
* `Ingress controller` - NGINX is available for installation via the bright installer. 


###  Run:ai prerequisites 

The Run:ai cluster installer will require the following:

* `Run:ai tenant name` - provided by Run:ai customer support.
* `Run:ai install secret` - provided by Run:ai customer support.
* `Cluster URL` - your organization should provide you with a domain name.
* `Private and public keys` -your organization should provide a __trusted__ certificate for the above domain name. The Run:ai installer will require both private key and full-chain in PEM format. 
* Post-installation - credentials for the Run:ai user interface. Provided by Run:ai customer support.
## Installing Run:ai installer

Select Run:ai via the bright installer. Remember to select all of the above software prerequisites as well. 

## Using the Run:ai installer

Find out the cluster's IP address. Then browse to `http://<CLUSTER-IP>:30080/runai-installer`. Alternatively use the Bright landing page at `http://<CLUSTER-IP>/#runai`.  

!!! Note
    * Use `http` rather than `https`.
    * Use the IP and not a domain name.

A wizard would open up containing 3 pages: Prerequisites, setup, and installation. 


### Prerequisites Page

The first, verification page, verifies that all of the above software prerequisites are met. Press the "Verify" button. You will not be able to continue unless all prerequisites are met. When all are met, press the `Continue` button. 

### Setup Page

The setup page asks to provide all of the Run:ai prerequisites described above. The page will verify the Run:ai input (tenant name and install secret) but will not verify the validity of the cluster URL and certificate. If those are incorrect, the Run:ai installation will show as successful but certain aspects of Run:ai will not work. 

After filling up the form, press `Continue`. 

### Installation page

The Run:ai installation will start. Depending on your download network speed the installation can take from 2 to 10 minutes. When the installation is successful you will see a `START USING RUN:AI` button. Press the button and enter your credentials to enter the Run:ai user interface. 

Save the URL for future use. 


## Post-installation. 

Post installation, you will want to:

* (Mandatory) Set up [Researcher Access Control](../authentication/researcher-authentication.md). Without this, the Job Submit form will not work. Note the _Bright_ section in that document.
* Set up Run:ai Users [Working with Users](../../admin-ui-setup/admin-ui-users.md).
* Set up Projects for Researchers [Working with Projects](../../admin-ui-setup/project-setup.md).

## Troubleshooting

The cluster installer is a pod in Kubernetes. The pod is responsible for the installation preparation and prerequisite gathering phase. In case of an error during this pre-installation, you need to gather the pod's log. 

Once the Run:ai cluster installation has started, the behavior is identical to any Run:ai cluster installation flavor. See the [troubleshooting page](../../troubleshooting/troubleshooting.md).
