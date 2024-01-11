---
title: RunaiContainerMemoryUsageCritical
summary: This article describes the RunaiContainerMemoryUsageCritical alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

Runai container is using more than 90% of its Memory limit

## Impact

Container might go OOM and crash

## Severity

Critical

## Diagnosis

Use

on the relevant pod.  
If this tool is unavailable, you can calculate the memory usage via:

`container_memory_usage_bytes{namespace=~"runai|runai-backend"}`

## Mitigation

Add memory resources to the container.  
If the issue does not resolve, contact runai.

Be the first to add a reaction
