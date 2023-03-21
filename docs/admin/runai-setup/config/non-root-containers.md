
# User Identity in Container

The identity of the user in the container determines its access to resources. For example, network file storage solutions typically use this identity to determine the container's access to network volumes. This document explains multiple ways for propagating the user identity into the container.

## The Default: Root Access

In docker, as well as in Kubernetes, the default for running containers is running as _root_. The implication of running as root is that processes running within the container have enough permissions to change anything in the container, and if propagated to network resources - can have permissions outside the container as well. 

This gives a lot of power to the Researcher but does not sit well with modern security standards of enterprise security. 

By default, if you run:

```
runai submit -i ubuntu --attach --interactive -- bash
```
then run `id`, you will see the **root** user. 

## Use Run:ai flags to limit root access

There are two [runai submit](../../../Researcher/cli-reference/runai-submit.md) flags which control user identity at the Researcher level:

* The flag `--run-as-user` starts the container with a specific user. The user is the current Linux user (see below for other behaviors if used in conjunction with Single sign-on). 
* The flag `--prevent-privilege-escalation` prevents the container from elevating its own privileges into `root` (e.g. running `sudo` or changing system files.). 

Equivalent flags exist in the Researcher User Interface.
### Run as Current User

From a Linux/Mac box, run:

```
runai submit -i ubuntu --attach --interactive --run-as-user -- bash
```

then run `id`, you will see the users and groups of the box you have been using to launch the Job.


### Prevent Escalation

From a Linux/Mac box, run:

```
runai submit -i ubuntu --attach --interactive --run-as-user \
  --prevent-privilege-escalation  -- bash
```

then verify that you cannot run `su` to become root within the container. 


### Setting a Cluster-Wide Default


The two flags are voluntary. They are not enforced by the system. It is however possible to enforce them using [Policies](../../workloads/policies.md). Polices allow an Administrator to force compliance on both the User Interface and Command-line interface. 


## Passing user identity 
### Passing user identity from Identity Provider

A best practice is to store the user identifier (UID) and the group identifier (GID) in the organization's directory. Run:ai allows you to pass these values to the container and use them as the container identity.

To perform this, you must:

* Set up [single sign-on](../authentication/sso.md). Perform the steps for UID/GID integration.
* Run: `runai login` and enter your credentials
* Use the flag --run-as-user

Running `id` should show the identifier from the directory.


### Passing user identity explicitly via the Researcher UI 

Via the Researcher User Interface, it is possible to explicitly provide the user id and group id:

![](img/uid-explicit.png)


##  Using OpenShift or Gatekeeper to provide Cluster Level Controls


Run:ai supports OpenShift as a Kubernetes platform. In OpenShift the system will provide a __random__ UID to containers. The flags `--run-as-user` and `--prevent-privilege-escalation` are disabled on OpenShift.
It is possible to achieve a similar effect on Kubernetes systems that are not OpenShift. A leading tool is [Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/docs/){target=_blank}. Gatekeeper similarly enforces non-root on containers at the system level. 


## Creating a Temporary Home Directory

When containers run as a specific user, the user needs to have a pre-created home directory __within__ the image. Otherwise, when running a shell, you will not have a home directory:

``` bash hl_lines="8"
runai submit -i ubuntu --attach --interactive --run-as-user -- bash
The job 'job-0' has been submitted successfully
You can run `runai describe job job-0 -p team-a` to check the job status
Waiting for pod to start running...
INFO[0007] Job started
Connecting to pod job-0-0-0
If you don't see a command prompt, try pressing enter.
I have no name!@job-0-0-0:/$ 
```

Adding home directories to an image per user is not a viable solution. To overcome this, Run:ai provides an additional flag `--create-home-dir`. Adding this flag creates a temporary home directory for the user within the container.  

!!! Notes
    * Data saved in this directory will not be saved when the container exits. 
    * This flag is set by __default to true__ when the `--run-as-user` flag is used, and false if not.



