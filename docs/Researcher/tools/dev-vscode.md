# Use Visual Studio Code with a Run:ai Job

Once you launch a workload using Run:ai, you will want to connect to it. You can do so via command line or via other tools such as a [Jupyter Notebook](../workloads/workspaces/quickstart-jupyter.md)

!!! Important
    This document is about accessing the remote container created by Run:ai, from the __installed version__ of [Visual Studio Code](https://code.visualstudio.com/){target=_blank}. If you want to use Visual Studio Code for __web__, please see [Visual Studio Code Web Quickstart](../Walkthroughs/quickstart-vscode.md).


## Submit a Workload

You will need your image to run an SSH server  (e.g [OpenSSH](https://www.ssh.com/ssh/sshd/){target=_blank}). For this document, we have created an image named `runai.jfrog.io/demo/pycharm-demo`. The image runs both python and ssh. Details on how to create the image are [here](https://github.com/run-ai/docs/tree/master/quickstart/python%2Bssh){target=_blank}. The image is configured to use the ``root`` user and password for SSH.

Run the following command to connect to the container as if it were running locally:

```shell
runai workspace submit build-remote -i runai.jfrog.io/demo/pycharm-demo
```

Track the workload status:
```shell
runai workspace list
```

Once the workload is running, you can connect using:
```shell
runai workspace port-forward build-remote --port 2222:22
```

* The Job starts an sshd server on port 22.
* The connection is redirected to the local machine (127.0.0.1) on port 2222

!!! Note

    It is possible to connect to the container using a remote IP address. However, this would be less convinient as you will need to maintain port numbers manually and change them when remote accessing using the development tool. As an example, run:
    ```shell
    runai workspace submit build-remote -i runai.jfrog.io/demo/pycharm-demo -g 1 --port service-type=NodePort,container=22,external=30022
    ```
    * The Workload starts an sshd server on port 22.
    * The Workload redirects the external port 30022 to port 22 and uses a [Node Port](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types){target=_blank} service type.
    * Run: `runai workspace describe build-remote`
    * Under the "Networks" title you will find the IP address and port. The port is 30222 

    Networks
    Name             Tool Type        Connection Type  URL              
    ─────────────────────────────────────────────────────────────────────
    port                              NodePort         172.18.0.5:30022

## Visual Studio Code

* Under Visual Studio code install the [Remote SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh#:~:text=Press%20F1%20and%20run%20the,setting%20up%20key%20based%20authentication){target=_blank} extension.
* Create an ssh entry to the service by editing .ssh/config file or use the command __Remote-SSH: Connect to Host...__ from the Command Palette.  Enter the IP address and port from above (e.g. ssh root@35.34.212.12 -p 30022 or ssh root@127.0.0.1 -p 2222). User and password are ``root`` 
* Using VS Code, install the [Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python){target=_blank} __on the remote machine__  
* Write your first Python code and run it remotely.