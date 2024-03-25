---
title: RunaiDaemonSetRolloutStuck
summary: This article describes the RunaiDaemonSetRolloutStuck alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

Runai daemonset has 0 available pods on a relevant node.

## Impact

No fractional gpu workloads support.

## Severity

Critical

## Diagnosis

run

`kubectl get daemonset -n runai-backend`

Identify the one or more daemonsets that have no running pods on some of the nodes.

## Mitigation

Run `kubectl describe daemonset X -n runai` on the relevant deamonset(s) to try and figure out why it cannot create pods.

If you cannot correct the issue, contact Run:ai support.
