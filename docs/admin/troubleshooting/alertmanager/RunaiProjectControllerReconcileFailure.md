---
title: RunaiProjectControllerReconcileFailure
summary: This article describes the RunaiProjectControllerReconcileFailure alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The project-controller (in the ‘runai’ namespace) had errors while reconciling projects.

## Impact

Some of the projects may not be *Ready*.

## Severity

Critical

## Diagnosis

Run `kubectl logs deployment/project-controller -n runai` to try and find errors in the logs.

## Mitigation

The error in the logs should be descriptive and help to understand what is wrong.

If you see which of the projects failed to reconcile, you can check their status by running `kubectl get project <PROJECT_NAME> -oyaml`.
The status will be descriptive as to what the issue may be. Contact Run:ai if you cannot correct the issue.
