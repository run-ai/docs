---
title: RunaiDaemonSetUnavailableOnNodes
summary: This article describes the RunaiDaemonSetUnavailableOnNodes alert.
authors:
    - Jason Novich
    - Viktor Koukouliev
date: 2024-Jan-10
---

## Meaning

Runai daemonset has 0 available pods on a relevant node

## Impact

No fractional gpu workloads support

## Severity

Critical

## Diagnosis

run

`kubectl get daemonset -n runai-backend`

One or more of the daemonsets will have no running pods on certain nodes

## Mitigation

Run

`kubectl describe daemonset X -n runai`

Try to figure out why the daemonset cannot create pods.

Contact runai.

Be the first to add a reaction
