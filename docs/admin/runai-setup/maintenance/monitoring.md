# Cluster Monitoring

## Introduction

Organizations typically want to automatically highlight critical issues and escalate issues to IT/DevOps personnel. The standard practice is to install an alert management tool and connect it to critical systems. 

Run:ai is comprised of two parts:

* A control plane part, typically resides in the cloud. The health of the cloud portion of Run:ai can be viewed at [status.run.ai](https://status.run.ai){target=_blank}. In Self-hosted installations of Run:ai is installed on-prem.
* One or more _GPU Clusters_. 

The purpose of this document is to configure the Run:ai to emit health alerts and to connect these alerts to alert-management systems within the organization. 

Alerts are emitted for Run:ai Clusters as well as the Run:ai control plane on Self-hosted installation where the control plane resides on the same Kubernetes cluster as one of the Run:ai clusters. 

 
## Alert Infrastructure

Run:ai uses Prometheus for externalizing metrics. The Run:ai cluster installation installs Prometheus or can connect to an existing Prometheus instance used in the organization. 
Run:ai cluster alerts are based on the Prometheus [Alert Manager](https://prometheus.io/docs/alerting/latest/alertmanager/){target=_blank}. The Prometheus Alert Manager is enabled by default.  

This document explains, how to:

* Configure alert destinations. Triggered alerts will send data to destinations.  
* Understand the out-of-the-box cluster alerts. 
* Advanced: add additional custom alerts. 


## Configure Alert Destinations

Prometheus Alert Manager provides a structured way to connect to alert-management systems. Configuration details are [here](https://prometheus.io/docs/alerting/latest/configuration/){target=_blank}. There are built-in plugins for popular systems such as PagerDuty and OpsGenie, including a generic webhook. 

Following is an __example__ showing how to integrate Run:ai to a webhook:

* Use [https://webhook.site/](https://webhook.site/){target=_blank}. Get the `Unique URL`.
* When installing the Run:ai cluster, edit the [values file](../cluster-setup/cluster-install.md#install-runai) to add the following.

``` YAML
kube-prometheus-stack:
  ...
  alertmanager:
    enabled: true
    config:
      global:
        resolve_timeout: 5m
      receivers:
      - name: "null"
      - name: webhook-notifications
        webhook_configs:
          - url: <WEB-HOOK-URL>
            send_resolved: true
      route:
        group_by:
        - alertname
        group_interval: 5m
        group_wait: 30s
        receiver: 'null'
        repeat_interval: 10m
        routes:
        - receiver: webhook-notifications
```

(Replace `<WEB-HOOK-URL>` with the URL above).

* On an existing installation, use the [upgrade](../cluster-setup/cluster-upgrade.md) cluster instructions to modify the values file.
* Verify that you have received alerts at [https://webhook.site/](https://webhook.site/){target=_blank}.


## Out-of-the-box Alerts

A Run:ai cluster comes with several built-in alerts. Each alert tests a specific aspect of the Run:ai functionality. In addition, there is a single, inclusive alert, which aggregates all component-based alerts into a single _cluster health test_.

The aggregated alert is named `RunaiCriticalProblem`. It is categorized as "critical".

## Add a custom alert

You can add additional alerts from Run:ai. Alerts are triggered by using the [Promtheus query language](https://prometheus.io/docs/prometheus/latest/querying/basics/){default=_blank} with any Run:ai [metric](../../../developer/metrics/metrics.md). To add new alert:

* When installing the Run:ai cluster, edit the [values file](../cluster-setup/cluster-install.md#install-runai).
* On an existing installation, use the [upgrade](../cluster-setup/cluster-upgrade.md) cluster instructions to modify the values file.
* Add an alert according to the structure specified below.


Add more alerts with the following structure:


``` yaml
kube-prometheus-stack:
  additionalPrometheusRulesMap:
    custom-runai:
      groups:
      - name: custom-runai-rules
        rules:
        - alert: <ALERT-NAME>
          annotations:
            summary: <ALERT-SUMMARY-TEXT>
          expr:  <PROMQL-EXPRESSION>
          for: <optional: duration s/m/h>
          labels:
            severity: <critical/warning>
```

You can find an example in the Prometheus documentation [here](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/){target=_blank}.
