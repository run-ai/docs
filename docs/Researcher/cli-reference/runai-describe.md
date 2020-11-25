!!! attention
    `runai get` has been replaced by `runai describe`.

## Description

Display details of a Job or Node.

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

runai describe template <template-name>
    
    [--loglevel value] 
    [--help | -h]
```

## Options

* <job-name\> - The name of the Job to run the command with. Mandatory.
* <node-name\> - The name of the Node to run the command with. If a Node name is not specified, a description of all Nodes is shown.
* <template-name\> - The name of the Template to run the command on. Mandatory. Templates are a way to reduce the number of flags required when running the command ``runai submit`` and set various defaults. Templates are added by the Administrator.



-o | --output
>  Output format. One of: json|yaml|wide. Default is 'wide'

### Global Flags

--loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

--project | -p (string)
>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project, use: ``runai config project <project-name>``.

--help | -h
>  Show help text

## Output

* The `runai describe job` command will show Job properties and status as well as lifecycle events and the list of related pods.
* The `runai describe node` command will show Node properties. 
* The `runai describe template` command will show Template properties. 


## See Also

See: [Configure Command-Line Interface Templates](../../Administrator/Researcher-Setup/template-config.md) on how to configure Templates.
