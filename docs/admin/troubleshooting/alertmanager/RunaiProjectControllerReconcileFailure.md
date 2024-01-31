---
title: RunaiProjectControllerReconcileFailure
summary: This article describes the RunaiProjectControllerReconcileFailure alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The project-controller (in ‘runai’ namespace) had errors while reconciling projects.

## Impact

Some projects might not be “Ready”.

## Severity

Critical

## Diagnosis

Run:

`kubectl logs deployment/project-controller -n runai`

And try to find errors in the logs.

## Mitigation

The error in the logs should be descriptive and help to understand what is wrong.

If you see which of the projects failed to reconcile, you can check their status by running `kubectl get project <PROJECT_NAME> -oyaml`. The status describes what the issue may be. 

If you cannot correct the issue, contact Run:ai support.
