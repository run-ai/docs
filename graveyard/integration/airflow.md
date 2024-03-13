# Integrate Run:ai with Apache Airflow

Airflow is a platform to programmatically author, schedule, and monitor workflows. Specifically, it is used in Machine Learning to create pipelines.  


## Airflow DAG 

In Airflow, a _DAG_ – or a Directed Acyclic Graph – is a collection of all the tasks you want to run, organized in a way that reflects their relationships and dependencies.

A DAG is defined in a Python script, which represents the DAGs structure (tasks and their dependencies) as code.

For example, a simple DAG could consist of three tasks: A, B, and C. It could say that A has to run successfully before B can run, but C can run anytime. It could say that task A times out after 5 minutes, and B can be restarted up to 5 times in case it fails. It might also say that the workflow will run every night at 10 pm, but shouldn’t start until a certain date.

Airflow tasks are sent for execution. Specifically, the [Airflow - Kubernetes integration](https://airflow.apache.org/docs/stable/kubernetes.html){target=_blank} allows Airflow tasks to be scheduled on a Kubernetes cluster. 

## Run:ai - Airflow Integration

DAGs are defined in Python. Airflow tasks based on Kubernetes are defined via the _KubernetesPodOperator_ class. 
To run an Airflow task with Run:ai you must provide additional, Run:ai-related, properties to 

``` python
dag = DAG(...)

resources = {
  "limit_gpu": <number-of-GPUs>
}

job = KubernetesPodOperator(
    namespace='runai-<project-name>',
    image='<image-name>',
    labels={"project": '<project-name>'},
    name='<task-name>',
    task_id='<task-name>',
    get_logs=True,
    schedulername='runai-scheduler',
    resources=resources,
    dag=dag
    )

```
The code:

* Specifies the __runai-scheduler__ which directs the task to be scheduled with the Run:ai scheduler
* Specifies a Run:ai __Project__. A Project in Run:ai specifies guaranteed GPU & CPU quota.  


Once you run the DAG, you can see Airflow tasks shown in the Run:ai UI. 



