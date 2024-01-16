---
title: RunaiContainerRestarting 
summary: This article describes the RunaiContainerRestarting alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

Runai container has restarted more than twice in the last 10 min

## Impact

Container might be unavailable and affect runai system

## Severity

Warning

## Diagnosis

To diagnose the issue, and the pods with issues, run:
```
kubectl get pods -n runai
kubectl get pods -n runai-backend
```

One or more of the pods will have restart count >= 2

## Mitigation

Run `kubectl logs -n NAMESPACE POD_NAME` on the relevant pod. Check to see if there is something in the logs that stands out. Then, check that the container has enough resources.

Contact Run:ai for more assistance.
