# Quickstart: Launch Interactive Build Workloads with Connected Ports

## Introduction

 This Quickstart is an extension of the Quickstart document: [Start and Use Interactive Build Workloads](walkthrough-build.md) 

 When starting a container with the Run:ai Command-Line Interface (CLI), it is sometimes needed to expose internal ports to the user. Examples are: accessing a Jupyter notebook, using the container from a development environment such as PyCharm. 

## Exposing a Container Port

 There are three ways to expose ports in Kubernetes: _Port Forwarding_, _NodePort_, and _LoadBalancer_. The first two will always work. The other requires a special setup by your administrator. The four methods are explained [here](../../admin/runai-setup/config/allow-external-access-to-containers.md). 

 The document below provides an example based on Port Forwarding.


## Port Forwarding, Step by Step Walkthrough

### Setup

*  Login to the Projects area of the Run:ai user interface.
*  Add a Project named `team-a`.

### Run Workload

*   At the command-line run:

``` bash
runai config project team-a
runai submit nginx-test -i zembutsu/docker-sample-nginx --interactive \
  --service-type portforward --port 8080:80 
```

*   The Job is based on a sample _NGINX_ webserver docker image `zembutsu/docker-sample-nginx`. Once accessed via a browser, the page shows the container name. 
*   Note the _interactive_ flag which means the Job will not have a start or end. It is the Researcher's responsibility to close the Job.  
*   In this example, we have chosen the simplest scheme to expose ports which is port forwarding. We temporarily expose port 8080 to localhost as long as the `runai submit` command is not stopped
*   It is possible to forward traffic from multiple IP addresses by using the "--address" parameter. Check the CLI reference for further details. 

The result will be:

``` bash
The job 'nginx-test-0' has been submitted successfully
You can run `runai describe job nginx-test-0 -p team-a` to check the job status
Waiting for pod to start running...
INFO[0023] Job started
Open access point(s) to service from localhost:8080
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
```

### Access the Webserver 

Open the following in the browser at [http://localhost:8080](http://localhost:8080){target=_blank}.

You should see a web page with the name of the container.

### Stop Workload

Press _Ctrl-C_ in the shell to stop port forwarding. Then delete the Job by running `runai delete job nginx-test`
## See Also

* Develop on Run:ai using [Visual Studio Code](../tools/dev-vscode.md)
* Develop on Run:ai using [PyCharm](../tools/dev-pycharm.md)
* Use a [Jupyter notbook](../tools/dev-jupyter.md) with Run:ai.
