---
title: RunaiStatefulSetNoAvailableReplicas
summary: This article describes the RunaiStatefulSetNoAvailableReplicas alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The Run:ai `statefulset` has no available pods.

## Impact

There are no metrics.

There is no database.

## Severity

Critical

## Diagnosis

Run `kubectl get statefulset -n runai-backend` to see if one or more of the stateful sets has no running pods.

## Mitigation

Run `kubectl describe statefulset X -n runai-backend` to try and figure out why the `statefulset` cannot create pods. Contact Run:ai if you cannot correct the issue.
