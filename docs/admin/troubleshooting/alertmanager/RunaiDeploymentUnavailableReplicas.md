---
title: RunaiDeploymentUnavailableReplicas 
summary: This article describes the RunaiDeploymentUnavailableReplicas alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The Run:ai deployment has one or more unavailable pods.

## Impact

This indicates scaling issues. The new version deployment can not deploy due to missing features.

## Severity

Warning

## Diagnosis

Run `kubectl get deployment -n runai kubectl get deployment -n runai-backend` to see if one or more of the deployments is missing pods.

## Mitigation

Run `kubectl describe deployment X -n runai/runai-backend kubectl describe replicaset X -n runai/runai-backend kubectl logs deployment/X -n runai/runai-backend` to try and figure out why the deployment cannot create pods. Contact Run:ai if you cannot correct the issue.
