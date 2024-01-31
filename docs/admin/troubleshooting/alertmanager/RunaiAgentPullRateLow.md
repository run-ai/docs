---
title: RunaiAgentPullRateLow
summary: This article describes the RunaiAgentPullRateLow alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The `runai-agent` pod may be too loaded, is slow in processing data (possible in very big clusters), or the ‘runai-agent‘ pod itself in the ‘runai’ namespace may not be functioning properly.

## Impact

Possible impact - no info/partial info from the control-plane is being synced in the cluster.

## Severity

Critical

## Diagnosis

Run:

`kubectl get pod -n runai`

And see if the `runai-agent` pod is running.

## Mitigation

Run: 
```
kubectl describe deployment runai-agent -n runai
kubectl logs deployment/runai-agent -n runai
```

From the logs and pod details, try and figure out why the `runai-agent` pod is not functioning properly.

Perhaps there’s a connectivity issue with the control-plane?

If it seems that the agent is functioning properly, but the cluster is very big and loaded, it makes sense that the agent takes time to process the data coming from the control-plane.

In that case, if we want the alert to stop firing, we can try to edit the value under which the alert starts firing.

The default is 0.05, you can try to change it to less than that (for example, 0.045 or 0.04).

`kubectl edit runaiconfig -n runai`

under: `spec` -> `prometheus` -> `agentPullPushRateMinForAlert` (if the value doesn’t exist, add it)

Be the first to add a reaction
