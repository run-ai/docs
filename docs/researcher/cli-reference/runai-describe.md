## Description

Display details of a Workload or Node.

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

```

## Options

* <job-name\> - The name of the Workload to run the command with. Mandatory.
* <node-name\> - The name of the Node to run the command with. If a Node name is not specified, a description of all Nodes is shown.



-o | --output
>  Output format. One of: json|yaml|wide. Default is 'wide'

### Global Flags

#### --loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

#### --project | -p (string)
>  Specify the Project to which the command applies. By default, commands apply to the default Project. To change the default Project, use: ``runai config project <project-name>``.

#### --help | -h
>  Show help text

## Output

* The `runai describe job` command will show Workload properties and status as well as lifecycle events and the list of related resources and pods.
* The `runai describe node` command will show Node properties. 


