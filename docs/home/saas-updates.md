# What's New for the Run:ai SaaS Platform

The what's new provides transparency into the latest changes and improvements to Run:ai’s SaaS platform. The updates include new features, optimizations, and fixes aimed at improving performance and user experience. 

Latest GA release notes ([https://docs.run.ai/latest/home/whats-new-2-20/](https://docs.run.ai/latest/home/whats-new-2-20/)) 

##  Gradual Rollout

SaaS features and bug fixes are gradually rolled out to customers to ensure a smooth transition and minimize any potential disruption.
SaaS releases follow a scheduled rollout cadence, typically every two weeks, allowing us to introduce new functionalities in a controlled and predictable manner.

In contrast, bug fixes are deployed as needed to address urgent issues and are released immediately to ensure the stability and security of the service.

* Latest release: [March 16](#march-16-2025)
* Previous releases: [March 05-09](#march-05-09-2025), [February 16-23](#february-16-23-2025), [February 02-09](#february-02-09-2025)

## March 2025 releases

### March 16, 2025

#### Product enhancements

Enforce SSO tenant setting: An API has been added to the tenant settings, empowering administrators to enforce Single Sign-On (SSO) for their organization. When enabled, this setting ensures that all users are required to authenticate through the configured SSO provider.


#### Resolved Bugs 

| ID | Description |
| :---- | :---- |
| RUN-26686 | Fixed an issue where workload names exceeding 50 characters caused failures due to Kubernetes label length constraints (max 63 characters). |
| RUN-26272 | Fixed an issue where connecting to the SMTP server without credentials was not allowed. |
| RUN-26659 | Fixed an issue where deleting the node pool did not remove it from the default node pools list. |
| RUN-26630 | Fixed an issue that prevented updating tenant-scoped data sources. |
| RUN-26582 | Fixed an issue that prevented [Update IDP API](https://api-docs.run.ai/latest/tag/Idps#operation/update_idp_mappers) from functioning correctly. |
| RUN-25769 | Fixed an issue where unusual text appeared at the end of each line when using the `--help` option for the `runai inference submit --help` command. |
| RUN-25918 | Fixed an issue where the Running/Requested Pods column in the workload list displayed 1/0 instead of the correct format (1/1-3) for inference and other workload types that support minimum and maximum requested pods in the `runai workloads list` command. |
| RUN-26473 | Fixed an issue where removing labels and annotations from a workload created using "Copy & Edit" did not properly remove them. |
| RUN-26107 | Made the [Create IDP API](https://api-docs.run.ai/latest/tag/Idps/#operation/create_idp) validation more robust by ensuring proper URL validation.  |
| RUN-26624 | Fixed an issue which caused workloads to fail if both gpuPortionRequest and gpuPortionLimit were set to 1 (100%). |
| RUN-26270 | Fixed an issue in SSO SAML where the Entity ID field had a different value before and after configuring SAML. |
| RUN-26240 | CLI v2: Fixed an issue in the install script, where setting the install path environment variable did not install all the files in the correct path. |
| RUN-26479 | CLI v2: Fixed an issue where using the wrong workload type in the workload describe command did not display an error. |
| RUN-26345 | CLI v2: Added `UIDGIDSOURCE_CUSTOM` when `SupplementalGroups` is set. |



### March 05-09, 2025

#### Product enhancements

* Added functionality to verify the proper installation of Knative. The UI and API will reflect the status of various features based on their current state in Knative.
* Added the NVIDIA logo to the platform, including the login page and other general areas.
* Audit log: Only users with tenant-wide permissions now have the ability to access audit logs, ensuring proper access control and data security.
* CLI v2: Users will be able to submit workloads and map secrets to volumes using the `--secret-volume` flag. This feature is applicable for all workload types - workspaces, training, and inference.
* SSO OpenID Connect authentication now supports token exchange of JWT tokens with groups in both list and map formats. In map format, the group name is used as the value. This applies to new identity providers only.

#### Resolved Bugs 

| ID | Description |
| :---- | :---- |
| RUN-26310 | Fixed an issue where Docker registry credentials/secrets were not found when adding environment variables. |
| RUN-26253 | CLI v2 list project now supports limit and offset flags. |
| RUN-25382 | Fixed an issue where invalid min/max policy values caused an error in the policy pod. |
| RUN-26135 | Fixed an issue which prevented enabling/disabling email notifications. |
| RUN-25131 | Fixed an issue where authentication failures in the Grafana proxy incorrectly returned a 401 error causing users to be signed out of the UI. |
| RUN-26248 | CLI v2: Fixed an issue where submitting an interactive workload with `--attach` was not possible after the workload started running. |
| RUN-25982 | CLI v2: Fixed an issue where interactive mode did not return an error for invalid control plane/Authentication URLs and timeout duration. |
| RUN-26356 | Fixed an issue where Lowest for over quota weight did not appear as 0. |
| RUN-26249 | Fixed an issue where creating a policy with the fields `tty` and `stdin` resulted in a validation error. |
| RUN-26178 | Fixed an issue where the upgrade to 2.20 failed to migrate departments and projects if the job to validate the default department to clusters ran first. |
| RUN-25895 | Fixed an issue where projects that were updated due to changes in their department override fields were not updated in the cluster. |
| RUN-26152 | GET API for retrieving Workspaces, Trainings, and Inferences by ID returns deleted items. |
| RUN-25987 | Updated all workload APIs to accurately reflect that both creating and deleting workloads return a 202 status code in the API documentation. |
| RUN-25984 | Added a validation message to api/v1/me/password. |
| RUN-26062 | Fixed an issue where a new API, intended for clusters running version 2.18 and above, was not disabled for older clusters, causing unintended workload operations — such as creation, deletion, resumption, or stoppage — after upgrading from versions below 2.18 to 2.18 or higher. |



## February 2025 releases


### February 16-23, 2025

#### Product enhancements

* NIM and model store: UX improvements
* New functionalities added for CLI v2:

    * Allow users to list all available Persistent Volume Claims (PVCs) when submitting workloads. This enhancement simplifies the selection process for appropriate PVCs, making workload submission more efficient.
    * Enable users to display the config file in multiple formats.  The available options are:

        * --json: Output structure in JSON format
        * --yaml: Output structure in YAML format


#### Resolved Bugs 

| ID | Description |
| :---- | :---- |
| RUN-25974 | Fixed an issue where using filters in the Quota management dashboard was not working properly. |
| RUN-25969 | Fixed an issue where the UI incorrectly rejected valid toleration key inputs during validation checks. |
| RUN-25946 | Fixed an issue where the Update Inference Spec API did not enforce a minimum cluster version returning a 400 Bad Request for versions below 2.19. |
| RUN-25921 | Fixed an issue where the Workspaces, Trainings and Distributed APIs did not enforce a minimum cluster version returning a 400 Bad Request for versions below 2.18. |
| RUN-25249 | Fixed an issue where submitting a workload using a yaml file with a port but without service type would use ClusterIP as the default service type. If no host port is provided, the target port will be used as the host. |
| RUN-25269 | Fixed an issue where the Pods modal was not paginated, limiting the display to only 50 records.  |
| RUN-25466 | Fixed an issue where an environment variable with the value SECRET was not valid as only SECRET:xxx was accepted. |
| RUN-23048 | Improved error handling to display meaningful messages from the CLI upgrade command. |
| RUN-25552 | Fixed an issue where clicking on "View Access Rules" in the Users table displayed only the first group if a user belonged to multiple groups. |
| RUN-25558 | Fixed a memory issue when handling external workloads (deployments, ray etc.) which when they were scaled caused ETCD memory to increase. |
| RUN-25659 | CLI v2: Fixed an issue where min and max replicas were able to be submitted using TensorFlow. |


### February 02-09, 2025

#### Product enhancements

- Workload Events API, [/api/v1/workloads/{workloadId}/events](https://api-docs.run.ai/latest/tag/Events#operation/get_workload_events), now supports the sort order parameter (asc, desc).  <!-- (RUN-25180)   -->
- MIG profile and MIG options are now marked as deprecated in CLI v2, following the deprecation notice in the [last version](whats-new-2-20.md#deprecation-notifications). <!-- (RUN-23186)   -->
- As part of inference support in CLI v2, Knative readiness is now validated on submit requests. <!-- (RUN-25177)   -->
- Improved permission error messaging when attempting to delete a user with higher privileges. <!-- (RUN-24366)   -->
- Improved visibility of metrics in the Resources utilization widget by repositioning them above the graphs. <!-- (RUN-25292)   -->
- Added a new Idle workloads table widget to help users easily identify and manage underutilized resources. <!-- (RUN-24376)   -->
- Renamed and updated the "Workloads by type" widget to provide clearer insights into cluster usage with a focus on workloads. <!-- (RUN-23978)   -->
- Improved user experience by moving the date picker to a dedicated section within the overtime widgets, Resources allocation and Resources utilization. <!-- (RUN-23941)   -->
- Simplified configuration by enabling auto-creation of storage class for discovered storage classes. <!-- (RUN-25302)   -->
- Enhanced PVC underlying storage configuration by specifying allowed context for the selected storage (Workload Volume, PVC, both, or neither). <!-- (RUN-25158)   -->
- Added configurable grace period for workload preemption in CLI v2. <!-- (RUN-23760)   -->

#### Resolved Bugs 

| ID | Description |
| :---- | :---- |
| RUN-24838 | Fixed an issue where an environment asset could not be created if it included an environment variable with no value specified. |
| RUN-25031 | Fixed an issue in the Templates form where existing credentials in the environment variables section were not displayed. |
| RUN-25303 | Fixed an issue where submitting with the --attach flag was supported only in a workspace workload. |
| RUN-24354 | Fixed an issue where migrating workloads failed due to slow network connection. |
| RUN-25220 | CLI v2: Changed `--image` flag from a required field to an optional one. |
| RUN-25290 | Fixed a security vulnerability in golang.org/x/net v0.33.0 with CVE-2024-45338 with severity HIGH. |
| RUN-24688 | Fixed an issue that blocked the Create Template submission due to a server error. This occurred when using the Copy & Edit Template form. |
| RUN-25511 | Fixed an issue where deleting a workload in the CLI v2 caused an error due to a missing response body. The CLI now correctly receives and handles the expected response body. |





