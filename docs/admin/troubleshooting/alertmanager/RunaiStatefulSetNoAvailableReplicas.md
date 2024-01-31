---
title: RunaiStatefulSetNoAvailableReplicas
summary: This article describes the RunaiStatefulSetNoAvailableReplicas alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

Runai statefulset has no available pods

## Impact

No metrics

No database

## Severity

Critical

## Diagnosis

run

`kubectl get statefulset -n runai-backend`

One or more of the stateful sets will have no running pods

## Mitigation

Run

`kubectl describe statefulset X -n runai-backend`

Try to figure out why the statefulset cannot create pods.

Contact runai.

Be the first to add a reaction
