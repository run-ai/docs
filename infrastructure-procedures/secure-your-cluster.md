# Secure your cluster

This article details the security considerations for deploying Run:ai. It is intended to help administrators and security officers understand the specific permissions required by Run:ai.

## Access to the Kubernetes cluster

Run:ai integrates with Kubernetes clusters and requires specific permissions to successfully operate. These are permissions are controlled with configuration flags that dictate how Run:ai interacts with cluster resources. Prior to installation, security teams can review the permissions and ensure it aligns with their organization’s policies.

### Permissions and their related use-case

Run:ai provides various security-related permissions that can be customized to fit specific organizational needs. Below are brief descriptions of the key use cases for these customizations:

| Permission | Use case |
| :---- | :---- |
| Automatic Namespace creation | Controls whether Run:ai automatically creates Kubernetes namespaces when new projects are created. Useful in environments where namespace creation must be strictly managed. |
| Automatic user assignment | Decides if users are automatically assigned to projects within Run:ai. Helps manage user access more tightly in certain compliance-driven environments. |
| Secret propagation | Determines whether Run:ai should propagate secrets across the cluster. Relevant for organizations with specific security protocols for managing sensitive data. |
| Disabling Kubernetes limit range | Chooses whether to disable the Kubernetes Limit Range feature. May be adjusted in environments with specific resource management needs. |

!!! Note
    These security customizations allow organizations to tailor Run:ai to their specific needs. All changes should be modified cautiously and only when necessary to meet particular security, compliance or operational requirements.

## Secure installation

Many organizations enforce IT compliance rules for Kubernetes, with strict access control for installing and running workloads. OpenShift uses Security Context Constraints (SCC) for this purpose. Run:ai fully supports SCC, ensuring integration with OpenShift's security requirements.

## Security vulnerabilities

The platform is actively monitored for security vulnerabilities, with regular scans conducted to identify and address potential issues. Necessary fixes are applied to ensure that the software remains secure and resilient against emerging threats, providing a safe and reliable experience.

