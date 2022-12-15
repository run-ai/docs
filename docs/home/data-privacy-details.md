# Data Privacy  

Run:ai [SaaS Cluster installation](../admin/runai-setup/installation-types.md) uses the Run:ai cloud as its control plane. The cluster sends information to the cloud for the purpose of control as well as dashboards. The document below is a run-down of the data that is being sent to the Run:ai cloud.


!!! Note
    If the data detailed below is not in line with your organization's policy, you can choose to install the Run:ai self-hosted version. The self-hosted installation includes the Run:ai control-plane and will not communicate with the cloud. The self-hosted installation has different pricing. 


## Data

Following is a list of platform data items that are sent to the Run:ai cloud.

| Asset   | Data Details  | 
|---------|---------------|
| Job Metrics | Job names, CPU, GPU, and Memory metrics, parameters sent using the `runai submit` command |
| Node Metrics | Node names and IPs, CPU, GPU, and Memory metrics |
| Cluster Metrics | Cluster names, CPU, GPU, and Memory metrics |
| Projects & Departments | Names, quota information |
| Users | User Run:ai roles, emails and passwords (when single-sign on not used) |

Run:ai does __not send__ deep-learning artifacts to the cloud. As such any Code, images, container logs, training data, models, checkpoints and the like, stay behind corporate firewalls. 


## See Also

The Run:ai [privacy policy](https://www.run.ai/privacy/){target=_blank}. 
