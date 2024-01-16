---
title: RunaiContainerRestarting 
summary: This article describes the RunaiContainerRestarting alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

A Run:ai container has restarted more than twice in the last 10 minutes.

## Impact

The container may be unavailable and affect Run:ai system feature functionalities.

## Severity

Warning

## Diagnosis

To diagnose the issue, and the pods with issues, run:
```
kubectl get pods -n runai
kubectl get pods -n runai-backend
```

The expected result should be one or more pods where the restart count >= 2.

## Mitigation

Run `kubectl logs -n NAMESPACE POD_NAME` on the relevant pod. Check to see if there is something in the logs that stands out. Then, check that the container has enough resources.

Contact Run:ai for more assistance.
