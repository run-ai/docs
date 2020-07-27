## Introduction

The [runai submit](../Command-Line-Interface-API-Reference/runai-submit.md) function and its sybling the [runai submit-mpi](../Command-Line-Interface-API-Reference/runai-submit-mpi.md) function Submit Run:AI jobs for execution. 

A job has a __status__. Once a job is submitted it goes through a number of statuses. Most of these statuses originate in the underlying _Kubernetes_ infrastructure, but some are Run:AI specific. 

The purpose of this document is to explain each of these statuses. 

## Happy flow

A regular, _training_ job which has no errors and executes without preemption would go through the following statuses:
![Job-Statuses-Success](img/Job-Statuses-Success.png)

* Pending - the job is waiting to be scheduled
* Container Creating - the job has been scheduled, the Job docker image is now downloading
* Running - the job is now executing
* Succeeded - the job has finished with exit code 0 (success)


An _interactive_ job, by definition, needs to be closed by the Researcher and will thus never reach the _Succeeded_ status. Rather, it would be moved by the Researcher to status _Deleted_.


A _distributed_ (mpi) job, which has no errors will be slightly more complicated. See picture below 

![mpi-Job-Statuses-Success](img/mpi-Job-Statuses-Success.png)

For an explanation of the additional statuses, see table below


## Status Table

Below is a list of statuses. For each status the list shows:

* Name

* End State -- this status is the final status in the lifecycle of the Job

* Resource Allocation - when the Job is in this status, does the system allocate resources to it.

* Description

* Where to get more data - What command to run to get more information on the problem if such exists. 

* Color - Status color as can be seen in the Administrator User Interface Job list


  <style type="text/css">
    p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 13.3px Arial; color: #000000; -webkit-text-stroke: #000000}
    p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; font: 13.3px Arial; color: #000000; -webkit-text-stroke: #000000; min-height: 15.0px}
    span.s1 {font-kerning: none}
    table.t1 {border-collapse: collapse; table-layout: fixed}
    td.td1 {width: 172.0px; background-color: #afafaf; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #000000; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td2 {width: 48.0px; background-color: #afafaf; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td3 {width: 82.0px; background-color: #afafaf; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td4 {width: 456.0px; background-color: #afafaf; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td5 {width: 151.0px; background-color: #afafaf; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td6 {width: 93.0px; background-color: #afafaf; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #000000 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td7 {width: 172.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #000000; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td8 {width: 48.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td9 {width: 82.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td10 {width: 456.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td11 {width: 151.0px; background-color: #ffffff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td12 {width: 93.0px; background-color: #599b3e; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td13 {width: 172.0px; background-color: #f0f0f0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #000000; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td14 {width: 48.0px; background-color: #f0f0f0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td15 {width: 82.0px; background-color: #f0f0f0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td16 {width: 456.0px; background-color: #f0f0f0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td17 {width: 151.0px; background-color: #f0f0f0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td18 {width: 93.0px; background-color: #fd8608; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td19 {width: 93.0px; background-color: #0000ff; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td20 {width: 93.0px; background-color: #afafaf; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td21 {width: 93.0px; background-color: #fb0007; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td22 {width: 172.0px; background-color: #c1c1c1; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #000000; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td23 {width: 172.0px; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #000000; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td24 {width: 48.0px; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td25 {width: 82.0px; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td26 {width: 456.0px; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td27 {width: 151.0px; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
    td.td28 {width: 93.0px; background-color: #d0d0d0; border-style: solid; border-width: 1.0px 1.0px 1.0px 1.0px; border-color: #c1c1c1 #000000 #000000 #c1c1c1; padding: 2.0px 3.0px 2.0px 3.0px}
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
        <p class="p1"><span class="s1"><b>Reseource Allocation</b></span></p>
      </td>
      <td valign="middle" class="td4">
        <p class="p1"><span class="s1"><b>Description</b></span></p>
      </td>
      <td valign="middle" class="td5">
        <p class="p1"><span class="s1"><b>Where to get more data</b></span></p>
      </td>
      <td valign="middle" class="td6">
        <p class="p1"><span class="s1"><b>Color</b></span></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">Running</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p1"><span class="s1">Job is running successfully</span></p>
      </td>
      <td valign="middle" class="td11">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Terminating</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td15">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td16">
        <p class="p1"><span class="s1">Pod is beeing evicted at the moment (e.g. due to an over-quota allocation, the reason will be writen once eviction finishes). A new pod will be created shortly</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p1"><span class="s1">runai get &lt;job-name&gt;<span class="Apple-converted-space"> </span></span></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">ContainerCreating</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p1"><span class="s1">Image is being pulled from registry</span></p>
      </td>
      <td valign="middle" class="td11">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Init:&lt;number A&gt;/&lt;number B&gt;</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td15">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td16">
        <p class="p1"><span class="s1"><b>MPI Status Only</b>: Waiting for B init containers to finish running, currently A are running</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">PodInitializing</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p1"><span class="s1"><b>MPI Status Only: </b>Init container is running. Currently we have an init container used only for MPI job, but we do support worklaods with init containers with .yaml files.</span></p>
      </td>
      <td valign="middle" class="td11">
        <p class="p1"><span class="s1">runai get &lt;job-name&gt;<span class="Apple-converted-space"> </span></span></p>
      </td>
      <td valign="middle" class="td12">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Pending</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td15">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td16">
        <p class="p1"><span class="s1">Job is pending. Possible reasons:</span></p>
        <p class="p1"><span class="s1">- Not enough resources</span></p>
        <p class="p1"><span class="s1">- Waiting in Queue (over quota etc)</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p1"><span class="s1">runai get &lt;job-name&gt;<span class="Apple-converted-space"> </span></span></p>
      </td>
      <td valign="middle" class="td18">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">Succeeded</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p1"><span class="s1">An Unattended (training) Job has ran and finished successfully</span></p>
      </td>
      <td valign="middle" class="td11">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td19">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Deleted</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td15">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td16">
        <p class="p1"><span class="s1">Job has been deleted</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td20">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">TimedOut</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p1"><span class="s1">Interactive job has reached the defined timeout of the project</span></p>
      </td>
      <td valign="middle" class="td11">
        <p class="p1"><span class="s1">runai get &lt;job-name&gt;<span class="Apple-converted-space"> </span></span></p>
      </td>
      <td valign="middle" class="td20">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Preempted</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td15">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td16">
        <p class="p1"><span class="s1">Interactive preeemptible job has been evicted</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p1"><span class="s1">runai get &lt;job-name&gt;<span class="Apple-converted-space"> </span></span></p>
      </td>
      <td valign="middle" class="td20">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">ContainerCannotRun</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p1"><span class="s1">Container has failed to start running. This is typically a problem within the docker image itself</span></p>
      </td>
      <td valign="middle" class="td11">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td21">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Error</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td15">
        <p class="p1"><span class="s1">Yes for interactive only<span class="Apple-converted-space"> </span></span></p>
      </td>
      <td valign="middle" class="td16">
        <p class="p1"><span class="s1">The job has returned an exit code different than zero. It is now waiting for another run attempt (retry)</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p1"><span class="s1">runai logs &lt;job-name&gt;</span></p>
      </td>
      <td valign="middle" class="td21">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td22">
        <p class="p1"><span class="s1">CrashLoopBackOff</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p1"><span class="s1"><b>Interactive Only: </b>During backoff after Error, before the Kubelet retires to run pod</span></p>
      </td>
      <td valign="middle" class="td11">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td21">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">Fail</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td15">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td16">
        <p class="p1"><span class="s1">Job has failed after a number of retries (according to "--backoffLimit" field) and will not be trying again. This is a final state</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p1"><span class="s1">runai logs &lt;job-name&gt;</span></p>
      </td>
      <td valign="middle" class="td21">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td7">
        <p class="p1"><span class="s1">ErrImagePull</span></p>
      </td>
      <td valign="middle" class="td8">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td9">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td10">
        <p class="p1"><span class="s1">Failed to retrieve the image you specified as image</span></p>
      </td>
      <td valign="middle" class="td11">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td21">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td13">
        <p class="p1"><span class="s1">ImagePullBackOff</span></p>
      </td>
      <td valign="middle" class="td14">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td15">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td16">
        <p class="p1"><span class="s1">During backoff after ImagePullBackOff, before retrying to pull the image again</span></p>
      </td>
      <td valign="middle" class="td17">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td21">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
    <tr>
      <td valign="middle" class="td23">
        <p class="p1"><span class="s1">Unknown</span></p>
      </td>
      <td valign="middle" class="td24">
        <p class="p1"><span class="s1">Yes</span></p>
      </td>
      <td valign="middle" class="td25">
        <p class="p1"><span class="s1">-</span></p>
      </td>
      <td valign="middle" class="td26">
        <p class="p1"><span class="s1">The Run:AI Scheduler wasn't running when the job has finished</span></p>
      </td>
      <td valign="middle" class="td27">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
      <td valign="middle" class="td28">
        <p class="p2"><span class="s1"></span><br></p>
      </td>
    </tr>
  </tbody>
</table>