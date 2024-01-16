---
title: RunaiDeploymentInsufficientReplicas 
summary: This article describes the RunaiDeploymentInsufficientReplicas alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

A Run:ai deployment has one or more unavailable pods.

## Impact

This alert may indicate scaling issues.
If a new version of the deployment can not be deployed, this may cause new features to be missing.

## Severity

Critical

## Diagnosis

Run 
`kubectl get deployment -n runai`
`kubectl get deployment -n runai-backend` 

Identify one or more deployments that have missing pods.

## Mitigation

Run 
`kubectl describe deployment X -n runai/runai-backend`
`kubectl describe replicaset X -n runai/runai-backend`
`kubectl logs deployment/X -n runai/runai-backend` 

From the logs and deployment details, try and figure out why the deployment cannot create pods. 
If you cannot correct the issue, contact Run:ai support.
