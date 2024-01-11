---
title: RunaiAgentClusterInfoPushRateLow 
summary: This article describes the RunaiAgentClusterInfoPushRateLow alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

cluster-sync pod in ‘runai’ namespace might not be functioning properly.

## Impact

Possible impact - no info/partial info from the cluster is being synced back to the control-plane.

## Severity

Critical

## Diagnosis

Run:

`kubectl get pod -n runai`

And see if the `cluster-sync` pod is running.

## Mitigation

Run

`kubectl describe deployment cluster-sync -n runai kubectl logs deployment/cluster-sync -n runai`

Try to figure out why the cluster-sync is not functioning properly.

Perhaps there’s a connectivity issue with the control-plane?

Be the first to add a reaction
