# Alert Monitoring - Setting up Alertmanager in Prometheus Operator for Run.ai

## Table of Contents
1. Introduction
2. Prerequisites
3. Installing Prometheus Operator
4. Enabling Alertmanager
5. Configuring Prometheus to Send Alerts
6. Configuring Alertmanager for Custom Alerts

---

## 1. Introduction
This documentation outlines the steps required to set up Alertmanager within the Prometheus Operator ecosystem. It also provides guidance on configuring Prometheus to send alerts to Alertmanager and customizing Alertmanager to trigger alerts based on specific **Run.ai** conditions.

## 2. Prerequisites
- A Kubernetes cluster with the necessary permissions and manage resources.
- `kubectl` command-line tool installed and configured to interact with the cluster.
- Basic knowledge of Kubernetes resources and manifests.
- up and running Prometheus Operator
- Up and running Run.ai environment

## 3. Validate Prometheus Operator Installed
1. **Check the Operator Deployment**:

   Verify that the Prometheus Operator deployment is running:

   ```shell
   kubectl get deployment prometheus-operator -n runai
   ```

   You should see output indicating the deployment's status, including the number of replicas and their current state.

2. **Confirm Prometheus Instances**:

   Check if Prometheus instances are running:

   ```shell
   kubectl get prometheus -n runai
   ```

   You should see the Prometheus instance(s) listed along with their status.

## 4. Enabling Alertmanager
1. Create an AlertmanagerConfig that triggers on Run.ai events by applying the following yaml:
      ```shell
      cat <<EOF | kubectl apply -f - 
      apiVersion: monitoring.coreos.com/v1alpha1
      kind: AlertmanagerConfig
      metadata:
         name: runai
         namespace: runai
         labels:
            alertmanagerConfig: runai
      
      EOF
      ```
!!! Note
     Different receivers can be configured using Alertmanager [here](https://prometheus.io/docs/alerting/latest/configuration/#receiver-integration-settings).

2. Create the Alertmanager CustomResource to enable Alertmanager:
      ```shell
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
      ```

3. Exposing the Alertmanager Service
   ```shell
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
   ```

## 5. Configuring Prometheus to Send Alerts
1. Open the Prometheus configuration for editing:
   ```shell
   kubectl edit prometheus runai -n runai
   ```

2. Add the following `alerting` section to the configuration:
   ```yaml
   alerting:
     alertmanagers:
       - namespace: runai
         name: alertmanager-runai
         port: web
   ```

3. Save and exit the editor. The configuration will be automatically reloaded.

## 6. Configuring Alertmanager for Custom Email Alerts
1. Add your smtp password as a secret:
   ```shell
   cat <<EOF | kubectl apply -f - 
   apiVersion: v1
   kind: Secret
   metadata:
      name: smtp-password
      namespace: runai
   stringData:
      password: "your_smtp_password"
   EOF
   ```

2. Open the Alertmanager configuration for editing by running:
   ```shell
   kubectl edit alertmanagerconfig -n runai
   ```
   Then under the `spec` section configure the following steps.

3. Add a new receiver configuration to send alerts via email:
   ```yaml
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
   ```

4. Add a new route to forward Run.ai alerts to the mail receiver:
   ```yaml
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
   ```

5. Save and exit the editor. The configuration will be automatically reloaded.
---