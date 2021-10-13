# Data Privacy  

Run:AI [SaaS Cluster installation](../admin/runai-setup/installation-types.md) uses the Run:AI cloud as its control plane. The cluster sends information to the cloud for the purpose of control as well as dashboards. The document below is a run-down of the data that is being sent to the Run:AI cloud.


!!! Note
    If the data detailed below is not in line with your organization's policy, you can choose to install the Run:AI self-hosted version. The self-hosted installation includes the Run:AI control-plane (also called "backend") and will not communicate with the cloud. The self-hosted installation has different pricing. 


## Data

Following is a list of platform data items that are sent to the Run:AI cloud.

| Asset   | Data Details  | Comments |
|---------|---------------|-----------|
| Job Metrics | Job names, CPU, GPU, and Memory metrics, parameters sent using the runai submit command |  |
| Node Metrics | Node names and IPs, CPU, GPU, and Memory metrics |  |
| Cluster Metrics | Cluster names, CPU, GPU, and Memory metrics |  |
| Projects & Departments | Names, quota information |  |
| Users | User roles |  |
| Users | User emails and passwords | Managed by a third party auth0.com. See privacy policy and compliance [statements](https://auth0.com/security){target=_blank} |

Run:AI does __not send__ deep-learning artifacts to the cloud. As such any Code, images, container logs, training data, models, checkpoint and the like stays behind the corporate firewalls. 


## See Also

The Run:AI [privacy policy](https://www.run.ai/privacy/){target=_blank}. 
