---
title: Notifications
summary: This article describes the notifications that are available to the Run:ai platform, and how to configure them.
authors:
    - Jason Novich
date: 2024-Jul-4
---

## Importance of Email Notifications

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

## System Notifications

Administrators can set system wide notifications for all the users in order to alert them of important information.
