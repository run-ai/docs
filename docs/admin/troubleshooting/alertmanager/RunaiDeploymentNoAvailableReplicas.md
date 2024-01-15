---
title: RunaiDeploymentNoAvailableReplicas
summary: This article describes the RunaiDeploymentNoAvailableReplicas alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The Run:ai deployment has zero available pods.

## Impact

Run:ai cannot function depending on the deployment.

## Severity

Critical

## Diagnosis

Run `kubectl get deployment -n runai kubectl get deployment -n runai-backend` to see if one or more of the deployments has no running pods.

## Mitigation

Run `kubectl describe deployment X -n runai/runai-backend kubectl describe replicaset X -n runai/runai-backend kubectl logs deployment/X -n runai/runai-backend` to try and figure out why the deployment cannot create pods. Contact Run:ai if you cannot correct the issue.
