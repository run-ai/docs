# Run:ai version 2.11
## Release date

May 2023

## Release content

### Compatibility

Removed support for OpenShift 4.8 and 4.9, and Kubernetes 1.21 and 1.22.

Added support for OpenShift 4.12 and Kubernetes 1.27.

Added support for multiple OpenShift clusters. For configuration information, see [Installing additional Clusters](../admin/runai-setup/self-hosted/ocp/additional-clusters.md)

### Researcher tools enhancements

**OpenShift Dev Spaces**

Added support fort Openshift Dev Spaces custom resource definitions using the RunAI scheduler.

**Cluster API**

Added the following new capabilities for Cluster API capabilities for Researchers:

1. Check the status of the job using the API Researcher API
2. Get container logs using the API - to investigate in case something failed
3. Submit a job using the backend
4. Stop and Suspend / Resume jobs

## Known issues

|Internal ID|Description|Workaround|
|-----------|--------------|--------------|

## Fixed issues

|Internal ID|Description|
|-----------|--------------|
| RUN-6827 | [VGR] Research - Dashboard in Firefox stays with the 3 dots after some idle time      |
| RUN-8621 | Change Logo response to 204                                                           |
| RUN-8662  | [Adobe, VGR] - Grayed out submit button when using template with pvc                 |
| RUN-8890 | scheduler panic when both project and department with the same name exist             |
| RUN-9015 | Pods of Distibuted Workloads are missing the "user" annotation                        |
| RUN-9035 | reservation pods are deleted by schedulers from different node pools                  |
| RUN-9089 | Add port forward to cli in 2.10                                                       |
| RUN-9166 | wrong numbers in node fitting message for "other resources"                           |
| RUN-9259 | CLONE - control-plane - [scale] Cluster sync - sync requests are not working at scale |
