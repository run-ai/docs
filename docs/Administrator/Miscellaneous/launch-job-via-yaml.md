# Launch a Run:AI Job via YAML

The easiest way to submit jobs to Run:AI GPU cluster is via the Run:AI Command-line interface (CLI). However, the CLI is not a must. The Run:AI CLI is only a wrapper for a more detailed Kubernetes API syntax using _YAML_. There are cases were you want to forgo the CLI and use direct YAML. 

A frequent scenario for using the Kubernetes YAML syntax to submit jobs is __integrations__. Researchers may already be working with an existing system which submits jobs and want to continue working with the same system. Though it is possible to call the Run:AI CLI from a customer integration, it is sometimes not enough.

## Terminology

We differentiate between two types of Workloads:

*   __Train__ workloads. Training is characterized by a deep learning session that has a start and an end. A Training session can take anywhere from a few minutes to a couple of weeks. It can be interrupted in the middle and later restored. Training workloads typically utilize large percentages of GPU computing power and memory.
*   __Build__ workloads. Build workloads are interactive. They are used by data scientists to write machine learning code and test it against subsets of the data. Build workloads typically do not maximize usage of the GPU. Coding is done by connecting a Jupyter notebook or PyCharm via TCP ports

The internal Kubernetes implementation of Train and Build are Kubernetes [Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/) and Kubernetes [StatesfulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) respectively:

* Kubernetes _Job_ is used for _Train_ workloads. A Job has a distinctive "end" at which time the job is either "Completed" or "Failed"
* Kubernetes _StatefulSet_ is used for  _Build_ workloads. Build workloads are interactive sessions. StatefulSets do not end on their own. Instead they must be manually stopped

Run:AI extends the Kubernetes _Scheduler_. A Kubernetes Scheduler is the software that determines which Workload to start on which node. Run:AI provides a custom scheduler named ``runai-scheduler``

The Run:AI scheduler schedules computing resources by associating Workloads with  Run:AI _Projects_ :

* Each project contains a GPU quota.
* Each workload must be annotated with a project name and will receive resources according to the defined quota for the project and the currently running Workloads

## Using YAML to Launch Workloads 


### Train jobs

Train job is equivalent to __not__ using the ``--interactive`` flag when calling ``runai submit``. Assuming you have the following parameters:

* ``<JOB-NAME>``. The name of the Job. 

* ``<IMAGE-NAME>``. The name of the docker image to use. Example: ``gcr.io/run-ai-demo/quickstart``

* ``<PROJECT-NAME>``. The name of the Project as created on the Administrator UI. Run: ``runai project list`` to see the list of currently available projects. 

* ``<USER-NAME>`` User name running the Job. The name is used for display purposes only (not for authentication purposes).

* ``<REQUESTED-GPUs>``. An integer number of GPUs you request to be allocated for the Job. Examples: 1, 2

Copy the following into a file and change the parameters:

    apiVersion: batch/v1
    kind: Job
    metadata:
      name: <JOB-NAME>
    spec:
      template:
        metadata:
          annotations:
            scheduling.k8s.io/group-name: group-<JOB-NAME>
        spec:
          containers:
          - name: gpu-test
            image: <IMAGE-NAME>
            resources:
              limits:
                nvidia.com/gpu: <REQUESTED-GPUs>
          restartPolicy: Never
          schedulerName: runai-scheduler
    ---
    apiVersion: scheduling.incubator.k8s.io/v1alpha1
    kind: PodGroup
    metadata:
      name: group-<JOB-NAME>
    labels: 
      user: <USER-NAME>
    spec:
      queue: <PROJECT-NAME>

Run: ``kubectl apply -f <FILE-NAME>`` to submit the job.

!!! Note
The [runai submit](../../Researcher/Command-Line-Interface-API-Reference/runai-submit.md) CLI command includes many more flags. These flags can be correlated to Kubernetes API functions and added to the YAML above. 


### Build jobs
...