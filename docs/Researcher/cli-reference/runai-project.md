## Description

Set a default project
Show a list of available projects

## Synopsis

``` shell

runai project set <project-name>
    [--loglevel value] 
    [--help | -h]

runai project list
    [--loglevel value] 
    [--help | -h]

```
## Options

<project-name\> the name of the project you want to set as default


### Global Flags

--loglevel (string)

> Set the logging level. One of: debug|info|warn|error (default "info")


--help | -h

>  Show help text

## Output

With these two commands you can show a __list__ of available projects as well as to be able to set a __default__ project, thus, removing the need to use the ``--project`` flag on other CLI commands. 

