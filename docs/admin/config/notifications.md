---
title: Notifications System
summary: This article describes the notifications that are available to the Run:ai platform, and how to configure them.
authors:
    - Jason Novich
    - Shiri Arad
date: 2024-Jul-4
---

## Email Notifications for Data Scientists

Managing numerous data science workloads requires monitoring various stages, including submission, scheduling, initialization, execution, and completion. Additionally, handling suspensions and failures is crucial for ensuring timely workload completion. Email Notifications address this need by sending alerts for critical workload life cycle changes. This empowers data scientists to take necessary actions and prevent delays.

### Setting Up Email Notifications

!!! Important
    The system administrator needs to enable and setup email notifications so that users are kept informed about different system statuses.

To enable email notifications for the system:

1. Press *General settings*, then select *Notifications*.

    !!! Note
        For SaaS deployments, use the *Enable email notifications* toggle.

2. In the *SMTP Host* field, enter the SMTP server address and in the *SMTP port* field the port number.
3. Select an *Authentication type* **Plain** or **Login**. Enter a username and password to be used for authentication.
4. Enter the *From email address* and the *Display name*.
5. Press *Verify* to ensure that the email configuration is working.
6. Press *Save* when complete.

## System Notifications

Administrators can set system wide notifications for all the users in order to alert them of important information. System notifications allows administrators the ability to update users with events that may be occurring within the Run:ai platform. The system notification will appear at each login or after the message has changed for users who are already logged in.

To configure system notifications:

1. Press *General settings*, then select *Notifications*.
2. In the *System notification* pane, press *+MESSAGE*.
3. Enter your message in the text box. Use the formatting tool bar to add special formats to your message text.
4. Enable the "Don't show this again" option to allow users to opt out of seeing the message multiple times.
5. When complete, press *Save & Publish*.

