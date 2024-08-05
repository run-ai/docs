---
title: RunaiCpuUsageWarning
summary: This article describes the RunaiCpuUsageWarning alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

A Run:ai container is using more than 80% of its CPU limit.

## Impact

This may cause slowness in the operation of certain Run:ai features.

## Severity

Warning

## Diagnosis

Use the command `kubectl top` on the relevant pod. 

If this tool is unavailable, you can calculate the CPU usage by running `rate(container_cpu_usage_seconds_total{namespace=~"runai|runai-backend"}[2m])`.

## Mitigation

Add CPU resources to the container. 
If the issue is not resolved, contact Run:ai support.
