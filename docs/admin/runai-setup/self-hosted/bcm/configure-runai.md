# Next Steps

## Configure Single Sign-On for user authentication

Refer to: [Single Sign-On - Run:ai Documentation Library](https://docs.run.ai/v2.19/admin/authentication/sso/openidconnect/?h=ss)

1. Log in to the Run:ai user portal and go to Settings->General:

Adding the identity provider[¶](https://docs.run.ai/v2.19/admin/authentication/sso/openidconnect/?h=ss#adding-the-identity-provider)
1. Go to **Admin**
2. Open the Security section and click **+IDENTITY PROVIDER**
![](WARN_REPLACE_IMG_URL)
3. Select **Custom OpenID Connect**
![](WARN_REPLACE_IMG_URL)
4. Enter the **Discovery URL**, **Client ID**, and **Client Secret**
5. Copy the Redirect URL to be used in your identity provider
6. Optional: Add the OIDC scopes
![](WARN_REPLACE_IMG_URL)
7. Optional: Enter the user attributes and their value in the identity provider (see the user attributes table below)
8. Click **SAVE
**
Once you press Save you will receive a Redirect URI and an Entity ID. Both values must be set on the IdP side.

### **Validate**
Test Connectivity to Administration User Interface:
* Using an incognito browser tab and open the Run:ai user interface.
* Select the Login with SSO button.
* You will be redirected to the IdP login page.

## Configure Kubectl and the Run:ai CLI for a researcher

Reference: [Researcher Authentication - Run:ai Documentation Library](https://docs.run.ai/v2.19/admin/authentication/researcher-authentication/#command-line-interface-access)

To authenticate the `runai login user -up <USERNAME>` command.

To submit a NCCL workload:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

## Configure Workload policies
Reference: [Policies - Run:ai Documentation Library](https://docs.run.ai/v2.19/platform-admin/workloads/policies/overview/)

First, you need to enable workload policies. To do that navigate to `Admin->General settings->Workloads` and toggle the `Policies` setting to on.

![](WARN_REPLACE_IMG_URL)

They can be applied on the cluster by Navigating to `Policies->New Policy`:
![](WARN_REPLACE_IMG_URL)

Select the policy scope and type:

![](WARN_REPLACE_IMG_URL)

And then click the “+ POLICY YAML” text to add the rules. An editor will pop-up. Paste the policy YAML and click “Apply”.

![](WARN_REPLACE_IMG_URL)

Sample mixed policy:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

## Configure distributed workloads
Reference: [https://docs.run.ai/v2.19/admin/runai-setup/cluster-setup/cluster-prerequisites#distributed-training](https://docs.run.ai/v2.19/admin/runai-setup/cluster-setup/cluster-prerequisites/?h=system#distributed-training)
Distributed training allows the Researcher to train models over multiple nodes. Run:ai supports the following distributed training frameworks:
* TensorFlow
* PyTorch
* XGBoost
* MPI
All are part of the *Kubeflow Training Operator*. Run:ai supports Training Operator version 1.7. The Kubeflow Training Operator gets installed as part of the BCM Kubernetes Deployment:

The Kuberflow Training Operator is packaged with MPI version 1.0 which is **not** supported by Run:ai. You need to separately install MPI v2beta1:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

Disable MPI in the Training operator by running:
(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

* Run: `kubectl delete crd mpijobs.kubeflow.org`
* Install MPI v2beta1 again:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

## Inference workloads
Reference: [https://docs.run.ai/v2.19/admin/runai-setup/cluster-setup/cluster-prerequisites#inference](https://docs.run.ai/v2.19/admin/runai-setup/cluster-setup/cluster-prerequisites#inference)

Inference enables serving of AI models. This requires the[ Knative Serving](https://knative.dev/docs/serving/) framework to be installed on the cluster and supports Knative versions 1.10 to 1.15

Install the Knative CRDs:
(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

Install Knative-serving:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

Deploy the Koerier Ingress:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

Patch the Knative deployment:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

The Koerier Ingress IP will be assigned by MetalLB and can be retrieved with:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

(WARN_UNRECOGNIZED_ELEMENT: PERSON)
- We need to add a DNS Entry for a start domain - for inference
For example
*.bcm-runai-1.nvidia.com == [ Resolve to the MatalLB Address ]

Note:
1. We never tested knative/Kourier with metalLB , we need to check if auto-scale works.
Update: I tested metalLB with knative and autoscale worked ! - so i think we are good to go here
(WARN_UNRECOGNIZED_ELEMENT: PERSON)

We need a new SSL Certificate for our new  start domain
2. If we are using sub-domain support - we need a whole new DSN Entry, for example *.inference-bcm-runai-1.nvidia.com
 1. Sub-domain = *.bcm-runai-1.nvidia.com is needed in case customers want to use vscode or out of the box streamlit neill be used for VSCODE

 2. 10. Cluster Validation

## 10.1 Preparation

##### Create a project

Start by creating  a new project in Run:ai called validation.

For more details on Run:ai projects please refer to the [official documentation](https://docs.run.ai/v2.19/platform-admin/aiinitiatives/org/projects/).

To create a new project, select `Organization `and then hit the `New Project` button:

## ![](WARN_REPLACE_IMG_URL)

Enter the project name and GPU quota and then click Create Project:

![](WARN_REPLACE_IMG_URL)

##### Add a container registry pull secret

Add an NVCR pull secret so that Kubelet can pull the NVIDIA NEMO Megatron container.
From the` Workload Manager`, select `Assets` and then `New Credentials`:

![](WARN_REPLACE_IMG_URL)

and then choose `Docker Registry`:

## ![](WARN_REPLACE_IMG_URL)

Set the following:

* Scope: The whole Run:ai cluster
* Credential name: **nvcr-secret**
* Username: **$oauthtoken**
* Password: The NVCR personal key of the customer
* Docker registry URL: **nvcr.io**

![](WARN_REPLACE_IMG_URL)

##### Create a HostPath data source

From the` Workload Manager`, select `Assets` and then `Data Sources->Host Path`:

![](WARN_REPLACE_IMG_URL)

Set the following:

* Scope: The **validation **project
* Data source name: **validation name**
* Data origin**:  **some path on the distributed file system (DDN, VAST, Weka etc.)
* Mount path: **/mount/data**

## ![](WARN_REPLACE_IMG_URL)

##### Create a Run:ai application token

Select `Access` -> `Application `and then `New Application:`

![](WARN_REPLACE_IMG_URL)

Give the new application a unique name and click `Create`:

![](WARN_REPLACE_IMG_URL)

Copy and save the application name and secret:

![](WARN_REPLACE_IMG_URL)

And store it $HOME/.runai-validation.ini

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

Select the newly created application and then click `Access Rules`:

![](WARN_REPLACE_IMG_URL)

Assign the following Access Rules to the application and save:

![](WARN_REPLACE_IMG_URL)![](WARN_REPLACE_IMG_URL)

##### Checkout the validation code

The following requires access to NV CorpNet and a valid GitLab account:
Download the validation code and then copy it and extract it on the BCM headnode. The validation can be downloaded from:

[Download Link](https://gitlab-master.nvidia.com/kuberpod/runai-validation/-/archive/main/runai-validation-main.zip)

[GitLab repository](https://gitlab-master.nvidia.com/kuberpod/runai-validation)

## 10.2 NCCL

Switch to the validation code directory.

The basic syntax of the command is the following:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

The above script will create a two node NCCL job.

For your convenience a number of scripts for various cluster sizes are provided named nccl-test-<N>.sh, where N is the number of nodes e.g. nccl-test-32.sh for a 32 node NCCL workload.

The results can be retrieved by fetching the  launched pod logs:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

## 10.3 HPL
Similarly HPL workloads can be submitted using the same utility:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

For your convenience a number of scripts for various cluster sizes are provided named hpl-test-<N>.sh, where N is the number of nodes e.g. hpl-test-32.sh for a 32 node HPL workload.

The results can be retrieved by fetching the  launched pod logs:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

## 10.4 LLM
Download the dataset from the Google drive [Link] and extract on the directory that used for the HostPath volume above. Note that this is a large file (10 GB compressed, ~15 GB when extracted).

[[Download](https://drive.google.com/drive/u/2/folders/1myHawOcqA13LuCMgHV3SBC7H-ATcDkj2) ]

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

For your convenience a number of scripts for various cluster sizes are provided named llm-test-<N>.sh, where N is the number of nodes e.g. llm-test-32.sh for a 32 node Nemo Megatron GPT-3 (8B) LLM  workload.

To see the training metrics, Run:ai provides the ability to start a Tensorboard instance at attach it to the logs directory of the workload.

In the Run:ai Web UI, select:
 `Workload Manager -> Workloads -> New workload -> Workspace`:

![](WARN_REPLACE_IMG_URL)

Select the Run:ai project name, enter a unique name for the TensorBoard instance and click Continue:

![](WARN_REPLACE_IMG_URL)

Select `Tensorboard` in the `Environments `section:

![](WARN_REPLACE_IMG_URL)

Expand the `Runtime Settings` section and enter the following `Arguments`:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

![](WARN_REPLACE_IMG_URL)

Select `cpu-only` in the compute resource section as shown below:

![](WARN_REPLACE_IMG_URL)

Finally, scroll down to the Data Source section and select the HostPath data source that was created earlier:

![](WARN_REPLACE_IMG_URL)

The workload will run for 24 hours, but it can be stopped early. To save the training results copy the following files:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

Once the Tensorboard instance has entered the Running phase:

![](WARN_REPLACE_IMG_URL)

Click the Connect button. You should be able to see the metrics from the current as well as previous runs.

![](WARN_REPLACE_IMG_URL)

# 11. Disaster recovery

## 11.1 BCM CMDaemon configuration back-ups
CMDaemon uses a MariaDB database to store its configuration. There is a  daily Cron job backing up that database. The cron job is executed on each headnode separately and the back-ups are saved to **/var/spool/cmd/backup**. If needed, the daily DB backup’s  can be mirrored to the shared storage.

Caution: Do not edit the daily cron job: /etc/cron.daily/cmdaemon-backup as back-ups will fail to be generated if the shared storage becomes unavailable. Instead, create a new cron job that RSYNCs the daily CMDaemon database back-ups to shared share. In that case, even if the storage becomes unavailable, there will be a local daily backup on each headnode.

## 11.2 Etcd back-ups
Add the following Bash script to /cm/images/<k8s control plane node image>/etc/cron.daily/etcd-backup.sh and set the executable flag (chmod +x …):

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

In /cm/images/knode-image/usr/local/bin/etcd-backup.sh:

(WARN_UNRECOGNIZED_ELEMENT: CODE_SNIPPET)

Adjust the retention period as needed. A daily back-up requires 60-120 MB of disk space in /cm/shared/backups.

Push the file to the nodes.


## 11.3 Run:ai disaster recovery

Reference: [https://docs.run.ai/latest/admin/config/dr/](https://docs.run.ai/latest/admin/config/dr/)




