---
title: RunaiDeploymentNoAvailableReplicas
summary: This article describes the RunaiDeploymentNoAvailableReplicas alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

A Run:ai deployment has zero available pods.

## Impact

Run:ai may not be able to function, depending on the unavailable deployment.

## Severity

Critical

## Diagnosis

Run 
`kubectl get deployment -n runai`
`kubectl get deployment -n runai-backend` 

Identify one or more deployments that have no running pods.

## Mitigation

Run 
`kubectl describe deployment X -n runai/runai-backend`
`kubectl describe replicaset X -n runai/runai-backend`
`kubectl logs deployment/X -n runai/runai-backend` 

From the logs and deployment details, try and figure out why the deployment cannot create pods. 
If you cannot correct the issue, contact Run:ai support.
