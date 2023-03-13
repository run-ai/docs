## Description

Submit a Run:ai Job for execution.

 Syntax notes:

* Flags of type *stringArray* mean that you can add multiple values. You can either separate values with a comma or add the flag twice.


## Examples

All examples assume a Run:ai Project has been set using `runai config project <project-name>`.

Start an interactive Job:

```
runai submit -i ubuntu --interactive --attach -g 1
```

Or

```console
runai submit --name build1 -i ubuntu -g 1 --interactive -- sleep infinity 
```

(see: [build Quickstart](../Walkthroughs/walkthrough-build.md)).

Externalize ports:

```console
runai submit --name build-remote -i rastasheep/ubuntu-sshd:14.04 --interactive \
   --service-type=nodeport --port 30022:22
   -- /usr/sbin/sshd -D
```

(see: [build with ports Quickstart](../Walkthroughs/walkthrough-build-ports.md)).

Start a Training Job

```console
runai submit --name train1 -i gcr.io/run-ai-demo/quickstart -g 1 
```
    
(see: [training Quickstart](../Walkthroughs/walkthrough-train.md)).

Use GPU Fractions

```console
runai submit --name frac05 -i gcr.io/run-ai-demo/quickstart -g 0.5
```

(see: [GPU fractions Quickstart](../Walkthroughs/walkthrough-fractions.md)).

Hyperparameter Optimization

```console
runai submit --name hpo1 -i gcr.io/run-ai-demo/quickstart-hpo -g 1  \
   --parallelism 3 --completions 12 -v /nfs/john/hpo:/hpo 
```

(see: [hyperparameter optimization Quickstart](../Walkthroughs/walkthrough-hpo.md)).

Submit a Job without a name (automatically generates a name)

```console
runai submit -i gcr.io/run-ai-demo/quickstart -g 1 
```

Submit a Job without a name with a pre-defined prefix and an incremental index suffix

```console
runai submit --job-name-prefix -i gcr.io/run-ai-demo/quickstart -g 1 
```

## Options

### Job Type
#### --interactive

> Mark this Job as interactive.

#### --jupyter

> Run a Jupyter notebook using a default image and notebook configuration.

### Job Lifecycle

#### --completions < int >

> Number of successful pods required for this job to be completed. Used with HPO.
      
#### --parallelism < int >
> Number of pods to run in parallel at any given time.  Used with HPO.
      
#### --preemptible
> Interactive preemptible jobs can be scheduled above guaranteed quota but may be reclaimed at any time.

#### --ttl-after-finish < duration >

> The duration, after which a finished job is automatically deleted (e.g. 5s, 2m, 3h).

--8<-- "docs/snippets/common-submit-cli-commands.md"
## Output

The command will attempt to submit a Job. You can follow up on the Job by running `runai list jobs` or `runai describe job <job-name>`.

Note that the submit call may use a *policy* to provide defaults to any of the above flags.

## See Also

*   See any of the Quickstart documents [here:](../Walkthroughs/quickstart-overview.md).
*   See [policy configuration](../../admin/workloads/policies.md) for a description on how policies work.

