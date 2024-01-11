---
title: RunaiContainerRestarting 
summary: This article describes the RunaiContainerRestarting alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

Runai container has restarted more than twice in the last 10 min

## Impact

Container might be unavailable and affect runai system

## Severity

Warning

## Diagnosis

Use

`kubectl get pods -n runai kubectl get pods -n runai-backend`

One or more of the pods will have restart count >= 2

## Mitigation

Run

`kubectl logs -n NAMESPACE POD_NAME`

On the relevant pod.  
See if something in the logs stands out.  
Check that the container has enough resources.  
Contact runai.

Be the first to add a reaction
