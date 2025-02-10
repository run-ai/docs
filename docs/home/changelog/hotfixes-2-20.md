---
title: Changelog Version 2.19
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.

---

This section provides details on all hotfixes available for version 2.20. Hotfixes are critical updates released between our major and minor versions to address specific issues or vulnerabilities. These updates ensure the system remains secure, stable, and optimized without requiring a full version upgrade. 

## Hotfixes


| Version | Date | Internal ID | Description |
|--|--|--|--|
| 2.20.18 | 24/01/2025 | RUN-24700 |  CLI v2: Workload describe command no longer requires type or framework flags. |
| 2.20.17 | 24/01/2025 | RUN-25534 | Fixed range of generated reports to 30 days. |
| 2.20.17 | 24/01/2025 | RUN-25466 | Fixed an issue where an environment variable with the value SECRET was not valid as only SECRET:xxx was accepted. |
| 2.20.16 | 24/01/2025 | RUN-24858 | Fixed High vulnerability CVE-2024-56344 for third party open source 'systeminformation'. |
| 2.20.15 | 24/01/2025 | RUN-24354 | Fixed an issue where migrating workloads failed due to slow network connection. |
| 2.20.15 | 24/01/2025 | RUN-24354 | Fixed an issue where migrating workloads failed due to slow network connection. |
| 2.20.15 | 24/01/2025 | RUN-24354 | Fixed an issue where migrating workloads failed due to slow network connection. |
| 2.20.14 | 23/01/2025 | RUN-24754 | Fixed an issue where the status of training and interactive workloads was not updated correctly. |
| 2.20.14 | 23/01/2025 | RUN-24838 | Fixed an issue where an environment asset could not be created if it included an environment variable with no value specified. |
| 2.20.11 | 21/01/2025 | RUN-25303 | Fixed an issue where submitting with the --attach flag was supported only in a workspace workload. |
| 2.20.11 | 21/01/2025 | RUN-25291 | Fixed a security vulnerability in golang.org/x/net v0.33.0 with CVE-2024-45338 with severity HIGH. |
| 2.20.10 | 20/01/2025 | RUN-25234 | Fixed an authentication issue in CLI V1. |
| 2.20.9 | 19/01/2025 | RUN-25032 | Fixed an issue where inference workloads with large container sizes skipped the Initializing state. |
| 2.20.9 | 19/01/2025 | RUN-24752 | Fixed an issue where a workload would move to a failed state when created with a custom NodePort that was already allocated. |
| 2.20.9 | 19/01/2025 | RUN-25031 | Fixed an issue in the Templates form where existing credentials in the environment variables section were not displayed. |
| 2.20.5 | 14/01/2025 | RUN-25061 | Fixed a security vulnerability in github.com.go-git.go-git.v5 with CVE CVE-2025-21613 with severity HIGH. |


