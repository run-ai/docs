---
title: RunaiDeploymentInsufficientReplicas 
summary: This article describes the RunaiDeploymentInsufficientReplicas alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

Runai deployment has 1 or more unavailable pods.

## Impact

Scale issues.  
New version deployment cannot deploy - missing features.

## Severity

Critical

## Diagnosis

run

`kubectl get deployment -n runai kubectl get deployment -n runai-backend`

One or more of the deployment will missing pods

## Mitigation

Run

`kubectl describe deployment X -n runai/runai-backend kubectl describe replicaset X -n runai/runai-backend kubectl logs deployment/X -n runai/runai-backend`

Try to figure out why the deployment cannot create pods.

Contact runai.

Be the first to add a reaction
