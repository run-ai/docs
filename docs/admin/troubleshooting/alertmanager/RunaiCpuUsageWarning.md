---
title: RunaiCpuUsageWarning
summary: This article describes the RunaiCpuUsageWarning alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

Runai container is using more than 80% of its CPU limit

## Impact

Might cause slowness in the operation of certain runai features

## Severity

Warning

## Diagnosis

Use

on the relevant pod.  
If this tool is unavailable, you can calculate the cpu usage via:

`rate(container_cpu_usage_seconds_total{namespace=~"runai|runai-backend"}[2m])`

## Mitigation

Add cpu resources to the container.  
If the issue does not resolve, contact runai.

Be the first to add a reaction
