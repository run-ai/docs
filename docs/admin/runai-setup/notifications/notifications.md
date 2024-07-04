---
title: Notifications
summary: This article describes the notifications that are available to the Run:ai platform, and how to configure them.
authors:
    - Jason Novich
date: 2024-Jul-4
---

## Email Notifications

This document provides an overview of Run:ai's Email Notifications feature, designed to keep data scientists informed about their workload statuses.

### Importance of Email Notifications for Data Scientists

Managing numerous data science workloads requires monitoring various stages, including submission, scheduling, initialization, execution, and completion. Additionally, handling suspensions and failures is crucial for ensuring timely workload completion.
Email Notifications, introduced in Run:ai version 2.18, address this need by sending alerts for critical workload life cycle changes. This empowers data scientists to take necessary actions and prevent delays.

### Setting Up Email Notifications

The system administrator needs to enable and setup email notifications so that users are kept informed about different system statuses.

To enable email notifications for the system:

1. Press *Tools & Settings*, then select *Notifications*.
2. In the *SMTP Host* field, enter the SMTP host and port number.
3. Select an *Authentication type*:
   1. **Plain**&mdash;enter a username and password to be used for authentication.
   2. **Login**&mdash;enter a username and password to be used for authentication.
4. Enter the *From email address* and the *Display name*.
5. Press *Verify* to ensure that the email configuration is working.
6. Press *Save* when complete.

#### AI Practitioners Notification statuses

Once the system administrator configures the email notifications, users will receive notifications about their jobs that transition from one status to another. In addition, the user will get warning notifications before workload termination due to project-defined timeouts. Details included in the email are:

* Workload type
* Project and cluster information
* Event timestamp

!!! Note
    For AI practitioners to receive notification emails for their jobs, they will need to add the configuration to the personal settings.

To configure the types of email notifications a user can receive:

1. The user must log in to their account.
2. Press the user icon, then select settings.
3. In the *Email notifications*, and in the *Send me an email about my workloads when* section, select relevant workload statuses to receive an email about.
4. When complete, press *save*.

## System Notifications

Administrators can set system wide notifications for all the users in order to alert them of important information.