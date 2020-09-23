## Description

Show list of jobs

## Synopsis

``` shell
runai list <job-name> 
    [--all-projects | -A]  
    
    [--loglevel value] 
    [--project string | -p string] 
    [--help | -h]
```
## Options

<job-name\> the name of the job to run the command in


--all-projects | -A
>  Show jobs from all projects

### Global Flags

--loglevel (string)
>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)
>  Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use``runai project set <project-name>``.

--help | -h

>  Show help text

## Output

A list of jobs will show. To show details for a specific job see [runai get](runai-get.md)

## See Also

