---
title: RunaiAgentPullRateLow
summary: This article describes the RunaiAgentPullRateLow alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The `runai-agent` pod may be too loaded, is slow in processing data (possible in very big clusters), or the `runai-agent` pod itself in the `runai` namespace may not be functioning properly.

## Impact

No information or partial information from the Run:ai Control Plane is being synced to the cluster.

## Severity

Critical

## Diagnosis

Run `kubectl get pod -n runai` to see if the `runai-agent` pod is running.

## Mitigation

Run: 
```
kubectl describe deployment runai-agent -n runai
kubectl logs deployment/runai-agent -n runai
```

From the logs and pod details, try and figure out why the `runai-agent` pod is not functioning properly.

It is possible that there is a connectivity issue from the cluster to the Run:ai Control Plane.

If it seems that the `runai-agent` pod is functioning properly, but the cluster is very big and loaded, it is possible that the agent is taking time to process the data coming from the Run:ai Control Plane. If this is the case, and you want the alert to stop firing, you can try to edit the value under which the alert starts firing.

Run `kubectl edit runaiconfig -n runai`.

In the  `spec`:`prometheus` verify that the  `agentPullPushRateMinForAlert` (if the property does not exist, add it).
If the property exists, the default value is 0.05. You can change it to less than that (for example, 0.045 or 0.04).

If the above instructions did not correct the issue, contact Run:ai support. 
