# Use PyCharm with a Run:ai Job

Once you launch a workload using Run:ai, you will want to connect to it. You can do so via command-line or via other tools such as a [Jupyter Notebook](../Walkthroughs/walkthrough-build-ports.md)

This document is about accessing the remote container created by Run:ai, from JetBrain's [PyCharm](https://www.jetbrains.com/pycharm/){target=_blank}. 


## Submit a Workload

You will need your image to run an SSH server  (e.g [OpenSSH](https://www.ssh.com/ssh/sshd/){target=_blank}). For the purposes of this document, we have created an image named `gcr.io/run-ai-demo/pycharm-demo`. The image runs both python and ssh. Details on how to create the image are [here](https://github.com/run-ai/docs/tree/master/quickstart/python%2Bssh){target=_blank}. The image is configured to use the ``root`` user and password for SSH.

Run the following command to connect to the container as if it were running locally:

```
runai submit build-remote -i gcr.io/run-ai-demo/pycharm-demo --interactive  \
        --service-type=portforward --port 2222:22
```

The terminal will show the connection: 

``` shell
The job 'build-remote' has been submitted successfully
You can run `runai describe job build-remote -p team-a` to check the job status
INFO[0007] Waiting for job to start
Waiting for job to start
Waiting for job to start
Waiting for job to start
INFO[0045] Job started
Open access point(s) to service from localhost:2222
Forwarding from [::1]:2222 -> 22
```

* The Job starts an sshd server on port 22.
* The connection is redirected to the local machine (127.0.0.1) on port 2222

!!! Note

        It is possible to connect to the container using a remote IP address. However, this would be less convinient as you will need to maintain port numbers manually and change them when remote accessing using the development tool. As an example, run:

        ```
        runai submit build-remote -i gcr.io/run-ai-demo/pycharm-demo -g 1 --interactive --service-type=nodeport --port 30022:22
        ```

        * The Job starts an sshd server on port 22.
        * The Job redirects the external port 30022 to port 22 and uses a [Node Port](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types){target=_blank} service type.
        * Run: `runai list worklaods`

        * Next to the Job, under the "Service URL" column you will find the IP address and port. The port is 30222 


## PyCharm

* Under PyCharm | Preferences go to: Project | Python Interpreter 
* Add a new SSH Interpreter. 
* As Host, use the IP address above. Change the port to the above and use the Username `root`
* You will be prompted for a password. Enter `root`
* Apply settings and run the code via this interpreter. You will see your project uploaded to the container and running remotely. 