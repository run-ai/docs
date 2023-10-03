# Setting up Alert Monitoring for Run:ai Using Alertmanager in Prometheus

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

       `kubectl get deployment kube-prometheus-stack-operator -n monitoring`
    
       You should see output indicating the deployment's status, including the number of replicas and their current state.

2. Check if Prometheus instances are running:

       `kubectl get prometheus -n runai`
    
       You should see the Prometheus instance(s) listed along with their status.

## Enabling Alertmanager
In each step copy the content to a file and apply it to the cluster using `kubectl apply -f`

1. Create the Alertmanager CustomResource to enable Alertmanager:

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

2. Validate that your alertmanager instance has started:

        kubectl get alertmanager -n runai

3. Validate that prometheus operator has created a service for alertmanager:

         kubectl get svc alertmanager-operated -n runai

## Configuring Prometheus to Send Alerts

1. Edit the Prometheus configuration:

      `kubectl edit prometheus runai -n runai`

2. Add the following to the `spec.alerting` section:

        alerting:
           alertmanagers:
              - namespace: runai
                name: alertmanager-operated
                port: web

3. Save and exit the editor. The configuration will be automatically reloaded.

## Configuring Alertmanager for Custom Email Alerts
In each step copy the content to a file and apply it to the cluster using `kubectl apply -f`

1. Add your smtp password as a secret:

        apiVersion: v1
        kind: Secret
        metadata:
           name: alertmanager-smtp-password
           namespace: runai
        stringData:
           password: "your_smtp_password"

2. Apply the `alertmanagerconfig`, replace the relevant smtp details with your own (check for indentation problems before applying):

         apiVersion: monitoring.coreos.com/v1alpha1
         kind: AlertmanagerConfig
         metadata:
           name: runai
           namespace: runai
         labels:
            alertmanagerConfig: runai
         spec:
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
         
         receivers:
         - name: 'email'
           emailConfigs:
           - to: '<destination_email_address>'
             from: '<from_email_address>'
             smarthost: 'smtp.gmail.com:587'
             authUsername: '<smtp_server_user_name>'
             authPassword:
               name: alertmanager-smtp-password
               key: password

    !!! Note
        Different receivers can be configured using Alertmanager [receiver-integration-settings](https://prometheus.io/docs/alerting/latest/configuration/#receiver-integration-settings){target=_blank}.

3. Save and exit the editor. The configuration will be automatically reloaded.
