# What's New for the Run:ai SaaS Platform

The what's new provides transparency into the latest changes and improvements to Run:ai’s SaaS platform. The updates include new features, optimizations, and fixes aimed at improving performance and user experience. 

Latest GA release notes ([https://docs.run.ai/latest/home/whats-new-2-20/](https://docs.run.ai/latest/home/whats-new-2-20/)) 

##  Gradual Rollout

SaaS features and bug fixes are gradually rolled out to customers to ensure a smooth transition and minimize any potential disruption.
SaaS releases follow a scheduled rollout cadence, typically every two weeks, allowing us to introduce new functionalities in a controlled and predictable manner.

In contrast, bug fixes are deployed as needed to address urgent issues and are released immediately to ensure the stability and security of the service.

* Latest release: [February 16-23, 2025](#february-16-23-2025)
* Previous releases: [February 02-09, 2025](#february-02-09-2025)

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
| RUN-25946  | Fixed an issue where the Update Inference Spec API did not enforce a minimum cluster version returning a 400 Bad Request for versions below 2.19. |
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





