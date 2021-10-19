# Submit a Run:AI Job via YAML

The easiest way to submit Jobs to the Run:AI GPU cluster is via the Run:AI Command-line interface (CLI). Still, the CLI is not a must. It is only a wrapper for a more detailed Kubernetes API syntax using YAML. 

There are cases where you want to forgo the CLI and use direct YAML calls. A frequent scenario for using the Kubernetes YAML syntax to submit Jobs is __integrations__. Researchers may already be working with an existing system that submits Jobs, and want to continue working with the same system. Though it is possible to call the Run:AI CLI from the customer's integration, it is sometimes not enough.

## Terminology

We differentiate between three types of Workloads:

*   __Train__ workloads. _Train_ workloads are characterized by a deep learning session that has a start and an end. A Training session can take anywhere from a few minutes to a couple of weeks. It can be interrupted in the middle and later restored. Training workloads typically utilize large percentages of GPU computing power and memory.
*   __Build__ workloads. Build workloads are interactive. They are used by data scientists to write machine learning code and test it against subsets of the data. Build workloads typically do not maximize usage of the GPU. 
* __Inference__ workloads. Inference workloads are used for serving models in production. For details on how to submit Inference workloads via YAML see [here](../../developer/inference/submit-via-yaml.md).

The internal Kubernetes implementation of Train is a _CRD_ (Customer Resource) named `RunaiJob` which is similar to a Kubernetes [Job](https://kubernetes.io/docs/concepts/workloads/controllers/Job/){target=_blank}. The internal implementation of Buils is a  Kubernetes [StatesfulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){target=_blank}.

* A Kubernetes _Job_ is used for _Train_ workloads. A Job has a distinctive "end" at which time the Job is either "Completed" or "Failed"
* A Kubernetes _StatefulSet_ is used for  _Build_ workloads. Build workloads are interactive sessions. StatefulSets do not end on their own. Instead, they must be manually stopped

Run:AI extends the Kubernetes _Scheduler_. A Kubernetes Scheduler is the software that determines which workload to start on which node. Run:AI provides a custom scheduler named `runai-scheduler`.

The Run:AI scheduler schedules computing resources by associating Workloads with  Run:AI _Projects_:

* A Project is assigned with a GPU quota through the Run:AI Administrator user interface. 
* A workload must be associated with a Project name and will receive resources according to the defined quota for the Project and the currently running Workloads

Internally, Run:AI Projects are implemented as Kubernetes namespaces. The scripts below assume that the code is being run after the relevant namespace has been set. 

## Submit Workloads 

* `<JOB-NAME>`. The name of the Job. 
* `<IMAGE-NAME>`. The name of the docker image to use. Example: `gcr.io/run-ai-demo/quickstart`
* `<USER-NAME>` The name of the user submitting the Job. The name is used for display purposes only when Run:AI is installed in an [unauthenticated mode](../../admin/runai-setup/advanced/researcher-authentication.md).
* `<REQUESTED-GPUs>`. An integer number of GPUs you request to be allocated for the Job. Examples: 1, 2
* `<NAMESAPCE>` The name of the Project's namespace. This is usually `runai-<PROJECT-NAME>`


### Regular Jobs

Copy the following into a file and change the parameters:

```yaml
apiVersion: run.ai/v1
kind: RunaiJob (* see note below)
metadata:
  name: <JOB-NAME>
  namespace: <NAMESPACE>
  labels:
    priorityClassName: "build" (* see note below)
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


To submit the job, run:

```
kubectl apply -f <FILE-NAME>
```

!!! Note
    * You can use either a regular `Job` or `RunaiJob`. The latter is a Run:AI object which solves various Kubernetes Bugs and provides a better naming for multiple pods in Hyper-Parameter Optimization scenarios
    * Using `build` in the `priorityClassName` field is equivalent to running a job via the CLI with a '--interactive' flag. To run a Train job, delete this line.
    * The [runai submit](../../Researcher/cli-reference/runai-submit.md) CLI command includes many more flags. These flags can be correlated with Kubernetes API functions and added to the YAML above. 



### Using Fractional GPUs

To submit a Job with fractions of a GPU, replace `<REQUESTED-GPUs>` with a fraction in quotes. e.g. 

``` yaml
limits:
  nvidia.com/gpu: "0.5"
```

where "0.5" is the requested GPU fraction.


### Mapping Additional Flags

Run:AI Command-Line `runai submit` has a significant number of flags. The easiest way to find out the mapping from a flag to the correct YAML attribute is to use the `--dry-run` flag.

For example, to find the location of the `--large-shm` flag, run:

``` bash 
> runai submit -i ubuntu --large-shm --dry-run
Template YAML file can be found at:
/var/folders/xb/rnf9b1bx2jg45c7jprv71d9m0000gn/T/job.yaml185826190
```

## Delete Workloads

To delete a Run:AI workload, delete the Job:

```
kubectl delete runaijob <JOB-NAME>
```



## See Also

* See how to use the above YAML syntax with [Kubernetes API](launch-job-via-kubernetes-api.md)
* Use the [Researcher REST API](../../developer/researcher-rest-api/overview.md) to submit, list and delete Jobs.
