# What's New for the Run:ai SaaS Platform

The what's new provides transparency into the latest changes and improvements to Run:ai’s SaaS platform. The updates include new features, optimizations, and fixes aimed at improving performance and user experience. 

Latest GA release notes ([https://docs.run.ai/latest/home/whats-new-2-20/](https://docs.run.ai/latest/home/whats-new-2-20/)) 

##  Gradual Rollout

SaaS features are gradually rolled out to customers over the course of a week to ensure a smooth transition and minimize any potential disruption. 

## February 9th release

### Resolved Bugs 

| ID | Description |
| :---- | :---- |
| RUN-25511| Fixed an issue where deleting a workload in the new CLI caused an error. |
| RUN-25234 | Fixed an authentication issue in CLI V1. |
| RUN-25098 | Improved workload metrics by reducing the time it takes for workload metrics to be displayed. |
| RUN-24032 | Fixed an issue where inference workloads with large container sizes skipped the Initializing state. |
| RUN-24754| Fixed an issue where the status of training and interactive workloads was not updated correctly. |


## February 3rd release 

### Product enhancements

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

### Resolved Bugs 

| ID | Description |
| :---- | :---- |
| RUN-24838 | Fixed an issue where an environment asset could not be created if it included an environment variable with no value specified. |
| RUN-25031 | Fixed an issue in the Templates form where existing credentials in the environment variables section were not displayed. |
| RUN-25303 | Fixed an issue where submitting with the --attach flag was supported only in a workspace workload. |
| RUN-24354 | Fixed an issue where migrating workloads failed due to slow network connection. |
| RUN-25220 | CLI v2: Changed `--image` flag from a required field to an optional one. |
| RUN-25290 | Fixed a security vulnerability in golang.org/x/net v0.33.0 with CVE-2024-45338 with severity HIGH. |
| RUN-24688 | Fixed an issue that blocked the Create Template submission due to a server error. This occurred when using the Copy & Edit Template form. |




