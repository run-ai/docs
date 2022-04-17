!!! attention
    * `runai list` has been replaced by `runai list jobs`.
    * `runai clusters list` has been replaced by `runai list clusters`.
    * `runai project list` has been replaced by `runai list projects`.
    * `runai template list` has been replaced by `runai list workloads`.

## Description

Show lists of Jobs, Projects, Clusters, Nodes and Workloads.

## Synopsis

``` shell
runai list jobs 
    [--project string | -p string | --all-projects | -A] 
    [--loglevel value] 
    [--help | -h]

runai list projects 
    [--loglevel value] 
    [--help | -h]

runai list clusters  
    [--loglevel value] 
    [--help | -h]

runai list nodes [node-name]
    [--loglevel value] 
    [--help | -h]

runai list workloads
    [--project string | -p string | --all-projects | -A]
    [--interactive | --inference] 
    [--loglevel value] 
    [--help | -h]
```
## Options
`node-name` - Name of a specific node to list (optional).

* --all-projects | -A 
  > Show Jobs from all Projects.
* --interactive 
  > List interactive workloads (by default only training workloads are included in the result).
* --inference 
  > List deployment workloads (by default only training workloads are included in the result).

### Global Flags

#### --loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

#### --project | -p (string)
>  Specify the Project to which the command applies. By default, commands apply to the default Project. To change the default Project use ``runai config project <project-name>``.

#### --help | -h

>  Show help text.

## Output

* A list of Jobs, Nodes, Projects, Clusters, or Workloads. 
* To filter 'runai list nodes' for a specific Node, add the Node name.

## See Also
* To show details for a specific Job, Node or Workload see [runai describe](runai-describe.md).
* For further information about workloads, see [submitting workloads guide](../../Researcher/submitting/workloads.md).
