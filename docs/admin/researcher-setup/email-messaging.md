# Email notifications

The notifications service listens to events on the Kubernetes cluster and passes notifications of those events via email. The service can be configured to send the notifications to one or more pre configured email addresses, or to the email address of the user that submitted the workload.

Note: In order to send notifications dynamically to the user who submitted the workload, the user should be logged in to the Run:ai UI or CLI.

The service can also be configured using a regular expression to send notifications only for specific namespaces on the cluster. This enables notification only for specific Run:ai projects. The default configuration sends notifications for all the namespaces starting with `runai-`.

## Prerequisites

1. The service should be installed on each cluster used with Run:ai. The installation will be done separately from the Run:ai cluster installation using a new helm chart.
2. As a part of the installation, the customer should provide their SMTP server address as well as credentials for it.

## Available notifications

Configure the notifications service to send events using the relevant `kind` and event `reason`.
The following Run:ai notifications are available:

|Event|Kind|Reason|Description|Additional info|
|:----|:----|:----|:----|:----|
|Pod scheduled|`Pod`|`Scheduled`|a pod was scheduled on a node|Pod, Job, Project, Namespace, User|
|Pod evicted|`PodGroup`|`Evict`|a pod was evicted to make room for another pod with higher priority, or to reclaim resources that belong to other project or department|Pod, Job, Project, Namespace, User|
|Pod unschedulable|`Pod`|`Unschedulable`|a pod was determined as unschedulable and couldn't be scheduled on any node in the cluster| Pod, Job, Project, Namespace, User|
|Failed scheduling pod|`Pod`|`FailedScheduling`|binding a pod to a node failed| Pod, Job, Project, Namespace, User|

!!! Tip
    You can configure the notifications service to send event messages about additional Kubernetes events using the relevant `kind` and event `reason`.
<!--
The following table shows the expected messages for each event:

|Event| Message |
|--|--|
| Pod scheduled | Successfully assigned `namespace`/`pod` to `node`.|
| Pod evicted | Examples of messages explaining why the pod was evicted: <br /><br />Eviction due to priority within same namespace:<br /> Job `namespace`/`pod` was preempted by a job `namespace`/`pod` which has higher priority.<br /><br />Eviction due to reclaim from queue which is over-quota:<br />Job `namespace`/`pod` was reclaimed by job `namespace`/`podGroup`. The reclaimed project uses `x` GPUs with a quota of `y` GPUs. <br /><br />Eviction for consolidation:<br /> Pod `namespace`/`pod` was removed for bin packing. |
| Pod unschedulable |Message explaining different reasons for scheduler not being able to schedule on different nodes. <br /> (for example "All nodes are unavailable: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: test}. 2 node(s) didn't have enough resource: GPUs. 2 node(s) didn't have enough resource: MilliCPUs.")|
| Failed scheduling pod | The error returned from Kubernetes API server, which usually indicates an error in the scheduler or in the cluster. |
-->

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

## Configuration

The notification service is configured using a `configmap` file. The following is an example of a `configmap` file. Each of the tables below references a section in the `configmap` file.

<!-- Need to better understand this.
!!! Note:
    You can change the service configuration values after deployment. Edit the config map and then rerun the `helm install` command above with the `-f` flag.
-->

### `service` configuration

This section defines the number of events that will be sent by the service. Use the following table to configure options in the `service` section of the `configmap` file.

|Component|Field|Description|Default|
|:----|:----|:----|:----|
|`service`|`service.concurrent_limit`|maximum number of events the service will handle in parallel|50|
|`service`|`service.cached_events`|queue size for events before blocking the listener|1000|

### `listener` configuration

This section defines the objects and events that the service will listen to and send as notifications. Use the following table to configure options in the `listener` section of the `configmap` file.

| Component | Field | Description | Default |
| --- |  --- |  --- |  --- |
| `kubelistener` | `listener.relevant_objects` | white list of Kubernetes components for notifications | relevant_objects: <br> `kind:` <br>    `Podreasons:UnschedulableScheduled` <br><br> `kind:` <br>`PodGroupreasons: - Evict` |
| `kubelistener` | `listener.relevant_namespaces` | white list of namespaces that the service should listen to for events (regex) | `runai-.*` |

### `enrich` configuration

!!! Note
    This section of the `configmap` is for internal use only. Keep the default values.

| Component | Field | Default |
| --- | --- | --- |
|`KubeMetadata`|`enricher.kubeMetadata.lables`| `release: workloadDisplayName` <br><br>`training.kubeflow.org/job-name: workloadDisplayName` <br><br>`serving.knative.dev/service: workloadDisplayName` <br><br>`project: project`|
|`KubeMetadata`|`enricher.kubeMetadata.annotations`|`"user": "user"`|

### `notify` configuration

This section defines the notification configuration of the service and contains the details for the SMTP server and the recipients list.
Use the following table to configure options in the `notify` section of the `configmap` file.

|Component|Field|Description|Default|
|--- |--- |--- |--- |
|`Email`|`notify.email.smtp_host` (M)|SMTP server host address|Empty|
|`Email`|`notify.email.smtp_port` (M)|SMTP server port|587|
|`Email`|`notify.email.from_display_name` (M)|email's "From" display name|Run:ai|
|`Email`|`notify.email.from` (M)|a valid domain source email address|<test@run.ai>|
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
        - Unschedulable
        - Scheduled
    - kind: PodGroup
      reasons:
        - Evict
  enrich:
    kubeMetadata:
      labels:
        "release": "workloadDisplayName"
        "training.kubeflow.org/job-name": "workloadDisplayName"
        "serving.knative.dev/service": "workloadDisplayName"
        "project": "project"
      annotations:
        "user": "user"
  notify:
    email:
      template_path: path/email.html  # Internal use only.
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
