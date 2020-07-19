# Introduction

The current Run:AI command-line interface (CLI) is based on a single permission model. If you can run a workload using the CLI, then you can, in principle, use all projects, as well as view, change and delete other people's workloads. This is not a sustainable model for most organizations&nbsp;

We now introduce a new version of the CLI which is permission-aware. This guide is about how to migrate to this new version.

# Recap on Projects

in Run:AI terminology, _Projects_ <span>are used to manage resource allocations for Researchers. Projects are defined by the administrator user interface (accessible</span> at <a href="https://app.run.ai" target="_self">app.run.ai</a>) and are associated, amongst other things, with a GPU quota available for users of this project.

<span>Projects are utilized by using their name with the -p or --project flag in the CLI, for example when submitting a workload:</span>

<pre>runai submit &lt;job-name&gt; ..... --project team-a</pre>

# Permissions are based on Projects&nbsp;

<span>With the new Run:AI architecture, permissions are based on the granularity of projects. Administrators can provide designated people with access to a project and only these people will be able to submit and view workloads based on that project.&nbsp;</span>

This creates changes in the way the CLI works.

# Changes with the new CLI

<span>A workload now exists in the context of a project</span>. When using a command, you must add the project name with the flag -p &lt;project name&gt;. Examples:

<pre>runai list -p team-a<br/>runai bash &lt;job-name&gt; -p team-a<br/>runai logs &lt;job-name&gt; -p team-a</pre>

If you want to avoid adding the -p flag, you can set a&nbsp;__default project__. To set 'team-a' as the default project, run:

<pre>runai project set team-a</pre>

Henceforth, all other CLI commands will be run in the context of the default project you have set.

You can also see the list of projects and view the current default project by running:

<pre>&nbsp;runai project list</pre>

<img alt="mceclip0.png" height="80" src="https://support.run.ai/hc/article_attachments/360011677760/mceclip0.png" width="230"/>

<span>To view all workloads you are authorized to, regardless of their associated project, use the&nbsp;</span><em data-stringify-type="italic">-A</em><span>&nbsp;flag:</span>

<pre>runai list -A</pre>

# Upgrade

<span>After installing the new Run:AI CLI, workloads that have been submitted using the older version of the&nbsp;CLI may still be running.&nbsp;</span>

![mceclip0.png](https://support.run.ai/hc/article_attachments/360011652020/mceclip0.png)

<span>Such workloads will be accessible to all researchers using the old methods</span>, without the need for the -p flag, __until a default project is set__. Once a default project has been set, these older workloads will only be accessible by using the flag '_--backward-compatibility_' or '_-b_'. Example:&nbsp;

<pre>runai bash &lt;old-job-name&gt; -b </pre>

&nbsp;You can identify old jobs by adding the -b flag to the runai list command as such:

<pre>runai list -b&nbsp;</pre>

![mceclip0.png](https://support.run.ai/hc/article_attachments/360011673679/mceclip0.png)

or by viewing&nbsp;__all&nbsp;__workloads using the -A flag:

<pre>runai list -A</pre>

# Next Steps

For further information on how to authenticate users as well as providing user-access to Projects, please contact Run:AI customer support.