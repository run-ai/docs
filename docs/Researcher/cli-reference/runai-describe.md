## Description

Display details of a training job

## Synopsis

``` shell
runai describe job <job-name> 
    [--output value | -o value]  
    
    [--loglevel value] 
    [--project string | -p string] 
    [--help | -h]
    [--output string | -o string]  


runai describe node [node-name] 
    [--output value | -o value]  
    
    [--loglevel value] 
    [--project string | -p string] 
    [--help | -h]
```

## Options

<job-name\> the name of the Job to run the command with. Mandatory.
<node-name\> the name of the Node to run the command with. If a Node name is not specified, a description of all Nodes is shown.


-o | --output
>  Output format. One of: json|yaml|wide. Default is 'wide'

### Global Flags

--loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info")

--project | -p (string)
>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project, use: ``runai project set <project-name>``.

--help | -h
>  Show help text

## Output

The `runai describe job` command will show the job properties and status as well as lifecycle events and list of pods.
The `runai describe node` command will show the node properties. 

## See Also