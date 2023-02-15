# Use PyCharm with X11 Forwarding and Run:ai

__X11__ is a window system for the Unix operating systems. __X11 forwarding__ allows executing a program remotely through an SSH connection. Meaning, the executable file itself is hosted on a different machine than where the graphical interface is being displayed. The graphical windows are forwarded to your local machine through the SSH connection.

This section is about setting up X11 forwarding from a Run:ai-based container to a [PyCharm](https://www.jetbrains.com/pycharm/){target=_blank} IDE on a remote machine.
 


## Submit a Workload

You will need your image to run an SSH server  (e.g [OpenSSH](https://www.ssh.com/ssh/sshd/){target=_blank}). For the purposes of this document, we have created an image named `gcr.io/run-ai-demo/quickstart-x-forwarding`. The image runs:

* Python
* SSH Daemon configured for X11Forwarding 
* OpenCV python library for image handling

Details on how to create the image are [here](https://github.com/run-ai/docs/tree/master/quickstart/x-forwarding){target=_blank}. The image is configured to use the ``root`` user and password for SSH.

Run the following command to connect to the container as if it were running locally:

```
runai submit xforward-remote -i gcr.io/run-ai-demo/quickstart-x-forwarding --interactive  \
        --service-type=portforward --port 2222:22
```

The terminal will show the connection:

``` shell
The job 'xforward-remote' has been submitted successfully
You can run `runai describe job xforward-remote -p team-a` to check the job status
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

## Setup the X11 Forwarding Tunnel

Connect to the new Job by running:

``` shell
ssh -X root@127.0.0.1 -p 2222
```

Note the `-X` flag. 

Run:

```
echo $DISPLAY

```
Copy the value. It will be used as a PyCharm environment variable.

!!! Important
    The ssh terminal should remain active throughout the session.

## PyCharm

* Under PyCharm | Preferences go to: Project | Python Interpreter
* Add a new SSH Interpreter.
* As Host, use `localhost`. Change the port to the above (`2222`) and use the Username `root`.
* You will be prompted for a password. Enter `root`.
* Make sure to set the correct path of the Python binary. In our case it's `/usr/local/bin/python`.
* Apply your settings.

* Under PyCharm configuration set the following environment variables:
    1. `DISPLAY` - set environment variable you copied before
    3. `HOME` - In our case it's `/root`. This is required for the X11 authentication to work.

Run your code. You can use our sample code [here](https://github.com/run-ai/docs/tree/master/quickstart/x-forwarding/project){target=_blank}.