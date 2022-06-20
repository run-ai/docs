# Integrate Run:ai with Argo Workflows

[Argo Workflows](https://argoproj.github.io/workflows/#:~:text=Argo%20Workflows%20is%20an%20open,the%20workflow%20is%20a%20container.){target=_blank} is an open source container-native workflow engine for orchestrating parallel jobs on Kubernetes.

This document describes the process of using Argo Workflows in conjunction with Run:ai. Argo Workflows submits jobs that are scheduled via Run:ai.


## Install Argo Workflows

Use the [default installation](https://argoproj.github.io/argo-workflows/quick-start/){default=_blank} to install Argo Workflows. As described in the documentation, open the Argo Workflows UI by running: 

```
kubectl -n argo port-forward deployment/argo-server 2746:2746
```


## Create a Run:ai Project

Use the Run:ai user interface to create a Run:ai Project. A Project named `team-a` will create a Kubernetes namespace named `runai-team-a`

## Create an Argo Workflows Template

Within the Argo Workflows user interface, go to `Templates` and create a new Template. Add the following metadata:

``` YAML
spec:
  templates:
    - name: <WORKFLOW-NAME>
      metadata:
        labels:
          project: team-a # (1)
          runai: 'true' # (2)
```

(1) Name of Project.
(2) The Workflow is


## Using GPU Fractions with Argo Workflows