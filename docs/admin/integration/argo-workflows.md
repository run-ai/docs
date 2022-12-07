# Integrate Run:ai with Argo Workflows

[Argo Workflows](https://argoproj.github.io/workflows/#:~:text=Argo%20Workflows%20is%20an%20open,the%20workflow%20is%20a%20container.){target=_blank} is an open source container-native workflow engine for orchestrating parallel jobs on Kubernetes.

This document describes the process of using Argo Workflows in conjunction with Run:ai. Argo Workflows submits jobs that are scheduled via Run:ai.


## Install Argo Workflows

Use the [default installation](https://argoproj.github.io/argo-workflows/quick-start/){target=_blank} to install Argo Workflows. As described in the documentation, open the Argo Workflows UI by running: 

```
kubectl -n argo port-forward deployment/argo-workflows-server 2746:2746
```

Then browse to [localhost:2746](http://localhost:2746/){target=_blank}


## Create a Run:ai Project

Using the Run:ai user interface, create a Run:ai Project. A Project named `team-a` will create a Kubernetes namespace named `runai-team-a`.

## Run an Argo Workflow with Run:ai

### Create an Argo Workflows Template

Within the Argo Workflows user interface, go to `Templates` and create a new Template. Add the following metadata:

``` YAML
spec:
  templates:
    - name: <WORKFLOW-NAME>
      metadata:
        labels:
          project: team-a # (1)
```

1. Name of Project.


### Create and Run the Workflow

Create an Argo Workflow from the template and run it. Open the Run:ai user interface, go to `Jobs`, and verify that you can see the new Job. 



## Using GPU Fractions with Argo Workflows

To run an Argo Workflow using [GPU Fractions](../../Researcher/scheduling/fractions.md), you will need to add an `annotation`:

``` YAML
spec:
  templates:
    - name: <WORKFLOW-NAME>
      metadata:
        annotations:
          gpu-fraction: '0.5' # (1)
        labels:
          project: team-a # (2)
```

1. Size of required GPU Fraction.
2. Name of Project.
