
## Description

Show lists of Workloads, Projects, Clusters or Nodes.

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


#### --all-projects | -A
>  Show Workloads from all Projects.

### Global Flags

#### --loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

#### --project | -p (string)
>  Specify the Project to which the command applies. By default, commands apply to the default Project. To change the default Project use ``runai config project <project-name>``.

#### --help | -h

>  Show help text.

## Output

* A list of Workloads, Nodes, Projects, or Clusters. 
* To filter 'runai list nodes' for a specific Node, add the Node name.

## See Also
To show details for a specific Workload or Node see [runai describe](runai-describe.md).


