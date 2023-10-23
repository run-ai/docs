# Run:ai version 2.15 - October 28, 2023

## New Features

<!-- RUN-10221/RUN-10426 Projects V2 - User will be able to export a CSV report - NEW FEATURE -->
* Added the ability to download a CSV file from all features that contain a table. Downloading a CSV can provide a snapshot of the feature history over the course of time, and help with compliance tracking. All the columns that are selected (displayed) in the table will be downloaded to the file.

<!-- RUN-7495/RUN11388 Support PSA / SCCs V2 \(security mechanism for pods on K8S/OCP\)-->
* Added support for `restricted` policy for [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){target=_blank} (PSA) on OpenShift only. For more information, see [Pod security admission](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#pod-security-admission).

--8<-- "home/whats-new-2-14.md:6:8"

--8<-- "home/whats-new-2-14.md:15:16"

--8<-- "home/whats-new-2-14.md:18:20"

--8<-- "home/whats-new-2-14.md:26:27"

--8<-- "home/whats-new-2-14.md:29:31"

--8<-- "home/whats-new-2-14.md:33:35"

--8<-- "home/whats-new-2-14.md:45:47"

## Improvements

<!-- RUN-9808/RUN-9810 - Show effective project policy from the UI -->
* Improved the *Projects* table by adding a button to show applied policies. The button is enabled only when the selected project has a policy applied to it. A new page opens where the policy can be viewed. For more information, see [Viewing projecy policies](##View Applied Policies).

<!-- TODO RUN-9943/RUN-12176 Nodes - reflect the correct status of the node - add to nodes page the table from the TW ticket -->
* Improved the readability of the node table to include a more detailed status and its description. For more information, see [Page here](page here)

<!-- RUN-11421 Consumption report - Cost and bugs-->
* Improved the Consumption report interface by moving the Cost settings to the *General* settings menu.

<!-- RUN-7085/RUN-9480 Installation - Cluster wizard Improvements -->
* Improved the *Cluster Wizard* form for adding new clusters to your system.

<!-- RUN-9924/RUN-9925  Granular GPU compute time-slicing / Strict GPU compute time-slicing -->

<!-- RUN-10271/RUN-10321 Mark environment for workload type-->
* Added support for workload types when creating a new or editing and existing environment. Select from `single-node` or `multi-node (distributed)` workloads. The environment is available only on feature forms which are relevant to the workload type selected.

<!-- RUN-10639/RUN-11389 - Researcher Service Refactoring -->
* Improved configuration for authentication in the cluster. Configuring the Kubernetes cluster API server for authentication is no longer needed. This applies to environments where end users are using the UI only and not the CLI.

<!-- RUN-10404/RUN-11747 Submit distributed training
* RUN-11194/RUN-11239 All changes done in the UI for distributed training are hidden behind feature flag 
* RUN-11231/RUN-11240 Environment for distributed training
* RUN-11186/RUN-11241 Submitting an MPI/PT/TF/XGBoost distributed training from UI - 1st form page 
* RUN-11206/RUN-11242 Submitting distributed training from UI - 2nd form page
* RUN-11219/RUN-11602 Submitting an MPI distributed training from UI - 3rd form page
-->
* Added support for distributed training in the *Trainings* form. You can select `single` or `multi-node (distributed)` training. For configuration information, see [Adding tainings](../Researcher/user-interface/trainings.md#adding-trainings). See your Run:ai representative for more information.

<!-- RUN-10411/RUN-11390 Support self-signed certificates-->
* Added support for self signed certificates in air gapped environments.

<!-- RUN-10451/RUN-10452 Support new Kubernetes and OpenShift releases - Q3/2023-->

<!-- RUN-10602/RUN-10603 GPU Memory Request & Limit-->

<!-- RUN-10622/RUN-10625 Policy blocks workloads that attempt to store data on the node-->
* Added the ability to prevent the submission of workloads that use data sources that consists of a host path using policies. This is prevents data from being stored on the node. When a node is deleted, all data stored on that node is lost. For configuration information, see [Prevent Data Storage on the Node](##prevent-data-storage-on-the-node).

--8<-- "home/whats-new-2-14.md:41:43"

<!-- RUN-11282/RUN-11283 Nodepools enabled by default-->
* Improvement in node pools which are now enabled by default. There is no need to enable the feature in the settings.

<!-- RUN-11292/RUN-11592 General changes in favor of any asset based workload \(WS, training, DT\)-->
* Improved the *Trainings* and *Workspaces* forms. Now the runtime field for *Commands* and *Arguments* can be edited even after it has inherited it from the environment.

<!-- RUN-11525/RUN-11538 Support Kubernetes non-privileged PSA on project namespaces for Openshift-->
* Added support for non-privileged PSA on project namespaces for OpenShift environments.

<!-- RUN-11692/RUN-11694 Scoping for template-->
* Added support for *Scope* in the template form. For configuration information, see [Creating templates]().

--8<-- "home/whats-new-2-14.md:49:56"
