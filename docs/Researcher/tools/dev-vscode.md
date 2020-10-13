# Use Visual Studio Code with a Run:AI Job

Once you launch a workload using Run:AI, you will want to connect to it. You can do so via command-line or via other tools such as a [Jupyter Notebook](../Walkthroughs/walkthrough-build-ports.md)

This document is about accessing the remote container created by Run:AI, from [Visual Studio Code](https://code.visualstudio.com/). 


## Submit a Workload

You will need your image to run an SSH server  (e.g [OpenSSH](https://www.ssh.com/ssh/sshd/)). For the purposes of this document, we have created an image named `gcr.io/run-ai-demo/pycharm-demo`. The image runs both python and ssh. Details on how to create the image are [here](https://github.com/run-ai/docs/tree/master/quickstart/python%2Bssh). The image is configured to use the ``root`` user and password for SSH.

Run the following command: 

```
runai submit build-remote -i gcr.io/run-ai-demo/pycharm-demo -g 1 --interactive \
        --command sleep --args infinity --service-type=nodeport --port 30022:22
```

* The job starts an sshd server on port 22.
* The job redirects the external port 30,022 to port 22 and uses a [Node Port](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) service type.
* Run:

        runai list

* Next to the job, under the "Service URL" column you will find the IP address and port. 

Alternatively, use "port forwarding" to connect to the container as if it were running locally. Run:

```
runai submit build-remote -i gcr.io/run-ai-demo/pycharm-demo --interactive  \
        --command sleep --args infinity --service-type=portforward --port 2222:22
```

The terminal will show the connection: 

``` shell
The job 'build-remote' has been submitted successfully
You can run `runai get build-remote -p team-a` to check the job status
INFO[0007] Waiting for job to start
Waiting for job to start
Waiting for job to start
Waiting for job to start
INFO[0045] Job started
Open access point(s) to service from localhost:2222
Forwarding from [::1]:2222 -> 22
```

The IP address in this case will be 127.0.0.1.


## Visual Studio Code

* Under Visual Studio code install the [Remote SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh#:~:text=Press%20F1%20and%20run%20the,setting%20up%20key%20based%20authentication) extension.
* Create an ssh entry to the service by editing .ssh/config file or use the command __Remote-SSH: Connect to Host...__ from the Command Palette.  Enter the IP address and port from above (e.g. ssh root@35.34.212.12 -p 30022 or ssh root@127.0.0.1 -p 2222). User and password are ``root`` 
* Using VS Code, install the [Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) __on the remote machine__  
* Write your first python code and run it remotely.