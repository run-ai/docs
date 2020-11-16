## Description

Show list of jobs

## Synopsis

``` shell
runai list jobs 
    [--all-projects | -A]  

    [--loglevel value] 
    [--project string | -p string] 
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
```
## Options
`node-name` - Name of a specific node to list (optional).


--all-projects | -A
>  Show jobs from all projects

### Global Flags

--loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info")

--project | -p (string)
>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use``runai project set <project-name>``.

--help | -h

>  Show help text

## Output

A list of Jobs, Nodes, Projects or Clusters. 
To filter 'runai list nodes' for a specific node, add the Node name.

## See Also
To show details for a specific job see [runai describe](runai-describe.md)


