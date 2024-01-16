---
title: RunaiAgentClusterInfoPushRateLow 
summary: This article describes the RunaiAgentClusterInfoPushRateLow alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The ‘cluster-sync‘ pod in the ‘runai’ namespace might not be functioning properly.

## Impact

No information or partial information from the cluster is being synced back to the Run:ai Control Plane.

## Severity

Critical

## Diagnosis

Run `kubectl get pod -n runai` to see if the `cluster-sync` pod is running.

## Mitigation

Run 
`kubectl describe deployment cluster-sync -n runai` 
`kubectl logs deployment/cluster-sync -n runai` 

From the logs and pod details, try and figure out why the `cluster-sync` pod is not functioning properly.

It is possible that there is a connectivity issue from the cluster to the Run:ai Control Plane.

If the network is from the cluster to the Control Plane works as expected, and you cannot correct the issue, contact Run:ai support. 
