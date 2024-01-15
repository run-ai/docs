---
title: Setting up Alert Monitoring for Run:ai Using Alertmanager in Prometheus
summary: This article describes how to set up and configure Alertmanager in Prometheus.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-15
---

## Introduction

This documentation outlines the steps required to set up Alertmanager within the Prometheus Operator ecosystem. It also provides guidance on configuring Prometheus to send alerts to Alertmanager and customizing Alertmanager to trigger alerts based on specific **Run.ai** conditions.

## Prerequisites

* A Kubernetes cluster with the necessary permissions and manage resources.
* `kubectl` command-line tool installed and configured to interact with the cluster.
* Basic knowledge of Kubernetes resources and manifests.
* up and running Prometheus Operator
* Up and running Run.ai environment

## Validate Prometheus Operator Installed

1. Verify that the Prometheus Operator deployment is running:

       `kubectl get deployment prometheus-operator -n runai`
    
       You should see output indicating the deployment's status, including the number of replicas and their current state.

2. Check if Prometheus instances are running:

       `kubectl get prometheus -n runai`
    
       You should see the Prometheus instance(s) listed along with their status.

## Enabling Alertmanager

1. Create an `AlertmanagerConfig` file that triggers alerts on Run.ai events:

        cat <<EOF | kubectl apply -f 
        apiVersion: monitoring.coreos.com/v1alpha1
        kind: AlertmanagerConfig
        metadata:
           name: runai
           namespace: runai
           labels:
              alertmanagerConfig: runai
        EOF

2. Create the Alertmanager CustomResource to enable Alertmanager:

        cat <<EOF | kubectl apply -f - 
        apiVersion: monitoring.coreos.com/v1
        kind: Alertmanager
        metadata:
           name: runai
           namespace: runai
        spec:
           replicas: 1
           alertmanagerConfigSelector:
              matchLabels:
                 alertmanagerConfig: runai
        EOF

3. Exposing the Alertmanager Service

        cat <<EOF | kubectl apply -f - 
        apiVersion: v1
        kind: Service
        metadata:
           name: alertmanager-runai
           namespace: runai
        spec:
           type: NodePort
           ports:
           - name: web
              nodePort: 30903
              port: 9093
              protocol: TCP
              targetPort: web
           selector:
              alertmanager: runai
        EOF

## Configuring Prometheus to Send Alerts

1. Edit the Prometheus configuration:

      `kubectl edit prometheus runai -n runai`

2. Add the following to the `alerting` section:

        alerting:
           alertmanagers:
              - namespace: runai
                name: alertmanager-runai
                port: web

3. Save and exit the editor. The configuration will be automatically reloaded.

## Configuring Alertmanager for Custom Email Alerts

1. Add your smtp password as a secret:

        cat <<EOF | kubectl apply -f 
        apiVersion: v1
        kind: Secret
        metadata:
           name: smtp-password
           namespace: runai
        stringData:
           password: "your_smtp_password"
        EOF

2. Edit the Alertmanager configuration:

       `kubectl edit alertmanagerconfig -n runai`

3. Add to the `spec` section, a new receiver configuration to send alerts via email:

        receivers:
        - name: 'email'
           emailConfigs:
           - to: 'your_email@example.com'
              from: 'alertmanager@example.com'
              smarthost: 'smtp.yourmailprovider.com:587'
              authUsername: 'your_username'
              authPassword:
              name: smtp-password
              key: password

    !!! Note
        Different receivers can be configured using Alertmanager [receiver-integration-settings](https://prometheus.io/docs/alerting/latest/configuration/#receiver-integration-settings){target=_blank}.

4. Add to the `spec` section, a new route that forwards Run.ai alerts to the mail receiver:

        route:
           continue: true
           groupBy: 
           - alertname
             groupWait: 30s
             groupInterval: 5m
             repeatInterval: 1h
           
           matchers:
           - matchType: =~
             name: alertname
             value: Runai.*
        
           receiver: email

5. Save and exit the editor. The configuration will be automatically reloaded.

## Alert Messages

Alerts help you troubleshoot your system and give you a better understanding of currently occurring issues that affect performance. For more insight into the meaning of the alert messages, see []().