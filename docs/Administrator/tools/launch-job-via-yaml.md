# Launch a Run:AI Job via YAML

The easiest way to submit jobs to the Run:AI GPU cluster is via the Run:AI Command-line interface (CLI). Still, the CLI is not a must. It is only a wrapper for a more detailed Kubernetes API syntax using YAML. 

There are cases were you want to forgo the CLI and use direct YAML calls. A frequent scenario for using the Kubernetes YAML syntax to submit jobs is __integrations__. Researchers may already be working with an existing system that submits jobs, and want to continue working with the same system. Though it is possible to call the Run:AI CLI from the customer's integration, it is sometimes not enough.

## Terminology

We differentiate between two types of Workloads:

*   __Train__ workloads. Training is characterized by a deep learning session that has a start and an end. A Training session can take anywhere from a few minutes to a couple of weeks. It can be interrupted in the middle and later restored. Training workloads typically utilize large percentages of GPU computing power and memory.
*   __Build__ workloads. Build workloads are interactive. They are used by data scientists to write machine learning code and test it against subsets of the data. Build workloads typically do not maximize usage of the GPU. 

The internal Kubernetes implementation of Train and Build are Kubernetes [Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/) and Kubernetes [StatesfulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) respectively:

* A Kubernetes _Job_ is used for _Train_ workloads. A Job has a distinctive "end" at which time the job is either "Completed" or "Failed"
* A Kubernetes _StatefulSet_ is used for  _Build_ workloads. Build workloads are interactive sessions. StatefulSets do not end on their own. Instead they must be manually stopped

Run:AI extends the Kubernetes _Scheduler_. A Kubernetes Scheduler is the software that determines which Workload to start on which node. Run:AI provides a custom scheduler named ``runai-scheduler``

The Run:AI scheduler schedules computing resources by associating Workloads with  Run:AI _Projects_:

* A project is assigned with a GPU quota through the Run:AI Administrator user interface. 
* Each workload must be associated with a project name and will receive resources according to the defined quota for the project and the currently running Workloads

Internally, Run:AI Projects are implemented as Kubernetes namespaces. The scripts below assume that the code is being run after the relevant namespace has been set. 

## Submit Workloads 


### Train jobs

A Train job is equivalent to __not__ using the CLI ``--interactive`` flag when calling [runai submit](../../Researcher/cli-reference/runai-submit.md). Assuming you have the following parameters:

* ``<JOB-NAME>``. The name of the Job. 

* ``<IMAGE-NAME>``. The name of the docker image to use. Example: ``gcr.io/run-ai-demo/quickstart``

* ``<PROJECT-NAME>``. The name of the Project as created on the Administrator UI. Run: ``runai project list`` to see the list of currently available projects. 

* ``<USER-NAME>`` User name running the Job. The name is used for display purposes only (not for authentication purposes).

* ``<REQUESTED-GPUs>``. An integer number of GPUs you request to be allocated for the Job. Examples: 1, 2

Copy the following into a file and change the parameters:

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: <JOB-NAME>
spec:
  template:
    metadata:
      labels:
        user: <USER-NAME>
    spec:
      containers:
      - name: <JOB-NAME>
        image: <IMAGE-NAME>
        resources:
          limits:
            nvidia.com/gpu: <REQUESTED-GPUs>
      restartPolicy: Never
      schedulerName: runai-scheduler
```


Run:

    kubectl apply -f <FILE-NAME>

to submit the job.

!!! Note
    The [runai submit](../../Researcher/cli-reference/runai-submit.md) CLI command includes many more flags. These flags can be correlated to Kubernetes API functions and added to the YAML above. 


### Build jobs

A Build job is equivalent to using the CLI ``--interactive`` flag when calling [runai submit](../../Researcher/cli-reference/runai-submit.md). Copy the following into a file and change the parameters:

``` yaml
apiVersion: apps/v1
kind: "StatefulSet"
metadata:
  name:  <JOB-NAME>
spec:
  serviceName:  <JOB-NAME>
  replicas: 1
  selector:
    matchLabels:
      release:  <JOB-NAME>
  template:
    metadata:
      labels:
        user:  <USER-NAME>
        release:  <JOB-NAME>
    spec:
      schedulerName: runai-scheduler
      containers:
        - name:  <JOB-NAME>
          command:
          - "sleep"
          args:
          - "infinity"
          image: <IMAGE-NAME>
          resources:
            limits:
              nvidia.com/gpu: <REQUESTED-GPUs>
```

The YAML above contains a default command and arguments (``sleep --inifinty``) which you can replace.

Run:

    kubectl apply -f <FILE-NAME>

to submit the job.


### Using Fractional GPUs

Jobs with Fractions requires a change in the above YAML. Specifically the limits section:

``` yaml
limits:
  nvidia.com/gpu: <REQUESTED-GPUs>
```

should be omitted and replaced with:

``` yaml
spec:
  template:
    metadata:
      annotations:
        gpu-fraction: "0.5"
```

where "0.5" is the requested GPU fraction.

## Delete Workloads

To delete a Run:AI workload you need to delete the Job or StatefulSet according to the workload type

    kubectl delete job <JOB-NAME>

or: 

    kubectl delete sts <STS-NAME>