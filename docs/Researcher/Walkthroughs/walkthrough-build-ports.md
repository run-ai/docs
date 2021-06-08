# Quickstart: Launch Interactive Build Workloads with Connected Ports

## Introduction

 This Quickstart is an extension of the Quickstart document: [Start and Use Interactive Build Workloads](walkthrough-build.md) 

 When starting a container with the Run:AI Command-Line Interface (CLI), it is possible to expose internal ports to the container user.   

## Exposing a Container Port

 There are 4 ways to expose ports in Kubernetes: _Port Forwarding_, _NodePort_, _LoadBalancer_ and _Ingress_. The first 2 will always work. The others require a special setup by your administrator. The 4 methods are explained [here](../../Administrator/Cluster-Setup/allow-external-access-to-containers.md). 

 The document below provides examples based on Port Forwarding and Ingress.

!!! Note
    The step below use a Jupyter Notebook as an example for how to expose Ports. There is also a special shortcut for starting a Jupyter Notebook detailed [here](../tools/dev-jupyter.md). 

## Port Forwarding, Step by Step Walkthrough

### Setup

*  Login to the Projects area of the Run:AI Administration user interface at [https://app.run.ai/projects](https://app.run.ai/projects){target=_blank}
*  Add a Project named "team-a"
*  Allocate 2 GPUs to the Project

### Run Workload

*   At the command-line run:

``` bash
runai config project team-a
runai submit jupyter1 -i jupyter/base-notebook -g 1 --interactive \ 
  --service-type=portforward --port 8888:8888  --command 
  -- start-notebook.sh --NotebookApp.base_url=jupyter1
```

*   The Job is based on a generic Jupyter notebook docker image ``jupyter/base-notebook`` 
*    We named the Job _jupyter1_.   Note that in this Jupyter implementation, the name of the Job should also be copied to the Notebook base URL.   
*   Note the _interactive_ flag which means the Job will not have a start or end. It is the Researcher's responsibility to close the Job.  
*   The Job is assigned to team-a with an allocation of a single GPU.
*   In this example, we have chosen the simplest scheme to expose ports which is port forwarding. We temporarily expose port 8888 to localhost as long as the ``runai submit`` command is not stopped

### Open the Jupyter notebook

Open the following in the browser

```
http://localhost:8888/jupyter1
```

You should see a Jupyter notebook. To get the full URL with the notebook token, run the following in another shell:

```
runai logs jupyter1 -p team-a
```

## Ingress, Step by Step Walkthrough

__Note:__ Ingress must be set up by your Administrator prior to usage. For more information see:  [Exposing Ports from Researcher Containers Using Ingress](../../Administrator/Cluster-Setup/allow-external-access-to-containers.md).

### Setup

*   Perform the setup steps for port forwarding above.  

### Run Workload

*   At the command-line run:

``` shell
runai config project team-a
runai submit test-ingress -i jupyter/base-notebook -g 1  --interactive \ 
  --service-type=ingress --port 8888  --command  \ 
  -- start-notebook.sh --NotebookApp.base_url=team-a-test-ingress
```

*   An ingress service URL will be created, run:

        runai list jobs

You will see the service URL with which to access the Jupyter notebook

![mceclip0.png](img/mceclip0.png)

!!! Important note
    With ingress, Run:AI creates an access URL whose domain is _uniform_ (and is IP which serves as the access point to the cluster). The rest of the path is _unique_ and is build as: __&lt;project-name&gt;-&lt;job-name&gt;__. Thus, with the example above, we must set the Jupyter notebook base URL to respond to the service at __team-a-test-ingress__

## See Also

* Develop on Run:AI using [Visual Studio Code](../tools/dev-vscode.md)
* Develop on Run:AI using [PyCharm](../tools/dev-pycharm.md)
