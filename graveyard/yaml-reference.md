---
title: YAML Reference
summary: This article contains the YAML reference for submitting workloads.
authors:
    - Jason Novich
    - Jamie Weider
date: 2024-Jun-10
---

The fields listed in the table are all the fields below the spec (spec.field).

Click the link to view full details of each field.

## Fields Table

| Fields | Description | Supported Run:ai workload types|
| -- | -- | -- |
|<a href="#allowPrivilegeEscalation"> `allowPrivilegeEscalation` | Allows the container running the workload and all launched processes to gain additional privileges after the workload starts. | *Workspace*, *Training*, *Distributed*, *Inference*, *Job* (legacy) |
| <a href="#args">`args` | Arguments to the command that the container running the workspace executes. | *Workspace*, *Training*, *Distributed*, *Inference*, *Job* (legacy) |

## Field descriptions

<a name="allowPrivilegeEscalation"></a>

| Field | Description | Value Type| Mandatory | Default |
| -- | -- | -- | -- | -- |
| `allowPrivilegeEscalation` | Allows the container running the workload and all launched processes to gain additional privileges after the workload starts. | Boolean | No | `true` |

Supported Run:ai types:

- [x] Workspace
- [x] Training
- [x] Distributed
- [x] Inference
- [x] Job (legacy)

**Example**:

```yml
apiVersion: run.ai/v2alpha1
kind: InteractiveWorkload
metadata:
  name: <name>
  namespace: <namespace>
spec:
  image:
    value: ubuntu:latest
  allowPrivilegeEscalation:
    value: true
  name:
    value: <workload-name>
  nodePools:
    value: default
  usage: Submit
```

Return to the [fields table](#fields-table).

<a name="args"></a>

| Field | Description | Value Type| Mandatory | Default |
| -- | -- | -- | -- | -- |
| `args` | When set, contains the arguments sent along with the command. These override the entry point of the image in the created workload. | String | No | N/A |

Supported Run:ai types:

- [x] Workspace
- [x] Training
- [x] Distributed
- [x] Inference
- [x] Job (legacy)

**Example**:

```yml
apiVersion: run.ai/v2alpha1
kind: InteractiveWorkload
metadata:
  name: <name>
  namespace: <namespace>
spec:
  image:
    value: jupyter/scipy-notebook
  command:
    value: start-notebook.sh
  arguments:
    value: --NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''
  name:
    value: <workload-name>
  nodePools:
    value: default
  usage: Submit
```
Return to the [fields table](#fields-table).