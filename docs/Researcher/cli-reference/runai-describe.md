!!! attention
    `runai get` has been replaced by `runai describe job`.

## Description

Display details of a Job, Node or Workload

## Synopsis

``` shell
runai describe job <job-name> 
    [--output value | -o value]  
    [--loglevel value] 
    [--project string | -p string] 
    [--help | -h]
    [--output string | -o string]  


runai describe node [node-name] 
    [--loglevel value] 
    [--help | -h]

runai describe workload <workload-name>
    [--project string | -p string | --all-projects]
    [--interactive|--inference]
    [--loglevel value] 
    [--help | -h]
```

## Options

#### <job-name\> 
  > The name of the Job to run the command with. Mandatory.
#### <node-name\> 
  > The name of the Node to run the command with. If a Node name is not specified, a description of all Nodes is shown.
#### <workload-name\> 
  > The name of the workload related to the job. See [submitting workloads guide](../../Researcher/submitting/workloads.md) for detais).
#### -o | --output 
  > Output format. One of: json|yaml|wide. Default is 'wide'
#### --interactive 
  > Describe information on interactive workloads (by default only training workloads are included in the result).
#### --inference 
  > Describe information on deployment workloads (by default only training workloads are included in the result).

### Global Flags

#### --loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

#### --project | -p (string) | --all-projects
>  Specify the Project to which the command applies. By default, commands apply to the default Project. 
 
To change the default Project, use: ``runai config project <project-name>``.

#### --help | -h
>  Show help text

## Output

* The `runai describe job` command will show Job properties and status as well as lifecycle events and the list of related pods.
* The `runai describe node` command will show Node properties. 
* The `runai describe workload` command will show workload properties. 

## See Also

* See: [submitting workloads guide](../../Researcher/submitting/workloads.md) for further information about workloads.
