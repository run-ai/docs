---
title: RunaiDaemonSetRolloutStuck
summary: This article describes the RunaiDaemonSetRolloutStuck alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

The Run:ai daemonset has zero available pods on a relevant node.

## Impact

Fractional gpu workloads support is not configured.

## Severity

Critical

## Diagnosis

Run

`kubectl get daemonset -n runai-backend`

One or more of the daemonsets will have no running pods on certain nodes

## Mitigation

Run `kubectl describe daemonset X -n runai` to try and figure out why the daemonset cannot create pods. Contact Run:ai if you cannot correct the issue.
