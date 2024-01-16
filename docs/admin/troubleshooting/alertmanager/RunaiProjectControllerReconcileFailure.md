---
title: RunaiProjectControllerReconcileFailure
summary: This article describes the RunaiProjectControllerReconcileFailure alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The `project-controller` deployment in the ‘runai’ namespace had errors while reconciling projects.

## Impact

Some of the projects may not be in a *Ready* state.

## Severity

Critical

## Diagnosis

Run `kubectl logs deployment/project-controller -n runai` to try and find errors in the logs.

## Mitigation

The error in the logs should be descriptive and help to understand what is wrong.

If you see which of the projects failed to reconcile, you can check their status by running `kubectl get project <PROJECT_NAME> -oyaml`. The status describes what the issue may be. 
If you cannot correct the issue, contact Run:ai support.
