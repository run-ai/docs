---
title: RunaiStatefulSetInsufficientReplicas
summary: This article describes the RunaiStatefulSetInsufficientReplicas alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

A Run:ai `statefulset` has no available pods.

## Impact

There are no metrics avaliable.

There is no database.

## Severity

Critical

## Diagnosis

Run `kubectl get statefulset -n runai-backend` to identify the one or more stateful sets with no running pods.

## Mitigation

Run `kubectl describe statefulset X -n runai-backend` 

From the stateful set details, try to figure out why the it cannot create pods. 

If you cannot correct the issue, contact Run:ai support.
