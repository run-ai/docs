## Introduction

The [runai submit](../cli-reference/runai-submit.md) function and its sibling the [runai submit-mpi](../cli-reference/runai-submit-mpi.md) function submit Run:ai Jobs for execution. 

A Job has a __status__. Once a Job is submitted it goes through several statuses before ending in an __End State__. Most of these statuses originate in the underlying _Kubernetes_ infrastructure, but some are Run:ai-specific. 

The purpose of this document is to explain these statuses as well as the lifecycle of a Job. 

## Successful Flow

A regular, _training_ Job that has no errors and executes without preemption would go through the following statuses:

![Job-Statuses-Success](img/Job-Statuses-Success.png)

* _Pending_ - the Job is waiting to be scheduled.
* _ContainerCreating_ - the Job has been scheduled, the Job docker image is now downloading.
* _Running_ - the Job is now executing.
* _Succeeded_ - the Job has finished with exit code 0 (success).

The Job can be preempted, in which case it can go through other statuses:

* _Terminating_ - the Job is now being preempted.
* _Pending_ - the Job is waiting in queue again to receive resources.

An _interactive_ Job, by definition, needs to be closed by the Researcher and will thus never reach the _Succeeded_ status. Rather, it would be moved by the Researcher to status _Deleted_.


For a further explanation of the additional statuses, see the table below.

## Error flow

A regular, _training_ Job may encounter an error inside the running process (exit code is non-zero). In which case the following will happen:

![Job-Statuses Training Error](img/Job-Statuses-Training-Error.png)

The Job enters an _Error_ status and then immediately tries to reschedule itself for another attempted run. The reschedule can happen on another node in the system. After a specified number of retries, the Job will enter a final status of _Fail_

An _interactive_ Job, enters an _Error_ status and then moves immediately to _CrashLoopBackOff_ trying to reschedule itself. The reschedule attempt has no 'back-off' limit and will continue to retry indefinitely 

![Job-Statuses Interactive Error](img/Job-Statuses-Interactive-Error.png)

Jobs may be submitted with an image that cannot be downloaded. There are special statuses for such Jobs. See table below 


## Status Table

Below is a list of statuses. For each status the list shows:

* Name

* End State - this status is the final status in the lifecycle of the Job

* Resource Allocation - when the Job is in this status, does the system allocate resources to it

* Description

* Color - Status color as can be seen in the Run:ai User Interface Job list

<style type="text/css">
    p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 13.3px Arial; color: #000000; -webkit-text-stroke: #000000}
    p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; font: 13.3px Arial; color: #000000; -webkit-text-stroke: #000000; min-height: 15.0px}
    span.s1 {font-kerning: none}
    table.t1 {border-collapse: collapse; table-layout: fixed}
    td.td1 {width: 172.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #000000; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td2 {width: 48.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td3 {width: 82.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td4 {width: 456.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td5 {width: 93.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td6 {width: 172.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #000000; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td7 {width: 48.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td8 {width: 82.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td9 {width: 456.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td10 {width: 93.0px; background-color: #599b3e; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td11 {width: 172.0px; background-color: #f0f0f0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #000000; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td12 {width: 48.0px; background-color: #f0f0f0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td13 {width: 82.0px; background-color: #f0f0f0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td14 {width: 456.0px; background-color: #f0f0f0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td15 {width: 93.0px; background-color: #fd8608; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td16 {width: 93.0px; background-color: #0000ff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td17 {width: 93.0px; background-color: #afafaf; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td18 {width: 93.0px; background-color: #fb0007; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td19 {width: 172.0px; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #000000; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td20 {width: 48.0px; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td21 {width: 82.0px; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td22 {width: 456.0px; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td23 {width: 93.0px; background-color: #d0d0d0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
  </style>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="middle" class="td1">
        <p class="p1"><span class="s1"><b>Status</b></span></p>
      </td>
      <td valign="middle" class="td2">
        <p class="p1"><span class="s1"><b>End State</b></span></p>
      </td>
      <td valign="middle" class="td3">
        <p class="p1"><span class="s1"><b>Resource Allocation</b></span></p>
      </td>
      <td valign="middle" class="td4">
        <p class="p1"><span class="s1"><b>Description</b></span></p>
      </td>
      <td valign="middle" class="td5">
        <p class="p1"><span class="s1"><b>Color</b></span></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td6">
        <p class="p1"><span class="s1">Running</span></p>
      </td>
      <td valign="middle" class="td7">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Job is running successfully</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td11">
        <p class="p1"><span class="s1">Terminating</span></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1">Pod is being evicted at the moment (e.g. due to an over-quota allocation, the reason will be written once eviction finishes). A new pod will be created shortly</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td6">
        <p class="p1"><span class="s1">ContainerCreating</span></p>
      </td>
      <td valign="middle" class="td7">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Image is being pulled from registry.</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td11">
        <p class="p1"><span class="s1">Pending</span></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1">Job is pending. Possible reasons:</span></p>
        <p class="p1"><span class="s1">- Not enough resources</span></p>
        <p class="p1"><span class="s1">- Waiting in Queue (over quota etc).</span></p>
      </td>
      <td valign="middle" class="td15">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td6">
        <p class="p1"><span class="s1">Succeeded</span></p>
      </td>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">An Unattended (training) Job has ran and finished successfully.</span></p>
      </td>
      <td valign="middle" class="td16">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td11">
        <p class="p1"><span class="s1">Deleted</span></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1">Job has been deleted.</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td6">
        <p class="p1"><span class="s1">TimedOut</span></p>
      </td>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Interactive Job has reached the defined timeout of the project.</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td11">
        <p class="p1"><span class="s1">Preempted</span></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1">Interactive preemptible Job has been evicted.</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td6">
        <p class="p1"><span class="s1">ContainerCannotRun</span></p>
      </td>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Container has failed to start running. This is typically a problem within the docker image itself.</span></p>
      </td>
      <td valign="middle" class="td18">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td11">
        <p class="p1"><span class="s1">Error</span></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Yes for interactive only<span class="Apple-converted-space"> </span></span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1">The Job has returned an exit code different than zero. It is now waiting for another run attempt (retry).</span></p>
      </td>
      <td valign="middle" class="td18">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td11">
        <p class="p1"><span class="s1">Fail</span></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1">Job has failed after a number of retries (according to "--backoffLimit" field) and will not be trying again.</span></p>
      </td>
      <td valign="middle" class="td18">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td11">
        <p class="p1"><span class="s1">CrashLoopBackOff</span></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1"><b>Interactive Only: </b>During backoff after Error, before a retry attempt to run pod on the same node.</span></p>
      </td>
      <td valign="middle" class="td18">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td6">
        <p class="p1"><span class="s1">ErrImagePull, ImagePullBackOff</span></p>
      </td>
      <td valign="middle" class="td7">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Failing to retrieve docker image</span></p>
      </td>
      <td valign="middle" class="td18">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td19">
        <p class="p1"><span class="s1">Unknown</span></p>
      </td>
      <td valign="middle" class="td20">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td21">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td22">
        <p class="p1"><span class="s1">The Run:ai Scheduler wasn't running when the Job has finished.</span></p>
      </td>
      <td valign="middle" class="td23">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
  </tbody>
</table>

## How to get more information

The system stores various _events_ during the Job's lifecycle. These events can be helpful in diagnosing issues around Job scheduling. To view these events run:

    runai describe job <workload-name>


Sometimes, useful information can be found by looking at  logs emitted from the process running inside the container. For example, Jobs that have exited with an exit code different than zero may write an exit reason in this log. To see Job logs run:

    runai logs <job-name>


## Distributed Training (mpi) Jobs

A _distributed_ (mpi) Job, which has no errors will be slightly more complicated and has additional statuses associated with it. 

* Distributed Jobs start with an "init container" which sets the stage for a distributed run.

* When the init container finishes, the main "launcher" container is created. The launcher is responsible for coordinating between the different workers

* Workers run and do the actual work.

A successful flow of distribute training would look as:

![mpi-Job-Statuses-Success](img/mpi-Job-Statuses-Success.png)

Additional Statuses:

  
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="middle" class="td1">
        <p class="p1"><span class="s1"><b>Status</b></span></p>
      </td>
      <td valign="middle" class="td2">
        <p class="p1"><span class="s1"><b>End State</b></span></p>
      </td>
      <td valign="middle" class="td3">
        <p class="p1"><span class="s1"><b>Resource Allocation</b></span></p>
      </td>
      <td valign="middle" class="td4">
        <p class="p1"><span class="s1"><b>Description</b></span></p>
      </td>
      <td valign="middle" class="td5">
        <p class="p1"><span class="s1"><b>Color</b></span></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td6">
        <p class="p1"><span class="s1">Init:&lt;number A&gt;/&lt;number B&gt;</span></p>
      </td>
      <td valign="middle" class="td7">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">The Pod has B Init Containers, and A have completed so far.</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td6">
        <p class="p1"><span class="s1">PodInitializing</span></p>
      </td>
      <td valign="middle" class="td7">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">The pod has finished executing Init Containers. The system is creating the main 'launcher' container</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="bottom" class="td6">
        <p class="p1"><span class="s1">Init:Error</span></p>
      </td>
      <td valign="bottom" class="td7">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="bottom" class="td8">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="bottom" class="td9">
        <p class="p1"><span class="s1">An Init Container has failed to execute.</span></p>
      </td>
      <td valign="middle" class="td18">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="bottom" class="td6">
        <p class="p1"><span class="s1">Init:CrashLoopBackOff</span></p>
      </td>
      <td valign="bottom" class="td7">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="bottom" class="td8">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="bottom" class="td9">
        <p class="p1"><span class="s1">An Init Container has failed repeatedly to execute</span></p>
      </td>
      <td valign="middle" class="td18">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
  </tbody>
</table>



