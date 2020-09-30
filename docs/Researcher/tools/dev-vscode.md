# Use Visual Studio Code to work with a Run:AI Job

Once you launch a workload using Run:AI, you will want to connect to it. You can do so via command-line or via other tools such as a [Jupyter Notebook](../Walkthroughs/walkthrough-build-ports.md)

This document is about accessing the remote container created by Run:AI, from [Visual Studio Code](https://code.visualstudio.com/). 


## Submit a Workload

You will need your image to run an ssh server  (e.g [OpenSSH](https://www.ssh.com/ssh/sshd/)). For the purposes of this document, we used a sample __Docker Hub__ repository which runs sshd with ``root`` user and password:

    runai submit build-remote -i rastasheep/ubuntu-sshd:14.04  -g 1 --interactive \
        --command "/usr/sbin/sshd" --args "-D" --service-type=nodeport --port 30022:22

* The job starts an sshd server on port 22.
* The job redirects the external port 30,022 to port 22 and uses a [Node Port](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) service type.
* Run:

        runai list

* Next to the job, under the "Service URL" column you will find the IP address and port. 

## Visual Studio Code

* Under Visual Studio code install the [Remote SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh#:~:text=Press%20F1%20and%20run%20the,setting%20up%20key%20based%20authentication) extension.
* Create an ssh entry to the service by editing .ssh/config file or use the command __Remote-SSH: Connect to Host...__ from the Command Palette.  Enter the IP address and port from above (e.g. ssh root@35.34.212.12 -p 30022). User and password are ``root`` 
* Using VS Code, install the [Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) __on the remote machine__  
* Write your first python code and run it remotely.