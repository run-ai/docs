---
title: Researcher Notifications
summary: This article describes researcher notifications and how to configure them.
authors:
    - Jason Novich
    - Shiri   
date: 2024-Jul-4
---

## AI Practitioners Email Notifications

### Importance of Email Notifications for Data Scientists

Managing numerous data science workloads requires monitoring various stages, including submission, scheduling, initialization, execution, and completion. Additionally, handling suspensions and failures is crucial for ensuring timely workload completion.
Email Notifications, introduced in Run:ai version 2.18, address this need by sending alerts for critical workload life cycle changes. This empowers data scientists to take necessary actions and prevent delays.

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
4. When complete, press *Save*.
