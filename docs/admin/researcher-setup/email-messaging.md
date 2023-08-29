# Email notifications

The notifications service listens to events on the Kubernetes cluster and passes notifications of those events via email. The service can be configured to send the notifications to one or more pre configured email addresses, or to the email address of the user that submitted the workload.

Note: In order to send notifications dynamically to the user who submitted the workload, the user should be logged in to the Run:ai UI or CLI.

The service can also be configured using a regular expression to send notifications only for specific namespaces on the cluster. This enables notification only for specific Run:ai projects. The default configuration sends notifications for all the namespaces starting with `runai-`.

## Prerequisites

1. The service should be installed on each cluster used with Run:ai. The installation will be done separately from the Run:ai cluster installation using a new helm chart.
2. As a part of the installation, the customer should provide their SMTP server address as well as credentials for it.

## Available notifications


The following Run:ai notifications are available for email notifications:

|Event|Kind (for config)|Reason (for config)|Description|Run:ai version|Additional info|
|:----|:----|:----|:----|:----|:----|
|Pod Scheduled|`Pod`|`Scheduled`|a pod was scheduled on a node|2.9 and above|Pod, Job, Project, Namespace, User|
|Pod Evicted|`PodGroup`|`Evict`|a pod was evicted to make room for another pod with higher priority, or to reclaim resources that belong to other project or department|2.9 and above|Pod, Job, Project, Namespace, User|
|Pod unschedulable|`Pod`|`Unschedulable`|a pod was determined as unschedulable and couldn't be scheduled on any node in the cluster|2.9 and above|Pod, Job, Project, Namespace, User|
|Failed scheduling pod|`Pod`|`FailedScheduling`|binding a pod to a node failed|2.9 and above|Pod, Job, Project, Namespace, User|
You can configure the notifications service to listen to other Kubernetes events and send it via email by using the relevant `Kind` and event `Reason`.
## Installation

Install the notification service using the following commands:

1. Set the helm repo to point to the notification service package using the following command:

```
helm repo add runai-notifications-service https://storage.googleapis.com/runai-notifications-service/

helm repo update
```

2. Check for the latest version using the following command

```
helm repo search runai-notifications-service 

```

3. Install the latest version using the following command:

```
helm install runai-notifications-service/notifications-service --version 0.0.0
```

Note:

You can change the service configuration values with the -f flag or edit them after installation.

## Configuration

The notification service is configured using a `configmap` file. The following is an example of a `configmap` file. Each of the tables below references a section in the `configmap` file.

### `service` configuration

This section defines the number of events that will be sent by the service. Use the following table to configure options in the `service` section of the `configmap` file.

|Component|Field|description|default|
|:----|:----|:----|:----|
|`service`|`service.concurrent_limit`|maximum number of events the service will handle in parallel|50|
|`service`|`service.cached_events`|queue size for events before blocking the listener|1000|

### `listener` configuration

This section defines the objects and events that the service will listen to and send as notifications. Use the following table to configure options in the `listener` section of the `configmap` file.

| Component | Field | description | default |
| --- |  --- |  --- |  --- |
| `kubelistener` | `listener.relevant_objects` | white list of Kubernetes components for notifications | relevant_objects: <br> `kind:` <br>    `Podreasons:UnschedulableScheduled` <br><br> `kind:` <br>`PodGroupreasons: -Evict` |
| `kubelistener` | `listener.relevant_namespaces` | white list of namespaces that the service should listen to for events (regex) | `runai-.*` |

### `enrich` configuration

Use the following table to configure options in the `enrich` section of the `configmap` file.

| Component | Field | description | default |
| --- |  --- |  --- |  --- |
|`KubeMetadata`|`enricher.kubeMetadata.lables`|maps the event related object labels to specific properties in the output event | `release: workloadDisplayName` <br><br>`training.kubeflow.org/job-name: workloadDisplayName` <br><br>`serving.knative.dev/service: workloadDisplayName` <br><br>`project: project`|
|`KubeMetadata`|`enricher.kubeMetadata.annotations`|maps the related object annotations to event properties|`"user": "user"`|

### `notify` configuration

This section defines the notification configuration of the service and contains the details for the SMTP server and the recipients list.
Use the following table to configure options in the `notify` section of the `configmap` file.

|Component|Field|description|default|
|--- |--- |--- |--- |
|`Email`|`notify.email.smtp_host` (M)|SMTP server host address|Empty|
|`Email`|`notify.email.smtp_port` (M)|SMTP server port|587|
|`Email`|`notify.email.from_display_name` (M)|email's "From" display name|Run:ai|
|`Email`|`notify.email.from` (M)|a valid domain source email address|test@run.ai|
|`Email`|`notify.email.user` (M)|SMTP server user login|user|
|`Email`|`notify.email.password` (M)|SMTP server user's password |password|
|`Email`|`notify.email.direct_notifications` (together with Recipients)|when set to true, email notifications will be sent dynamically to the user who submitted the workload|false|
|`Email`|`notify.email.recipients` (together with Direct Notifications)|additional email address recipients list for all the events - broadcast|Empty list|

**(M)** = mandatory to include in the `configmap` file.

### Example `configmap` file

The following file is an example of a configmap file for the notification service.

```
  service:
    concurrent_limit: 50
    cached_events: 1000
  listener:
    relevant_namespaces:
    - runai.*
    relevant_objects:
    - kind: Pod
      reasons:
        - Evict
        - Scheduled
  enrich:
    kubeMetadata:
    # <Both labels and annotations are maps of kube metadata keys to event property keys that can be used in notification templates>
      labels:
        ...
      annotations:
        ...
  notify:
    email:
      template_path: path/email.html
      from: my@mail.com
      user: smtp_user
      password: smtp_password
      smtp_host: smtp.mail.com
      smtp_port: 587
      from_display_name: Company Name
      direct_notifications: true
      recipients:
      - some@mail.com
```
