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
| RUN-8662  | [Adobe, VGR] - Grayed out submit button when using template with pvc |
| RUN-9212 | [adobe] [2.10] Cant filter jobs by type                                               |
| RUN-9220 | [adobe] PVC does not duplicate                                                        |
| RUN-9221 | [Adobe] runai CLI describe job - nil pointer exception                                |
| RUN-9224 | [Adobe] Scheduler does not report correct event on EFA (status history)               |
| RUN-8276 | [Sony] 503 when creating a workload (request timeout for validation webhook)          |
| RUN-6827 | [VGR] Research - Dashboard in Firefox stays with the 3 dots after some idle time      |
| RUN-9089 | Add port forward to cli in 2.10                                                       |
| RUN-8621 | Change Logo response to 204                                                           |
| RUN-9259 | CLONE - control-plane - [scale] Cluster sync - sync requests are not working at scale |
| RUN-8418 | different user when submitting via runai cli and vi ui submit form                    |
| RUN-9196 | fix runai_dashboard:overview:running_workloads:cpu_only rule                          |
| RUN-9015 | Pods of Distibuted Workloads are missing the "user" annotation                        |
| RUN-9035 | reservation pods are deleted by schedulers from different node pools                  |
| RUN-9252 | runai port-forward should be consistent with runai bash (--target should be --pod)    |
| RUN-8890 | scheduler panic when both project and department with the same name exist             |
| RUN-8192 | UI shows deleted job in the Jobs Current Tab                                          |
| RUN-9166 | wrong numbers in node fitting message for "other resources"                           |
