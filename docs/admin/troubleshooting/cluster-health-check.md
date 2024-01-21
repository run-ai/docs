---
title: Cluster Health and Troubleshooting
summary: This article describes the troubleshooting steps to take in order to diagnose and resolve issues you may find in your cluster.
authors:
    - Gal Revach
    - Jason Novich
date: 2024-Jan-17
---

This toubleshooting guide helps you diagnose and resolve issues you may find in your cluster.

## Cluster is Disconnected

When a cluster's status shows *Disconnected*, this means that no communication from the Run:ai cluster services reaches the Run:ai Control Plane.

This may reflect a networking issue from or to your Kubernetes cluster regardless of Run:ai components. In some cases, it may indicate an issue with one or more Run:ai services that communicate with the Control Plane. These are:

* Cluster sync (`cluster-sync`)
* Agent (`runai-agent`)
* Assets sync (`assets-sync`)

### Troubleshooting actions

Use the following steps to troubleshoot the issue:

1. Check that the Run:ai services that communicate with the Control Plane are up and running. Run the following command:

    `kubectl get pods -n runai | grep -E 'runai-agent|cluster-sync|assets-sync'`

2. Verify Run:ai services logs. Inspecting the logs of the Run:ai services that communicate with the CP is an essential first step to identify any error messages or connection issues.

    Run the following command on each one of the services:

    ```bash
    kubectl logs deployment/runai-agent -n runai
    kubectl logs deployment/cluster-sync -n runai
    kubectl logs deployment/assets-sync -n runai
    ```

3. Check the network connection from the `runai` namespace in your cluster to the Control Plane.

   You can do that by running a connectivity check pod. This pod can be a simple container with basic network troubleshooting tools, such as `curl` or `get`. Use the following command to create the pod and determine if it can establish connections to the necessary Control Plane endpoints:

    ```bash
    kubectl run control-plane-connectivity-check -n runai --image=wbitt/network-multitool --command -- /bin/sh -c 'curl -sSf <control-plane-endpoint> > /dev/null && echo "Connection Successful" || echo "Failed connecting to the Control Plane"'
    ```

    Replace `control-plane-endpoint` with the URL of the Control Plane in your environment.

4. Check potential network issues. Use the following guidelines:
  
    * Ensure that the network policies in your Kubernetes cluster allow communication between the Control Plane and the Run:ai services that communicate with the Control Plane.
    * Check both Kubernetes Network Policies and any network-related configurations at the infrastructure level.
    * Verify that the required ports and protocols are not blocked.

5. If the issue persists after completing the previous steps, contact Run:ai support for assistance.

!!! Note
    The previous steps can be used if you installed the cluster and the status is stuck in *Waiting to connect* for a long time.

## Cluster has Service issues

When a cluster's status shows *Service issues*, this means that one or more Run:ai services that are running in the cluster are not available.

1. Run the following command to verify which are the non-functioning services, and to get more details about deployment issues and resources required by these services that may not be ready (for example, ingress was not created or is unhealthy):

    ```bash
    kubectl get runaiconfig -n runai runai -ojson | jq -r '.status.conditions | map(select(.type == "Available"))'
    ```

    The list of non-functioning services is also available on the UI Clusters page.

2. After determining the non-functioning services, use the following guidelines to further investigate the issue.

    Run the following to get all the Kubernetes events and look for recent failures:

    ```bash
    Kubectl get events  -A
    ```

    If a required resource was created but not available or unhealthy, check the details by running:

    ```bash
    Kubectl describe <resource_type> <name>
    ```

3. If the issue persists, contact Run:ai support for assistance.

## General tests to verify the Run:ai cluster health

Use the following tests regularly to determine the health of the Run:ai cluster, regardless of the cluster status and the troubleshooting options previously described.

### Verify that data is sent to the cloud

Log in to `<company-name>.run.ai/dashboards/now`.

* Verify that all metrics in the overview dashboard are showing.
* Verify that all metrics are showing in the Nodes view.
* Go to **Projects** and create a new Project. Find the new Project using the CLI command: `runai list projects`

### Verify that the Run:ai services are running

Run:

```bash
kubectl get runaiconfig -n runai runai -ojson | jq -r '.status.conditions | map(select(.type == "Available"))'
```

Verify that all the Run:ai services are available and have all their required resources available.

Run:

```bash
kubectl get pods -n runai
kubectl get pods -n monitoring
```

Verify that all pods are in `Running` status and a ready state (1/1 or similar).

Run:

```bash
kubectl get deployments -n runai
```

Check that all deployments are in a ready state (1/1).

Run:

```bash
kubectl get daemonset -n runai
```

A *Daemonset* runs on every node. Some of the Run:ai daemon-sets run on all nodes. Others run only on nodes that contain GPUs. Verify that for all daemonsets the *desired* number is equal to *current* and to *ready*.

### Submit a Job via the command-line interface

Submitting a Job allows you to verify that the Run:ai scheduling service is running properly.

1. Make sure that the Project you have created has a quota of at least 1 GPU.
2. Run:

    ```bash
    runai config project <project-name>
    runai submit -i gcr.io/run-ai-demo/quickstart -g 1
    ```

3. Verify that the Job is in a *Running* state by running:

    ```bash
    runai list jobs
    ```

4. Verify that the Job is showing in the Jobs area at `<company-name>.run.ai/jobs`.

### Submit a Job via the user interface

Log into the Run:ai user interface, and verify that you have a `Researcher` or `Research Manager` role.
Go to the `Jobs` area. On the top right, press the button to create a Job. Once the form opens, you can submit a Job.
