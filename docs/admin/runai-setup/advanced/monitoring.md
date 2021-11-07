# Cluster Monitoring

## Introduction

Organizations typically want to automatically highlight crirical issues and escalate issues to IT/DevOps personnel. The standard practice is to install an alert management tool and connect it to critical systems. 

Run:AI is comprised of two parts:

* A control plane part, typically residing on the cloud. The health of the cloud portion of Run:AI can be viewed at [status.run.ai](https://status.run.ai){target=_blank}. 
* One or more _GPU Clusters_. 

The purpose of this document is to configure the Run:AI __cluster__ to emit health alerts and to connect these alerts to alert-management systems within the organization


## Alert Infrastructure

Run:AI uses Prometheus for externalizing metrics. The Run:AI cluster installation installs Prometheus or can connect to an existing Prometheus instance used in the organization. 
Run:AI cluster alerts are based on the Prometheus [Alert Manager](https://prometheus.io/docs/alerting/latest/alertmanager/){target=_blank}. The Prometheus Alert Manager is enabled by default.  

This document explains, how to:

* Configure alert destinations. Triggered alerts will send data to destinations.  
* Understand the out-of-the-box cluster alerts. 
* Advanced: add additional custom alerts. 


## Configure Alert Destinations

Prometheus Alert Manager provides a structured way to connect to alert-management systems. Configuration details are [here](https://prometheus.io/docs/alerting/latest/configuration/){target=_blank}. There are built-in plug-ins for popular systems such as PagerDuty and OpsGenie, including a generic webhook. 

Following is an __example__ showing how to integrate Run:AI to a webhook:

* Use [https://webhook.site/](https://webhook.site/){target=_blank}. Get the `Unique URL`.
* When installing the Run:AI cluster, edit the [values file](../cluster-setup/cluster-install.md/#step-3-install-runai) to add the following.

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

(replace `<WEB-HOOK-URL>` with the above).

* On an existing installation, use the [upgrade](../cluster-setup/cluster-upgrade.md) cluster instructions to modify the values file.
* Verify that you have received alerts at [https://webhook.site/](https://webhook.site/){target=_blank}.


## Out-of-the-box Alerts

A Run:AI cluster comes with several built-in alerts. Each alert tests a specific aspect of the Run:AI functionality. In addition, there is a single, inclusive alert, which aggregates all component-based alerts into a single _cluster health test_

The aggregated alert is named `RunaiCriticalProblem`. It is categorized as "critical".

## Add a custom alert

You can add additional alerts from Run:AI. Alerts are triggered by using the [Promtheus query language](https://prometheus.io/docs/prometheus/latest/querying/basics/){default=_blank} with any Run:AI [metric](../../../developer/metrics/metrics.md). To add new alert:

* When installing the Run:AI cluster, edit the [values file](../cluster-setup/cluster-install.md/#step-3-install-runai).
* On an existing installation, use the [upgrade](../cluster-setup/cluster-upgrade.md) cluster instructions to modify the values file.
* Add an alert according to the following structure:


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
          for: <optional: duration s/m/h>>
          labels:
            severity: <critical/warning>
```

You can find an example in the Prometheus documentation [here](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/){target=_blank}.
