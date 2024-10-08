
  
This article details the data privacy and compliance considerations for deploying Run:ai. It is intended to help administrators and compliance teams understand the data management practices involved with Run:ai. This ensures the permissions align with organizational policies and regulatory requirements before installation and during integration and onboarding of the various teams.

When using the Run:ai [SaaS cluster](../admin/runai-setup/installation-types.md), the Control plane operates through the Run:ai cloud, requiring the transmission of certain data for control and analytics. Below is a detailed breakdown of the specific data sent to the Run:ai cloud in the SaaS offering.

!!! Note
    For organizations where data privacy policies do not align with this data transmission, Run:ai offers a self-hosted version. This version includes the control plane on premise and does not communicate with the cloud.

## Data sent to the Run:ai cloud

| Asset | Details |
| :---- | :---- |
| Workload Metrics | Includes workload names, CPU, GPU, and memory metrics, as well as parameters provided during the `runai submit` command. |
| Workload Assets | Covers environments, compute resources, and data resources associated with workloads. |
| Resource Credentials | Credentials for cluster resources, encrypted with a SHA-512 algorithm specific to each tenant. |
| Node Metrics | Node-specific data including names, IPs, and performance metrics (CPU, GPU, memory). |
| Cluster Metrics | Cluster-wide metrics such as names, CPU, GPU, and memory usage. |
| Projects & Departments | Includes names and quota information for projects and departments. |
| Users | User roles within Run:ai, email addresses, and passwords. |

## Key consideration

Run:ai ensures that no deep-learning artefacts, such as code, images, container logs, training data, models, or checkpoints, are transmitted to the cloud. These assets remain securely within your organization's firewalls, safeguarding sensitive intellectual property and data.  


## See Also

The Run:ai [privacy policy](https://www.run.ai/privacy/){target=_blank}. 